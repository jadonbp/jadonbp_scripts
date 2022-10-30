-- Script Customization Variables
local legacyHighlightStyle = false
local highlightRefreshRate = 0.1
local highlightMaximumDistanceFade = 200
local highlightSizeMultiplier = Vector3.new(1.5, 5, 1.5)
local highlightStringUpper = true
local highlightShowDistance = true
local highlightTextSize = 12.5

--// Notification Settings
local notificationVisibleTime = 3
local notificationDelayTime = 1

--// Player Highlight Settings
local playerHighlightColor = Color3.new(0, 0, 0)
local playerTitleEnabled = true
local playerNotificationIcon = 0

--// Present Highlight Settings
local presentTitleEnabled = true

--// Rat Token Highlight Settings
local ratTokenEspEnabled = false
local ratTokenTitleEnabled = false
local ratTokenIconId = 2240037635
local ratTokenHighlightColor = Color3.new(255, 232, 0)

-- Services
local starterGui = game:GetService("StarterGui")
local players = game:GetService("Players")

-- Player Instances
local localPlayer = players.LocalPlayer
local character = localPlayer.Character or localPlayer.Character:Wait()

-- World References
local passiveNPCsFolder = workspace:WaitForChild("PassiveNPCs")
local strangemanFolder = workspace:WaitForChild("SM")
local spawners = workspace:WaitForChild("Spawners")

-- Misc References
local notificationSound = Instance.new("Sound", starterGui)
local notificationQueueDelay = 0
local highlightInstances = {}
local loadedInstances = {}
local notifications = {}
local highlightInstancesEnabled = true
local playerDead = false
local keybind = "T"

-- BOLO Tables
local npcs = {
    -- TEMPLATE: ["Name"] = { IconId, Color3, TitleEnabled }
    ["Stick"] = { 10110294594, Color3.fromRGB(255, 255, 255), true },
    ["Construct"] = { 9239563034, Color3.fromRGB(255, 10, 10), true },
    ["Junkman"] = { 10110429362, Color3.fromRGB(160, 160, 160), true },
    ["Vhitmire"] = { 10110487180, Color3.fromRGB(51, 0, 102), true },
    ["GreenGolem"] = { 9239651216, Color3.fromRGB(51, 255, 153), true },
    ["Toaster Josh"] = { 9239681004, Color3.fromRGB(102, 0, 204), true },
    ["Giver"] = { 10110548830, Color3.fromRGB(255, 51, 255), true },
}

local harvestables = {
    -- TEMPLATE: ["Name"] = { SpawnerFolder, SpawnerName, IconId, Color3, TitleEnabled }
    --["Boomba Mushroom"] = { {spawners.PineForest_Mushrooms, spawners.Island}, "Spawner_BoombaMushroom", 0, Color3.fromRGB(255, 0, 105) },
    ["Birds Nest"] = { {spawners.Island}, "Spawner_BirdsNest", 0, Color3.fromRGB(255, 112, 112), true },
    ["Rising Star Mushroom"] = { {spawners.Horseshoe_Mushrooms}, "Spawner_RisingStarMushroom", 0, Color3.fromRGB(255, 255, 0), true },
    ["The Object From Earth"] = { {spawners.Horseshoe_Mushrooms}, "Spawner_TheObjectFromEarth", 0, Color3.fromRGB(255, 175, 0), true },
    ["Traveler Plant"] = { {spawners.Horseshoe_Mushrooms}, "Spawner_TravelerPlant", 0, Color3.fromRGB(48, 165, 231), true },
    ["Grateful Frog"] = { {spawners["The Sprutle Frog Expansion_Updated"]}, "Spawner_GratefulFrogs", 0, Color3.fromRGB(88, 213, 126), true },
    ["Pipe Machine"] = { {spawners.Island}, "Spawner_PipeMachine", 0, Color3.fromRGB(112, 112, 112), true },
}

local mobNpcs = { -- Monsters & birds that spawn in NPCs folder (Some are located in their spawner, most are located in Workspace.NPCS)
    -- TEMPLATE: ["Name"] = { IconId, Color3, TitleEnabled }
    --["OgreNPC"] = {0, Color3.fromRGB(125, 255, 125) },
    ["Speevan"] = { 0, Color3.fromRGB(164, 0, 38), true },
    ["Moving Cogger"] = { 0, Color3.fromRGB(124, 87, 84), true },
    ["Glowbird"] = { 0, Color3.fromRGB(164, 0, 38), true },
    ["Keemal"] = { 0, Color3.fromRGB(60, 17, 193), true },
    ["BoomerNPC"] = { 0, Color3.fromRGB(255, 0, 0), true },
    ["SpikerNPC"] = { 0, Color3.fromRGB(255, 0, 0), true },
    ["FarNorthBluemanNPC"] = { 0, Color3.fromRGB(0, 126, 255), true },
    ["BrickfaceNPC"] = { 0, Color3.fromRGB(255, 252, 77), true },
    ["PurpleOgreNPC"] = { 0, Color3.fromRGB(177, 0, 255), true },
    ["GreenFloatingHeadNPC"] = { 0, Color3.fromRGB(158, 255, 0), true },
    ["CosmicFloatingHeadNPC"] = { 0, Color3.fromRGB(158, 255, 0), true },
    ["RatboyNPC"] = { 0, Color3.fromRGB(10, 10, 10), true },
    ["PathGamblerNPC"] = { 0, Color3.fromRGB(217, 32, 14), true },
    ["RunningManNPC"] = { 0, Color3.fromRGB(120, 212, 255), true },
    ["CaughtManNPC"] = { 0, Color3.fromRGB(213, 255, 96), true },
}

local birds = {
    -- TEMPLATE: ["Name"] = { SpawnerFolder, SpawnerName, IconId, Color3, TitleEnabled }
    --["Frester"] = { {spawners["ToppleTown_Birds"], spawners["BeginnerForest_Birds"], spawners['AdvancedForest_Birds'], spawners["FarmFortress_Birds"]}, "Spawner_Bird_Frester", 0, Color3.fromRGB(164, 0, 38) },
    ["Speevan"] = { {spawners["The Sprutle Frog Expansion_Updated"]}, "Spawner_Speeven", 0, Color3.fromRGB(164, 0, 38), true },
    ["Glowbird"] = { {spawners["Horseshoe_Birds"], spawners["Pits_Birds"], spawners["Southside_Birds"]}, "Spawner_Bird_Glow", 0, Color3.fromRGB(164, 0, 38), true },
    ["Keemal"] = { {spawners["Eastside_Birds"]}, "Spawner_Bird_Keemal", 0, Color3.fromRGB(60, 17, 193), true },
}

local anomalies = {
    -- TEMPLATE: ["Name"] = { ModelFolder/Group, MainModelName, IconId, Color3, TitleEnabled }
    ["Rabbit Hole"] = { workspace:WaitForChild("RabbitholeEntrance"), "Model", 0, Color3.fromRGB(31, 0, 51), true },
    ["Strangeman"] = { workspace:WaitForChild("SM"), "Door_SMEntrance", 0, Color3.fromRGB(222, 0, 255), true },
	["Pitfall"] = { workspace, "PitfallEntrance", 0, Color3.new(103, 55, 145), true },
}

-- Player Functionality

character:WaitForChild("Humanoid").Died:Connect(function()
    playerDead = true
end)

localPlayer.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    playerDead = false
    if character:WaitForChild("Fogbox"):WaitForChild("Ring1"):FindFirstChild("Mesh") ~= nil then
        for _, part in pairs(character:WaitForChild("Fogbox"):GetChildren()) do
            if part:IsA("BasePart") and part:FindFirstChild("Mesh") ~= nil then
                --// Pre-Existing Meshes
                part.Mesh:Destroy()
            end
        end
        printconsole("FF-ESP: Fogbox removed!", 0, 255, 0)
        --task.spawn(sendNotification, "Fogbox Removed!", "Your visibility was increased, enjoy the limitless view of the frontier!", 10110170391, "Dismiss", "", false, 1)
    else
        printconsole("FF-ESP: There was an error removing Fogbox!", 255, 0, 0)
    end
end)

-- Functions

local function sendNotification(title, text, icon, button1, button2, soundId, volume)
    --// Notification Sound, Setup & Call
    --local notificationCallback = Instance.new("BindableFunction")
    if soundId == false or soundId == nil or soundId == 0 then
        notificationSound.SoundId =  "rbxassetid://6696469190"
    else
        notificationSound.SoundId = "rbxassetid://"..soundId
    end
    notificationSound.Volume = volume
    notificationSound:Play()
    starterGui:SetCore("SendNotification", {
	    Title = title,
	    Text = text,
	    Icon = "rbxthumb://type=Asset&id="..icon.."&w=150&h=150",
	    Duration = notificationVisibleTime,
	    Callback = nil, --notificationCallback,
	    Button1 = button1,
	    Button2 = button2
    })
    --[[// Notification Button Response
    function notificationCallback.OnInvoke(response)
        if response == "Dismiss" then
            return
        end
    end
    --// Notification Packup
    delay(notificationVisibleTime, function()
        --notificationQueueDelay = notificationQueueDelay - notificationVisibleTime
        notificationCallback:Destroy()
        notificationCallback = nil
        notificationId = nil
        table.remove(notifications, table.find(notifications, notificationId))
    end)]]
end

local function createHighlight(part, title, icon, color, tagEnabled)
    --// Highlight Duplicate Check
    if part:FindFirstChild("BoxHandleAdornment") ~= nil or part:FindFirstChild("Highlight") ~= nil then
        return
    end
    
    --// Highlight Setup
    local highlight
    if legacyHighlightStyle then
        local highlightSize
        local highlightAdornee
        if part:IsA("Model") then
            highlightAdornee = part:FindFirstChild("HumanoidRootPart") or part.PrimaryPart or part:FindFirstChildWhichIsA("BasePart")
            highlightSize = part:GetExtentsSize() * highlightSizeMultiplier
        else
            highlightAdornee = part
            highlightSize = part.Size * highlightSizeMultiplier
        end
        highlight = Instance.new("BoxHandleAdornment", part)
        highlight.Size = highlightSize
        highlight.AlwaysOnTop = true
        highlight.Adornee = highlightAdornee
        highlight.Color3 = color
        highlight.Visible = highlightInstancesEnabled
        highlight.Transparency = 0.5
        highlight.ZIndex = 1
    elseif not legacyHighlightStyle then
        local h, s, v = color:ToHSV()
        highlight = Instance.new("Highlight", part)
        highlight.Adornee = part
    	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    	highlight.Enabled = highlightInstancesEnabled
    	highlight.FillColor = color
    	highlight.FillTransparency = 0
    	highlight.OutlineColor = Color3.fromHSV(h, s, math.clamp(v - 0.1, 0, 1))
    	highlight.OutlineTransparency = 0.1
    end
    table.insert(highlightInstances, highlight)
    
    --// BillboardGui Setup
    local billboardGui
    local textLabel
    if tagEnabled then
        billboardGui = Instance.new("BillboardGui", part)
        billboardGui.Size = UDim2.new(0, 200, 0, 50)
        billboardGui.AlwaysOnTop = true
        billboardGui.Enabled = highlightInstancesEnabled
        billboardGui.Adornee = highlightAdornee
        billboardGui.LightInfluence = 0
        if legacyHighlightStyle then
            billboardGui.StudsOffsetWorldSpace = Vector3.new(0, (highlight.Size.Y / 1.5), 0)
        elseif not legacyHighlightStyle then
            if part:IsA("Model") then
                billboardGui.StudsOffsetWorldSpace = Vector3.new(0, (part:GetExtentsSize().Y / 1.5), 0)
            else
                billboardGui.StudsOffsetWorldSpace = Vector3.new(0, (part.Size.Y / 1.5), 0)
            end
        end
        
        --// TextLabel Setup
        textLabel = Instance.new("TextLabel", billboardGui)
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Font = Enum.Font.Roboto
        textLabel.TextColor3 = color
        textLabel.TextSize = highlightTextSize
        textLabel.TextWrapped = true
        
        --// Highlight Visual Settings
        if highlightStringUpper then
            textLabel.Text = string.upper(title)
        elseif not highlightStringUpper then
            textLabel.Text = title
        end
    end
    table.insert(highlightInstances, billboardGui)
    
    --// Highlight Transparency Calculations
    while wait(highlightRefreshRate) do
        if not playerDead then
            local highlightTransparency
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            if legacyHighlightStyle then
                highlightTransparency = math.clamp(((highlightMaximumDistanceFade - (humanoidRootPart.Position - highlightAdornee.Position).magnitude) / highlightMaximumDistanceFade), 0.05, 0.95)
                highlight.Transparency = highlightTransparency
            elseif not legacyHighlightStyle then
                if part:IsA("Model") then
                    highlightTransparency = math.clamp(((highlightMaximumDistanceFade - (humanoidRootPart.Position - part:GetPivot().Position).magnitude) / highlightMaximumDistanceFade), 0.05, 0.95)
                else
                    highlightTransparency = math.clamp(((highlightMaximumDistanceFade - (humanoidRootPart.Position - part.Position).magnitude) / highlightMaximumDistanceFade), 0.05, 0.95)
                end
                highlight.FillTransparency = highlightTransparency
            end
            if tagEnabled and highlightShowDistance then
                textLabel.TextTransparency = highlightTransparency
                if part:IsA("Model") then
                    if highlightStringUpper then
                        textLabel.Text = string.upper(title.."  |  "..math.floor((humanoidRootPart.Position - part:GetPivot().Position).magnitude + 0.5).." studs")
                    elseif not highlightStringUpper then
                        textLabel.Text = title.."  |  "..math.floor((humanoidRootPart.Position - part:GetPivot().Position).magnitude + 0.5).." studs"
                    end
                else
                    if highlightStringUpper then
                        textLabel.Text = string.upper(title.."  |  "..math.floor((humanoidRootPart.Position - part.Position).magnitude + 0.5).." studs")
                    elseif not highlightStringUpper then
                        textLabel.Text = title.."  |  "..math.floor((humanoidRootPart.Position - part.Position).magnitude + 0.5).." studs"
                    end
                end
            end
        else
            repeat
                wait(highlightRefreshRate)
            until not playerDead
        end
    end
    
    --// Removed Highlights
    highlight.Parent.AncestryChanged:Connect(function(child, parent)
        if not parent then
            table.remove(highlightInstances, table.find(highlightInstances, highlight))
        end
    end)
end

-- Functionality

--// Remove Fogbox (For already loaded character)
if character:WaitForChild("Fogbox"):WaitForChild("Ring1"):FindFirstChild("Mesh") ~= nil then
    for _, part in pairs(character:WaitForChild("Fogbox"):GetChildren()) do
        if part:IsA("BasePart") and part:FindFirstChild("Mesh") ~= nil then
            --// Pre-Existing Meshes
            part.Mesh:Destroy()
        end
    end
    printconsole("FF-ESP: Fogbox removed!", 0, 255, 0)
    task.spawn(sendNotification, "Fogbox Removed!", "Your visibility was increased, enjoy the limitless view of the frontier!", 10110170391, "Dismiss", "", false, 1)
else
    printconsole("FF-ESP: There was an error removing Fogbox!", 255, 0, 0)
end

--// Presents
local function InitiatePresent(present)
    if present:FindFirstChild("PP") and table.find(loadedInstances, present) == nil then
        printconsole("FF-ESP: Present was found loaded", 0, 255, 0)
        table.insert(loadedInstances, present)
        task.spawn(createHighlight, present, "Present", 10111334770, Color3.new(0, 255, 255), presentTitleEnabled)
        task.spawn(sendNotification, "Otherworld Present Found!", "A present has been found near you, look for its yellow highlight!", 10111334770, "Dismiss", "", false, 1)
    else
        printconsole("FF-ESP: Unable to find Present loaded, waiting...", 255, 0, 0)
        local waitForPresent
        waitForPresent = present.ChildAdded:Connect(function(child)
            if child:IsA("BasePart") and child.Name == "PP" and table.find(loadedInstances, present) == nil then
                printconsole("FF-ESP: Game loaded Present", 0, 255, 0)
                table.insert(loadedInstances, present)
                task.spawn(createHighlight, present, "Present", 10111334770, Color3.new(0, 255, 255), presentTitleEnabled)
                task.spawn(sendNotification, "Otherworld Present Found!", "A present has been found near you, look for its yellow highlight!", 10111334770, "Dismiss", "", false, 1)
                waitForPresent:Disconnect()
            end
        end)
    end
end
--// Pre-Existing Presents
for presentNumber = 1, 5, 1 do
    if workspace:FindFirstChild("Present"..presentNumber) ~= nil then
       task.spawn(InitiatePresent, workspace:WaitForChild("Present"..presentNumber))
    end
end
--// Added Presents
workspace.ChildAdded:Connect(function(child)
    if child:IsA("Model") and string.gsub(child.Name, "%d", "") == "Present" then
        task.spawn(InitiatePresent, child)
    end
end)
--// Removed Presents & Workspace General
workspace.ChildRemoved:Connect(function(child)
    if table.find(loadedInstances, child) ~= nil then
        table.remove(loadedInstances, table.find(loadedInstances, child))
    end
end)

--// Traveling Entities
local function InitiateEntity(index, value)
    local entity = passiveNPCsFolder:WaitForChild("NPC_"..index)
    if entity:FindFirstChild("HumanoidRootPart") ~= nil and table.find(loadedInstances, entity) == nil then
        printconsole("FF-ESP: "..tostring(index).." was found loaded", 0, 255, 0)
        table.insert(loadedInstances, entity)
        task.spawn(createHighlight, entity, index, value[1], value[2], value[3])
        task.spawn(sendNotification, index.." Found!", "A traveling entity has been discovered, look for its highlight!", value[1], "Dismiss", "", false, 1)
    else
        printconsole("FF-ESP: Unable to find "..tostring(index).." loaded, waiting...", 255, 0, 0)
        local waitForEntity
        waitForEntity = entity.ChildAdded:Connect(function(child)
            if (child.Name == "HumanoidRootPart" or entity:FindFirstChild("HumanoidRootPart") ~= nil) and table.find(loadedInstances, entity) == nil then
                printconsole("FF-ESP: Game loaded "..tostring(index), 0, 255, 0)
                table.insert(loadedInstances, entity)
                task.spawn(createHighlight, entity, index, value[1], value[2], value[3])
                task.spawn(sendNotification, index.." Found!", "A traveling entity has been discovered, look for its highlight!", value[1], "Dismiss", "", false, 1)
                waitForEntity:Disconnect()
            end
        end)
    end
end
for index, value in pairs(npcs) do -- TIP: IND-1 = Name, IND-2 = Icon, IND-3 = Color
    printconsole("FF-ESP: Searching for entity "..tostring(index))
    -- Pre-Existing Entities
    if passiveNPCsFolder:FindFirstChild("NPC_"..index) ~= nil then
        printconsole("FF-ESP: Found "..tostring(index), 0, 255, 0)
        task.spawn(InitiateEntity, index, value)
    else
        --// Added Entities
        printconsole("FF-ESP: Unable to find "..tostring(index).." loaded, waiting...", 255, 0, 0)
        local waitForEntity
        waitForEntity = passiveNPCsFolder.ChildAdded:Connect(function(child)
            if child.Name == "NPC_"..index then
                printconsole("FF-ESP: Discovered "..tostring(index), 0, 255, 0)
                task.spawn(InitiateEntity, index, value)
                waitForEntity:Disconnect()
            end
        end)
    end
end
--// Removed Entities
passiveNPCsFolder.ChildRemoved:Connect(function(child)
    if table.find(npcs, string.gsub(child.Name, "NPC_", "")) ~= nil and table.find(loadedInstances, child) ~= nil then
        printconsole("FF-ESP: Game removed "..tostring(child.Name), 255, 0, 0)
        table.remove(loadedInstances, table.find(loadedInstances, child))
        local save = child.Name
        local waitForEntity
        waitForEntity = passiveNPCsFolder.ChildAdded:Connect(function(child)
            if child.Name == save then
                task.spawn(InitiateEntity, string,gsub(save, "NPC_", ""), table.find(npcs, string,gsub(save, "NPC_", "")))
                waitForEntity:Disconnect()
            end
        end)
    end
end)

--// Harvestables
local function InitiateHarvestable(harvestable, index, value)
    if harvestable:FindFirstChild("PP") ~= nil and table.find(loadedInstances, harvestable) == nil then
        printconsole("FF-ESP: Discovered "..tostring(harvestable.Parent.Name), 0, 255, 0)
        table.insert(loadedInstances, harvestable)
        task.spawn(createHighlight, harvestable, index, value[3], value[4], value[5])
        task.spawn(sendNotification, index.." Found!", "A harvestable has been found near you, look for its highlight!", value[3], "Dismiss", "", false, 1)
    else
        printconsole("FF-ESP: Unable to find "..tostring(harvestable.Parent.Name).." loaded, waiting...", 255, 0, 0)
        local waitForHarvestable
        waitForHarvestable = harvestable.ChildAdded:Connect(function(child)
            if (child.Name == "PP" or harvestable:FindFirstChild("PP") ~= nil) and table.find(loadedInstances, harvestable) == nil then
                printconsole("FF-ESP: Discovered "..tostring(harvestable.Parent.Name), 0, 255, 0)
                table.insert(loadedInstances, harvestable)
                task.spawn(createHighlight, harvestable, index, value[3], value[4], value[5])
                task.spawn(sendNotification, index.." Found!", "A harvestable has been found near you, look for its highlight!", value[3], "Dismiss", "", false, 1)
                waitForHarvestable:Disconnect()
            end
        end)
    end
end
for index, value in pairs(harvestables) do
    local function connectSpawner(spawner)
        --// Pre-Existing Harvestables
        for _, child in pairs(spawner:GetChildren()) do
            if child:IsA("Model") and child.Name == "Collectible" then
                task.spawn(InitiateHarvestable, child, index, value)
            end
        end
        --// Added Harvestables
        spawner.ChildAdded:Connect(function(child)
            if child:IsA("Model") and child.Name == "Collectible" then
                task.spawn(InitiateHarvestable, child, index, value)
            end
        end)
        --// Removed Harvestables
        spawner.ChildRemoved:Connect(function(child)
            if child:IsA("Model") and child.Name == "Collectible" and table.find(loadedInstances, child) ~= nil then
                table.remove(loadedInstances, table.find(loadedInstances, child))
            end
        end)
    end
    
    for _, spawnCollection in pairs(value[1]) do
        if spawnCollection:FindFirstChild(value[2]) then
            printconsole("FF-ESP: Discovered "..value[2].."(s)", 0, 255, 0)
            for _, spawner in pairs(spawnCollection:GetChildren()) do
                if spawner.Name == value[2] then
                    task.spawn(connectSpawner, spawner)
                end
            end
        else
            printconsole("FF-ESP: Unable to find "..value[2].."(s) loaded, waiting...", 255, 0, 0)
            task.spawn(function()
                local waitForSpawner
                waitForSpawner = spawnCollection.ChildAdded:Connect(function(child)
                    if child.Name == value[2] then
                        printconsole("FF-ESP: Game loaded "..value[2].."(s)", 0, 255, 0)
                        for _, spawner in pairs(spawnCollection:GetChildren()) do
                            if spawner.Name == value[2] then
                                task.spawn(connectSpawner, spawner)
                            end
                        end
                        waitForSpawner:Disconnect()
                    end
                end)
            end)
        end
    end
end

--// Birds
local function InitiateBird(bird, index, value)
    if bird:FindFirstChild("Hitbox") and table.find(loadedInstances, bird) == nil then
        printconsole("FF-ESP: Discovered "..tostring(index), 0, 255, 0)
        table.insert(loadedInstances, bird)
        task.spawn(createHighlight, bird, index, value[3], value[4], value[5])
        task.spawn(sendNotification, index.." Found!", "A bird has been found near you, look for its highlight!", value[3], "Dismiss", "", false, 1)
    else
        printconsole("FF-ESP: Unable to find "..index.." loaded, waiting...", 255, 0, 0)
        local waitForBird
        waitForBird = bird.ChildAdded:Connect(function(child)
            if (child.Name == "Hitbox" or bird:FindFirstChild("Hitbox") ~= nil) and table.find(loadedInstances, bird) == nil then
                printconsole("FF-ESP: Game loaded "..index, 0, 255, 0)
                table.insert(loadedInstances, bird)
                task.spawn(createHighlight, bird, index, value[3], value[4], value[5])
                task.spawn(sendNotification, index.." Found!", "A bird has been found near you, look for its highlight!", value[3], "Dismiss", "", false, 1)
                waitForBird:Disconnect()
            end
        end)
    end
    bird.Parent.ChildRemoved:Connect(function(child)
        if child.Name == index and table.find(loadedInstances, bird) ~= nil then
            table.remove(loadedInstances, table.find(loadedInstances, bird))
        end
    end)
end
for index, value in pairs(birds) do
    local function connectSpawner(spawner)
        --// Pre-Esixting Birds
        for _, child in pairs(spawner:GetChildren()) do
            if child:IsA("Model") and child.Name == index then
                printconsole("FF-ESP: Discovered "..tostring(index), 0, 255, 0)
                task.spawn(InitiateBird, child, index, value)
            end
        end
        --// Added Birds
        spawner.ChildAdded:Connect(function(child)
            if child:IsA("Model") and birds[child.Name] ~= nil then
                printconsole("FF-ESP: Discovered "..tostring(index), 0, 255, 0)
                task.spawn(InitiateBird, child, index, value)
            end
        end)
    end
    
    for _, spawnCollection in pairs(value[1]) do
        if spawnCollection:FindFirstChild(value[2]) then
            printconsole("FF-ESP: Discovered "..value[2].."(s)", 0, 255, 0)
            for _, spawner in pairs(spawnCollection:GetChildren()) do
                if spawner.Name == value[2] then
                    task.spawn(connectSpawner, spawner)
                end
            end
        else
            printconsole("FF-ESP: Unable to find "..value[2].."(s) loaded, waiting...", 255, 0, 0)
            task.spawn(function()
                local waitForSpawner
                waitForSpawner = spawnCollection.ChildAdded:Connect(function(child)
                    if child.Name == value[2] then
                        printconsole("FF-ESP: Game loaded "..value[2].."(s)", 0, 255, 0)
                        for _, spawner in pairs(spawnCollection:GetChildren()) do
                            if spawner.Name == value[2] then
                                task.spawn(connectSpawner, spawner)
                            end
                        end
                        waitForSpawner:Disconnect()
                    end
                end)
            end)
        end
    end
end

--// NPCs
local function InitiateNPC(npc, index, value)
    if (npc:FindFirstChild("Head") or npc:FindFirstChild("Hitbox")) and table.find(loadedInstances, npc) == nil then
        printconsole("FF-ESP: Discovered "..tostring(index), 0, 255, 0)
        table.insert(loadedInstances, npc)
        task.spawn(createHighlight, npc, index, value[1], value[2], value[3])
        task.spawn(sendNotification, index.." Found!", "An NPC has been found near you, look for its highlight!", value[1], "Dismiss", "", false, 1)
    else
        printconsole("FF-ESP: Unable to find "..index.." loaded, waiting...", 255, 0, 0)
        local waitForNPC
        waitForNPC = npc.ChildAdded:Connect(function(child)
            if (child.Name == "Head" or npc:FindFirstChild("Head") ~= nil or child.Name == "Hitbox" or npc:FindFirstChild("Hitbox")) and table.find(loadedInstances, npc) == nil then
                printconsole("FF-ESP: Game loaded "..index, 0, 255, 0)
                table.insert(loadedInstances, npc)
                task.spawn(createHighlight, npc, index, value[1], value[2], value[3])
                task.spawn(sendNotification, index.." Found!", "An NPC has been found near you, look for its highlight!", value[1], "Dismiss", "", false, 1)
                waitForNPC:Disconnect()
            end
        end)
    end
    --// Removed NPCs
    npc.Parent.ChildRemoved:Connect(function(child)
        if child.Name == index and table.find(loadedInstances, npc) ~= nil then
            table.remove(loadedInstances, table.find(loadedInstances, npc))
        end
    end)
end
--// Pre-Existing NPCs
for _, child in pairs(workspace.NPCS:GetChildren()) do
    if child:IsA("Model") and mobNpcs[child.Name] ~= nil then
        printconsole("FF-ESP: Discovered "..tostring(child.Name), 0, 255, 0)
        task.spawn(InitiateNPC, child, child.Name, mobNpcs[child.Name])
    end
end
--// Added NPCs
workspace.NPCS.ChildAdded:Connect(function(child)
    if child:IsA("Model") and mobNpcs[child.Name] ~= nil then
        printconsole("FF-ESP: Discovered "..tostring(child.Name), 0, 255, 0)
        task.spawn(InitiateNPC, child, child.Name, mobNpcs[child.Name])
    end
end)

--// Traveling anomalies
local function InitiateAnomaly(anomaly, index, value)
    if anomaly:FindFirstChild("PP") ~= nil and table.find(loadedInstances, anomaly) == nil then
        table.insert(loadedInstances, value[1])
        task.spawn(createHighlight, anomaly, index, value[3], value[4], value[5])
        task.spawn(sendNotification, index.." Found!", "An anomaly has been found near you, look for its highlight!", value[3], "Dismiss", "", false, 1)
    else
        local waitForAnomaly
        waitForAnomaly = anomaly.ChildAdded:Connect(function(child)
            if (child.Name == "PP" or anomaly:FindFirstChild("PP") ~= nil) and table.find(loadedInstances, anomaly) == nil then
                table.insert(loadedInstances, anomaly)
                task.spawn(createHighlight, anomaly, index, value[3], value[4], value[5])
                task.spawn(sendNotification, index.." Found!", "An anomaly has been found near you, look for its highlight!", value[3], "Dismiss", "", false, 1)
                waitForAnomaly:Disconnect()
            end
        end)
    end
end
for index, value in pairs(anomalies) do
    if value[1]:FindFirstChild(value[2]) then
        printconsole("FF-ESP: Discovered "..tostring(value[1][value[2]].Name), 0, 255, 0)
        task.spawn(InitiateAnomaly, value[1][value[2]], index, value)
    else
        local waitForAnomaly
        waitForAnomaly = value[1].ChildAdded:Connect(function(child)
            if child.Name == value[2] then
                printconsole("FF-ESP: Discovered "..tostring(child.Name), 0, 255, 0)
                task.spawn(InitiateAnomaly, child, index, value)
                waitForAnomaly:Disconnect()
            end
        end)
    end
end

--// Players
local function InitiatePlayer(player)
    if player ~= localPlayer then
        local playerCharacter = player.Character or player.CharacterAdded:Wait()
        task.spawn(createHighlight, playerCharacter, player.Name, playerNotificationIcon, playerHighlightColor, playerTitleEnabled)
        task.spawn(sendNotification, "Player Found!", "A player has been found near you, look for its highlight!", playerNotificationIcon, "Dismiss", "", false, 1)
        --// Player Respawn
        playerCharacter:WaitForChild("Humanoid").Died:Connect(function()
            local waitForPlayer
            waitForPlayer = player.CharacterAdded:Connect(function(newPlayerCharacter)
                playerCharacter = newPlayerCharacter
                task.spawn(createHighlight, playerCharacter, player.Name, playerNotificationIcon, playerHighlightColor, playerTitleEnabled)
                waitForPlayer:Disconnect()
            end)
        end) 
    end
end
for _, player in pairs(players:GetPlayers()) do
    InitiatePlayer(player)
end
--// Added Players
players.PlayerAdded:Connect(InitiatePlayer)

-- Rat Tokens
if ratTokenEspEnabled then
    local function InitiateToken(token)
        if token.Holder.RatTokenModel:FindFirstChild("PP") then
            table.insert(loadedInstances, token)
            task.spawn(createHighlight, token, "Rat Token", ratTokenIconId, ratTokenHighlightColor, ratTokenTitleEnabled)
            task.spawn(sendNotification, "Rat Token Found!", "A rat token has been found near you, look for its highlight!", ratTokenIconId, "Dismiss", "", false, 1)
        else
            local waitForToken
            waitForToken = token.Holder.RatTokenModel.ChildAdded:Connect(function(child)
                if (child.Name == "PP" or token.Holder.RatTokenModel:FindFirstChild("PP") ~= nil) and table.find(loadedInstances, token) == nil then
                    table.insert(loadedInstances, token)
                    task.spawn(createHighlight, token, "Rat Token", ratTokenIconId, ratTokenHighlightColor, ratTokenTitleEnabled)
                    task.spawn(sendNotification, "Rat Token Found!", "A rat token has been found near you, look for its highlight!", ratTokenIconId, "Dismiss", "", false, 1)
                    waitForToken:Disconnect()
                end
            end)
        end
    end
    --// Pre-Existing Tokens
    for _, token in pairs(workspace:WaitForChild("Folder"):GetChildren()) do
        if token:IsA("Model") and token.Name == "RatToken_D" then
            task.spawn(InitiateToken, token)
        end
    end
    --// Added Tokens
    workspace:WaitForChild("Folder").ChildAdded:Connect(function(child)
        if child:IsA("Model") and child.Name == "RatToken_D" then
            task.spawn(InitiateToken, child)
        end
    end)
    --// Removed Tokens
    workspace:WaitForChild("Folder").ChildRemoved:Connect(function(child)
        if child:IsA("Model") and child.Name == "RatToken_D" and table.find(loadedInstances, child) ~= nil then
            table.remove(loadedInstances, table.find(loadedInstances, child))
        end
    end)
end

--// Highlight Toggle
game:GetService('UserInputService').InputBegan:connect(function(key, gameProcessedEvent)
    if key.KeyCode == Enum.KeyCode[keybind] then
        highlightInstancesEnabled = not highlightInstancesEnabled
        printconsole("FF-ESP: Highlight instances visibility set to "..tostring(highlightInstancesEnabled), 0, 255, 0)
        
        for _, instance in pairs(highlightInstances) do
            if instance:IsA("Highlight") or instance:IsA("BillboardGui") then
                instance.Enabled = highlightInstancesEnabled
            else
                instance.Visible = highlightInstancesEnabled
            end
        end
    end
end)