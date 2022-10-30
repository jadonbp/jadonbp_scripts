
-- Setup Locals

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local character = player.Character or player.CharacterAdded:Wait()
local torso = character:WaitForChild("Torso")
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local pathfindingService = game:GetService("PathfindingService")
local gameWorkspace = game:GetService("Workspace")
local tweenService = game:GetService("TweenService")
local currentCamera = gameWorkspace.Camera
local guttermouthFolder = gameWorkspace:WaitForChild("Guttermouth")
local room4 = guttermouthFolder:WaitForChild("GuttermouthRoom4")
local monstersFolder = room4:WaitForChild("Monsters")
local enterDoorRoom4 = guttermouthFolder:WaitForChild("Door_GuttermouthPhantom (Hidden Key)")
local exitDoorRoom4 = room4:WaitForChild("GutterExit")

--local phantomKnightNPC = monstersFolder:FindFirstChild("PhantomKnightNPC")
local guttermouthEnterEvent = enterDoorRoom4:FindFirstChild("InteractEvent")
local guttermouthExitEvent = exitDoorRoom4:FindFirstChild("InteractEvent")
local guttermouthClaimRewardsFunction = room4:FindFirstChild("ClaimRewards")
local sellEvent = game:GetService("ReplicatedStorage").Events:WaitForChild("SellShop")

local minimumItemValue = 50000 --// Minimum value of item that needs to be met for an item or else it will be dropped, 0 = all items
local interactCoolDownTime = 2 --// Cooldown time after user interacted with something, such as a door
local onFunctionCallWaitTime = 1 --// Cooldown time before a function gets to work when called, (e.g. wait before enter Guttermouth function runs)
local actionCoolDownTime = 1 --// Cooldowntime for actions such as calling remote after Teleporting or Pathfinding, time between automated inputs, etc
local isInGuttermouth = false
local obstaclesRemoved = false
local isRunning = false
local isSelling = false
local Keybind = "M"

-- Tables

--local lastOpenInventorySlot = "S11"

local inventorySlots = {
    --["slotId"] = canSell?
    ["S01"] = true;
    ["S02"] = true;
    ["S03"] = true;
    ["S04"] = true;
    ["S05"] = true;
    ["S06"] = true;
    ["S07"] = true;
    ["S08"] = true;
    ["S09"] = true;
    ["S10"] = true;
    ["S11"] = true;
    ["S12"] = true;
    ["S13"] = true;
    ["S14"] = true;
    ["S15"] = true;
    ["S16"] = true;
    ["S17"] = true;
    ["S18"] = true;
    ["S19"] = false;
    ["S20"] = false;
}


-- Ready Game

--// Remove Doors
local function removeObstacles()
    if workspace:FindFirstChild("AnimDoors") then
        workspace:FindFirstChild("AnimDoors"):Destroy()
    end
    
    local function isDoorFrame(instance)
        if instance:IsA("Model") and instance.Name == "Model" then
            local children = instance:GetChildren()
            if #children == 3 then
                return true
            else
                return false
            end
        else
            return false
        end
    end
    
    for _, child in pairs(game.Workspace:GetChildren()) do
        if isDoorFrame(child) then
            child:Destroy()
        end
    end
    
    for _, child in pairs(game.Workspace:WaitForChild("MansionChunk"):GetChildren()) do
        if isDoorFrame(child) then
            child:Destroy()
        end
    end
    obstaclesRemoved = true
    printconsole("Autofarm: Map prepared!", 0, 255, 0)
end

--

local function pathfindCharTo(position)
    printconsole("Autofarm: Pathfinding...", 124, 255, 124)
    repeat
        local pathCalculated = pathfindingService:CreatePath()
        local success, errorMessage = pcall(function()
		    pathCalculated:ComputeAsync(character.PrimaryPart.Position, position)
	    end)
        local pathWaypoints = pathCalculated:GetWaypoints()
        
        if success then
            for _, waypoint in pairs(pathWaypoints) do
            if humanoid.Sit then
                humanoid.Jump = true
            end
            if waypoint.Action == Enum.PathWaypointAction.Jump then
                humanoid.Jump = true
            end
            character:SetPrimaryPartCFrame(CFrame.new(waypoint.Position + Vector3.new(0, 3, 0)) * CFrame.Angles(math.rad(torso.Orientation.X), math.rad(torso.Orientation.Y), math.rad(torso.Orientation.Z)))
            wait(0.1)
            end
        else
            printconsole(tostring(errorMessage), 255, 0, 0)
            return
        end
        
    until (torso.Position - position).Magnitude <= 10
    printconsole("Autofarm: Pathfinding Complete!", 0, 255, 0)
    return
end

-- Auto-Farm Phases

local function autoFarmPhase1()
    wait(onFunctionCallWaitTime)
    if isSelling == false then
        if humanoidRootPart.Position ~= Vector3.new(5858.60645, 156.82991, 4906.04199) then
            pathfindCharTo(Vector3.new(5858.60645, 156.82991, 4906.04199))
            wait(0.1)
        end
        guttermouthEnterEvent:FireServer()
        isInGuttermouth = true
    elseif isSelling == true then
        return
    end
end

local function autoFarmPhase0()
    wait(onFunctionCallWaitTime)
    if isSelling == false then
        pathfindCharTo(Vector3.new(12522.4131, 251.514023, -2349.00757))
        wait(0.1)
        guttermouthExitEvent:FireServer()
        isInGuttermouth = false
        printconsole("Autofarm: Exited GuttermouthRoom4!")
        autoFarmPhase1()
    elseif isSelling == true then
        return
    end
end

local function autoFarmPhase2(child)
    if isRunning == true and child.Name == "PhantomKnightNPC" then
        printconsole("Autofarm: Lost Boss found!")
        wait(0.1)
        child:WaitForChild("Humanoid").Health = 0
        printconsole("Autofarm: Lost Boss killed!")
    end
end

local function autoFarmPhase3(child)
    if isRunning == true and child.Name == "GuttermouthChest" then
        printconsole("Autofarm: Reward chest found!")
        pathfindCharTo(Vector3.new(12543.1143, 254.957916, -2361.84985))
        wait(actionCoolDownTime)
        printconsole("Autofarm: Claiming rewards...")
        guttermouthClaimRewardsFunction:InvokeServer()
        printconsole("Autofarm: Rewards claimed!")
        child:Destroy()
        autoFarmPhase0()
    end
end


-- Functions

local function initiateItemSell()
    if isSelling == true and isRunning == true then
        
        --// Auto-Sell Setup
        --isSelling = true
        printconsole("Autofarm: Selling initiated", 200, 200, 255)
        wait(onFunctionCallWaitTime)
        printconsole("Autofarm: Selling items...", 124, 124, 255)
        
        --//Exit Pathfinding
        pathfindCharTo(workspace["Door_Base_Far_Mansion1-Grandhall"].DoorBrick.Position)
        wait(actionCoolDownTime)
        workspace["Door_Base_Far_Mansion1-Grandhall"].InteractEvent:FireServer()
        wait(interactCoolDownTime)
        if not obstaclesRemoved then
            removeObstacles()
        end
        pathfindCharTo(Vector3.new(7180.32, 155.16, -1745.06))
        wait(actionCoolDownTime)
        character:SetPrimaryPartCFrame(CFrame.new(Vector3.new(7127.10, 143.12, -1729.14)) * CFrame.Angles(math.rad(torso.Orientation.X), math.rad(torso.Orientation.Y), math.rad(torso.Orientation.Z)))
        wait(actionCoolDownTime)
        pathfindCharTo(Vector3.new(7007.28, 144.12, -1580.288))
        wait(actionCoolDownTime)
        character:SetPrimaryPartCFrame(CFrame.new(7006.71387, 142.588806, -1577.09192, 0.999590039, -8.86583002e-05, 0.0286326092, -3.15592624e-05, 0.999991238, 0.00419814559, -0.0286327302, -0.00419732695, 0.999581277))
        keypress(0x51)
        keyrelease(0x51)
        wait(2)
        keypress(0x45)
        wait(actionCoolDownTime)
        keyrelease(0x45)
        keypress(0x51)
        keyrelease(0x51)
        wait(5)
        pathfindCharTo(Vector3.new(717.44, 235.24, -482.66))
        wait(actionCoolDownTime)
        
        --// Sell Items
        for _, slot in pairs(player:WaitForChild("Inventory"):GetChildren()) do
            if inventorySlots[slot.Name] == true then
                sellEvent:FireServer(slot.Value, workspace.Shops.Sellers, slot.Quantity.Value)
            end
        end
        
        --// Re-enter Pathfinding
        wait(actionCoolDownTime)
        pathfindCharTo(Vector3.new(776.82, 205.98, -190.20))
        wait(actionCoolDownTime)
        workspace.PassiveNPCs.NPC_GiantRatboy.InteractEvent:FireServer()
        wait(interactCoolDownTime)
        mouse1press()
        wait(interactCoolDownTime)
        mouse1press()
        wait(11)
        pathfindCharTo(Vector3.new(7127.10, 143.12, -1729.14))
        wait(actionCoolDownTime)
        character:SetPrimaryPartCFrame(CFrame.new(7180.22021, 155.129623, -1745.43359, -0.999880433, 5.26826334e-05, -0.0154604223, -1.19906363e-05, 0.999991238, 0.00418203464, 0.0154605079, 0.00418171939, -0.999871671))
        wait(2)
        pathfindCharTo(Vector3.new(7318.39, 148.21, -1757.06))
        wait(actionCoolDownTime)
        workspace["Door_Base_Far_Mansion1-Grandhall (Mansion Key)"].InteractEvent:FireServer()
        wait(2)
        pathfindCharTo(Workspace.Guttermouth["Door_GuttermouthPhantom (Hidden Key)"].DoorBrick.Position)
        
        --// Auto-Sell Clean-up
        wait(0)
        isSelling = false
        printconsole("Autofarm: Auto-sell complete!", 0, 0, 255)
        autoFarmPhase0()
    end
end

-- Keybind Functionality

game:GetService('UserInputService').InputBegan:connect(function(key, gameProcessedEvent)
    if key.KeyCode == Enum.KeyCode[Keybind] then
        if isRunning == false and isSelling == false then
            isRunning = true
            printconsole("Autofarm: Starting...!", 124, 255, 124)
            autoFarmPhase1()
            printconsole("Autofarm: Started!", 0, 255, 0)
        elseif isRunning == true then
            printconsole("Autofarm: Stopping...", 255, 124, 124)
            isRunning = false
            printconsole("Autofarm: Stopped!", 255, 0, 0)
        end
    end
end)

-- Lost Boss Auto-Kill Functionality

monstersFolder.ChildAdded:Connect(autoFarmPhase2)

-- Reward Auto-Claim & Exit

gameWorkspace.ChildAdded:Connect(autoFarmPhase3)

-- Initiate Sell Functionality

local function inventoryFull()
    for _, slot in pairs(player:WaitForChild("Inventory"):GetChildren()) do
        if slot.Value == 0 then
            return false
        end
    end
    return true
end
for _, slot in pairs(player:WaitForChild("Inventory"):GetChildren()) do
    slot:GetPropertyChangedSignal("Value"):Connect(function()
        if slot.Value ~= 0 then
            if game.ReplicatedStorage.ItemInfo[slot.Value].SellValue.Value < minimumItemValue and inventorySlots[slot.Name] == true and isRunning == true then
                game.ReplicatedStorage.Events.DropItem:FireServer(slot.Value, slot.Quantity.Value, torso.Position - Vector3.new(0, 1, 0))
            elseif not inventorySlots["S"..string.format("%0.2i", slot.Name:match("%d+") + 1)] or inventoryFull() and not isSelling then
                repeat wait() until isInGuttermouth == false
                isSelling = true
                initiateItemSell()
            end
        end
    end)
end

--// CTRL CLICK DELETE

mouse.Button1Down:connect(function()
    if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then 
        return 
    end
    if not mouse.Target then 
        return 
    end
    mouse.Target:Destroy()
end)