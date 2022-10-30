-- Global Values
local autoFishEnabled = false
local keybind = "M"

local fishesToKeep = {
    [1267] = true, -- Algae King
    [1263] = false, -- Springfish
    [1248] = true, -- Emperor Whale
    
}

-- Get Player & Player Instances
local player = game.Players.LocalPlayer
local backpack = player.Backpack
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
end)

-- Get Fishing Rod
local fishingRod = nil
if character:FindFirstChildWhichIsA("Tool") then
    if string.match(character:FindFirstChildWhichIsA("Tool").Name, "FishingRod$") ~= nil then
        fishingRod = character:FindFirstChildWhichIsA("Tool")
        printconsole("FF-AF: Found fishing rod ("..character:FindFirstChildWhichIsA("Tool").Name..")", 0, 255, 0)
    end
else
    for _, tool in pairs(backpack:GetChildren()) do
        if string.match(tool.Name, "FishingRod$") ~= nil then
            fishingRod = tool
            printconsole("FF-AF: Found fishing rod ("..tool.Name..")", 0, 255, 0)
        end
    end
end
backpack.ChildAdded:Connect(function(child)
    if fishingRod == nil then
        if string.match(child.Name, "FishingRod$") ~= nil then
            fishingRod = child
            printconsole("FF-AF: Found fishing rod ("..child..")", 0, 255, 0)
        end
    end
end)
backpack.ChildRemoved:Connect(function(child)
    if fishingRod ~= nil and child.Parent ~= character then
        if string.match(child.Name, "FishingRod$") ~= nil then
            fishingRod = nil
            printconsole("FF-AF: Fishing rod unequipped, auto-fish will re-activate once a rod is equipped)", 255, 0, 0)
        end
    end
end)

-- Update When Activated
game:GetService('UserInputService').InputBegan:connect(function(key, gameProcessedEvent)
    if key.KeyCode == Enum.KeyCode[keybind] then
        autoFishEnabled = not autoFishEnabled
        if autoFishEnabled then
            if fishingRod ~= nil then
                if fishingRod.Parent == character then
                    fishingRod:Activate()
                else
                    humanoid:EquipTool(fishingRod)
                    wait(1)
                    fishingRod:Activate()
                end
            else
                printconsole("FF-AF: Fishing rod unequipped, auto-fish will re-activate once a rod is equipped)", 255, 0, 0)
                autoFishEnabled = not autoFishEnabled
            end
        elseif not autoFishEnabled then
            
        end
    end
end)

-- Get Fishing Rod Bite
fishingRod.ChildAdded:Connect(function(child)
    if autoFishEnabled then
        if child.Name == "SplashPart" then
            fishingRod:Activate()
            wait(5)
            fishingRod:Activate()
        end
    end
end)

-- Auto Drop Items
for _, slot in pairs(player:WaitForChild("Inventory"):GetChildren()) do
    slot:GetPropertyChangedSignal("Value"):Connect(function()
        if autoFishEnabled then
            if slot.Value ~= 0 then
                if not fishesToKeep[slot.Value] then
                    game.ReplicatedStorage.Events.DropItem:FireServer(slot.Value, slot.Quantity.Value, character.PrimaryPart.Position - Vector3.new(0, 1, 0))
                end
            end
        end
    end)
end