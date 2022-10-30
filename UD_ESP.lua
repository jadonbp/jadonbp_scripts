local localPlayer = game.Players.LocalPlayer
local localCharacter = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local espOn = true
local espItems = {}

if localPlayer.Team.Name ~= "Police" then 
    repeat 
        wait(0.1) 
    until localPlayer.Team.Name == "Police"
end

local function createTag(character)
    repeat 
	    wait(0.1) 
	until character:FindFirstChild("BountyUnderlay") and character:FindFirstChild("HumanoidRootPart")
    
	local player = game.Players[character.Name]
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	local bountyUnderlay = character:FindFirstChild("BountyUnderlay")
	
	if bountyUnderlay and humanoidRootPart then
	    local espHighlight = Instance.new("Highlight")
    	espHighlight.Adornee = character
    	espHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    	espHighlight.Enabled = espOn
    	espHighlight.FillTransparency = 1
    	espHighlight.Name = "Highlight"
    	espHighlight.OutlineTransparency = 0.1
    	espHighlight.Parent = character
    
    	local espBillboardUi = Instance.new("BillboardGui")
    	espBillboardUi.Active = true
    	espBillboardUi.Adornee = character:FindFirstChild("Head")
    	espBillboardUi.AlwaysOnTop = true
    	espBillboardUi.Enabled = espOn
    	espBillboardUi.ExtentsOffset = Vector3.new(0, 2.5, 0)
    	espBillboardUi.ExtentsOffsetWorldSpace = Vector3.new(0, 0, 0)
    	espBillboardUi.LightInfluence = 1
    	espBillboardUi.MaxDistance = math.huge
    	espBillboardUi.Name = "BillboardGui"
    	espBillboardUi.Parent = character
    	espBillboardUi.ResetOnSpawn = false
    	espBillboardUi.Size = UDim2.new(0, 200, 0, 35)
    
    	local espNameLabel = Instance.new("TextLabel")
    	espNameLabel.BackgroundTransparency = 1
    	espNameLabel.Name = "TextLabel"
    	espNameLabel.Parent = espBillboardUi
    	espNameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    	espNameLabel.Visible = true
    	espNameLabel.Font = Enum.Font.TitilliumWeb
    	espNameLabel.RichText = true
    	espNameLabel.Text = player.Name
    	espNameLabel.TextScaled = true
    	espNameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    	espNameLabel.TextStrokeTransparency = 0.85
    
    	local espInfoLabel = Instance.new("TextLabel")
    	espInfoLabel.BackgroundTransparency = 1
    	espInfoLabel.Name = "TextLabel"
    	espInfoLabel.Parent = espBillboardUi
    	espInfoLabel.Size = UDim2.new(1, 0, 0.5, 0)
    	espInfoLabel.Position = UDim2.new(0, 0, 0.5, 0)
    	espInfoLabel.Visible = true
    	espInfoLabel.Font = Enum.Font.TitilliumWeb
    	espInfoLabel.RichText = true
    	espInfoLabel.TextScaled = true
    	espInfoLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    	espInfoLabel.TextStrokeTransparency = 0.85
    	
	    table.insert(espItems, espHighlight)
	    table.insert(espItems, espBillboardUi)
	    game.Players.PlayerRemoving:Connect(function(playerLeaving)
	        if playerLeaving == player then
	            table.remove(espItems, table.find(espItems, espHighlight))
	            table.remove(espItems, table.find(espItems, espBillboardUi))
	        end
	    end)
	    
	    localCharacter:WaitForChild("Humanoid").Died:Connect(function()
	        espBillboardUi:Destroy()
	        espHighlight:Destroy()
	        espNameLabel:Destroy()
	        espInfoLabel:Destroy()
	    end)
    
	    task.spawn(function()
	        if player.Team.Name == "Police" then
                espHighlight.FillColor = Color3.new(0, 0, 255)
        		espHighlight.OutlineColor = Color3.new(0, 0, 255)
        		espNameLabel.TextColor3 = Color3.new(0, 0, 255)
        		espInfoLabel.TextColor3 = Color3.new(0, 0, 255)
    	        while wait(0.1) do
            		espInfoLabel.Text = "Police | "..math.floor((humanoidRootPart.Position - localCharacter.HumanoidRootPart.Position).Magnitude + 0.5).." studs | "..character:WaitForChild("Humanoid").Health.."%"
            	end
    	    else
    	        while wait(0.1) do
            		espHighlight.FillColor = character:WaitForChild("BountyUnderlay").ImageLabel.ImageColor3
            		espHighlight.OutlineColor = character:WaitForChild("BountyUnderlay").ImageLabel.ImageColor3
            		espNameLabel.TextColor3 = character:WaitForChild("BountyUnderlay").ImageLabel.ImageColor3
            		espInfoLabel.TextColor3 = character:WaitForChild("BountyUnderlay").ImageLabel.ImageColor3
            		espInfoLabel.Text = player.Team.Name.." | "..math.floor((humanoidRootPart.Position - localCharacter.HumanoidRootPart.Position).Magnitude + 0.5).." studs | "..character:WaitForChild("Humanoid").Health.."%"
            	end
    	    end
	    end)
	end
end

localPlayer.CharacterAdded:Connect(function()
    for _, p in pairs(game.Players:GetPlayers()) do
    	if p.Name ~= localPlayer.Name then
    		task.spawn(createTag, p.Character or p.CharacterAdded:Wait())
    		p.CharacterAdded:Connect(createTag)
    	end
    end
end)

for _, p in pairs(game.Players:GetPlayers()) do
    	if p.Name ~= localPlayer.Name then
    		task.spawn(createTag, p.Character or p.CharacterAdded:Wait())
    		p.CharacterAdded:Connect(createTag)
    	end
    end

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
	    task.spawn(createTag, character)
	end)
end)

game:GetService("UserInputService").InputBegan:Connect(function(input)
	if (game:GetService("UserInputService"):GetFocusedTextBox()) then
		return
	end
	if input.KeyCode == Enum.KeyCode.T then
		espOn = not espOn
		for _, item in pairs(espItems) do
		    item.Enabled = espOn
		end
	end	
end)