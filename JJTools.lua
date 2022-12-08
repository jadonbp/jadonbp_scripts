-- By j9don
-- Version: 2.1

-- Instances:

local JJTools = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Line = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
local Start = Instance.new("ImageButton")
local AmountBox = Instance.new("ImageLabel")
local Input = Instance.new("TextBox")
local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
local Title_2 = Instance.new("TextLabel")
local UITextSizeConstraint_3 = Instance.new("UITextSizeConstraint")
local Line_2 = Instance.new("Frame")
local CapsSelect = Instance.new("ImageButton")
local Line_3 = Instance.new("Frame")
local Title_3 = Instance.new("TextLabel")
local UITextSizeConstraint_4 = Instance.new("UITextSizeConstraint")
local InsertAndSelect = Instance.new("ImageButton")
local Line_4 = Instance.new("Frame")
local Title_4 = Instance.new("TextLabel")
local UITextSizeConstraint_5 = Instance.new("UITextSizeConstraint")
local Stop = Instance.new("ImageButton")
local Error = Instance.new("TextLabel")
local UITextSizeConstraint_6 = Instance.new("UITextSizeConstraint")
local Pause = Instance.new("ImageButton")
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
local HostName = Instance.new("ImageLabel")
local Input_2 = Instance.new("TextBox")
local UITextSizeConstraint_7 = Instance.new("UITextSizeConstraint")
local Title_5 = Instance.new("TextLabel")
local UITextSizeConstraint_8 = Instance.new("UITextSizeConstraint")
local Line_5 = Instance.new("Frame")
local Suffix = Instance.new("ImageLabel")
local Input_3 = Instance.new("TextBox")
local UITextSizeConstraint_9 = Instance.new("UITextSizeConstraint")
local Line_6 = Instance.new("Frame")
local Title_6 = Instance.new("TextLabel")
local UITextSizeConstraint_10 = Instance.new("UITextSizeConstraint")

--Properties:

JJTools.Name = "JJTools"
JJTools.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
JJTools.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = JJTools
Main.BackgroundColor3 = Color3.fromRGB(57, 57, 57)
Main.BackgroundTransparency = 0.450
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.352594942, 0, 0.481702149, 0)
Main.Size = UDim2.new(0.232365146, 0, 0.325106382, 0)

Line.Name = "Line"
Line.Parent = Main
Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Line.BorderSizePixel = 0
Line.Position = UDim2.new(0.0115681607, 0, 0.176470533, 0)
Line.Size = UDim2.new(0.979166687, 0, 0.00261780107, 0)

Title.Name = "Title"
Title.Parent = Main
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0.0863611102, 0, 0.030481549, 0)
Title.Size = UDim2.new(0.824404776, 0, 0.10209424, 0)
Title.Font = Enum.Font.Nunito
Title.Text = "Military Training Bot"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.TextSize = 14.000
Title.TextWrapped = true

UITextSizeConstraint.Parent = Title
UITextSizeConstraint.MaxTextSize = 39

Start.Name = "Start"
Start.Parent = Main
Start.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Start.BackgroundTransparency = 1.000
Start.Position = UDim2.new(0.0580327734, 0, 0.755417943, 0)
Start.Size = UDim2.new(0.272321433, 0, 0.178010479, 0)
Start.Image = "rbxassetid://7132571558"

AmountBox.Name = "AmountBox"
AmountBox.Parent = Main
AmountBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AmountBox.BackgroundTransparency = 1.000
AmountBox.BorderSizePixel = 0
AmountBox.Position = UDim2.new(0.179952294, 0, 0.248493075, 0)
AmountBox.Size = UDim2.new(0.0684523806, 0, 0.120418847, 0)
AmountBox.Image = "rbxassetid://7129688503"
AmountBox.ScaleType = Enum.ScaleType.Slice

Input.Name = "Input"
Input.Parent = AmountBox
Input.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Input.BackgroundTransparency = 1.000
Input.Position = UDim2.new(0.0964010507, 0, 0.0891776755, 0)
Input.Size = UDim2.new(0.804347813, 0, 0.804347813, 0)
Input.Font = Enum.Font.SourceSans
Input.Text = ""
Input.TextColor3 = Color3.fromRGB(255, 255, 255)
Input.TextScaled = true
Input.TextSize = 14.000
Input.TextWrapped = true

UITextSizeConstraint_2.Parent = Input
UITextSizeConstraint_2.MaxTextSize = 37

Title_2.Name = "Title"
Title_2.Parent = AmountBox
Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title_2.BackgroundTransparency = 1.000
Title_2.BorderSizePixel = 0
Title_2.Position = UDim2.new(-0.0417455733, 0, 0.111723542, 0)
Title_2.Size = UDim2.new(5.04347849, 0, 0.739130437, 0)
Title_2.Font = Enum.Font.Nunito
Title_2.Text = "# of jumps"
Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_2.TextScaled = true
Title_2.TextSize = 14.000
Title_2.TextWrapped = true

UITextSizeConstraint_3.Parent = Title_2
UITextSizeConstraint_3.MaxTextSize = 34

Line_2.Name = "Line"
Line_2.Parent = AmountBox
Line_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Line_2.BorderSizePixel = 0
Line_2.Position = UDim2.new(1.31591535, 0, 0.959079266, 0)
Line_2.Size = UDim2.new(2.347826, 0, 0.0217391308, 0)

CapsSelect.Name = "CapsSelect"
CapsSelect.Parent = Main
CapsSelect.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CapsSelect.BackgroundTransparency = 1.000
CapsSelect.Position = UDim2.new(0.552999973, 0, 0.328000009, 0)
CapsSelect.Size = UDim2.new(0.0401785709, 0, 0.0706806257, 0)
CapsSelect.Image = "rbxassetid://7129682183"

Line_3.Name = "Line"
Line_3.Parent = CapsSelect
Line_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Line_3.BorderSizePixel = 0
Line_3.Position = UDim2.new(1.35295045, 0, 0.963575602, 0)
Line_3.Size = UDim2.new(4.92592573, 0, 0.037037041, 0)

Title_3.Name = "Title"
Title_3.Parent = CapsSelect
Title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title_3.BackgroundTransparency = 1.000
Title_3.BorderSizePixel = 0
Title_3.Position = UDim2.new(0.718198419, 0, -0.0364244282, 0)
Title_3.Size = UDim2.new(6.14814806, 0, 0.814814866, 0)
Title_3.Font = Enum.Font.Nunito
Title_3.Text = "all caps text"
Title_3.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_3.TextScaled = true
Title_3.TextSize = 14.000
Title_3.TextWrapped = true

UITextSizeConstraint_4.Parent = Title_3
UITextSizeConstraint_4.MaxTextSize = 22

InsertAndSelect.Name = "InsertAndSelect"
InsertAndSelect.Parent = Main
InsertAndSelect.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
InsertAndSelect.BackgroundTransparency = 1.000
InsertAndSelect.Position = UDim2.new(0.553443491, 0, 0.567585289, 0)
InsertAndSelect.Size = UDim2.new(0.0401785709, 0, 0.0706806257, 0)
InsertAndSelect.Image = "rbxassetid://7129682183"

Line_4.Name = "Line"
Line_4.Parent = InsertAndSelect
Line_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Line_4.BorderSizePixel = 0
Line_4.Position = UDim2.new(1.35295045, 0, 0.963575602, 0)
Line_4.Size = UDim2.new(4.92592573, 0, 0.037037041, 0)

Title_4.Name = "Title"
Title_4.Parent = InsertAndSelect
Title_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title_4.BackgroundTransparency = 1.000
Title_4.BorderSizePixel = 0
Title_4.Position = UDim2.new(0.718198419, 0, -0.0364244282, 0)
Title_4.Size = UDim2.new(6.14814806, 0, 0.814814866, 0)
Title_4.Font = Enum.Font.Nunito
Title_4.Text = "insert \"and\""
Title_4.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_4.TextScaled = true
Title_4.TextSize = 14.000
Title_4.TextWrapped = true

UITextSizeConstraint_5.Parent = Title_4
UITextSizeConstraint_5.MaxTextSize = 22

Stop.Name = "Stop"
Stop.Parent = Main
Stop.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Stop.BackgroundTransparency = 1.000
Stop.Position = UDim2.new(0.670758247, 0, 0.755417943, 0)
Stop.Size = UDim2.new(0.272321433, 0, 0.178010479, 0)
Stop.Image = "rbxassetid://7132748082"

Error.Name = "Error"
Error.Parent = Main
Error.AnchorPoint = Vector2.new(0.5, 0.5)
Error.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Error.BackgroundTransparency = 1.000
Error.BorderColor3 = Color3.fromRGB(255, 255, 255)
Error.Position = UDim2.new(0.5, 0, 0.975000024, 0)
Error.Size = UDim2.new(0.599702358, 0, 0.0497382209, 0)
Error.Font = Enum.Font.Nunito
Error.Text = "[ ERROR OUTPUT HERE ]"
Error.TextColor3 = Color3.fromRGB(255, 255, 255)
Error.TextScaled = true
Error.TextSize = 14.000
Error.TextWrapped = true

UITextSizeConstraint_6.Parent = Error
UITextSizeConstraint_6.MaxTextSize = 19

Pause.Name = "Pause"
Pause.Parent = Main
Pause.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Pause.BackgroundTransparency = 1.000
Pause.Position = UDim2.new(0.364210635, 0, 0.755417943, 0)
Pause.Size = UDim2.new(0.272321433, 0, 0.178010479, 0)
Pause.Image = "rbxassetid://7134052648"

UIAspectRatioConstraint.Parent = Main
UIAspectRatioConstraint.AspectRatio = 1.759

HostName.Name = "HostName"
HostName.Parent = Main
HostName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
HostName.BackgroundTransparency = 1.000
HostName.BorderSizePixel = 0
HostName.Position = UDim2.new(0.180000007, 0, 0.414999992, 0)
HostName.Size = UDim2.new(0.0684523806, 0, 0.120418847, 0)
HostName.Image = "rbxassetid://7129688503"
HostName.ScaleType = Enum.ScaleType.Slice

Input_2.Name = "Input"
Input_2.Parent = HostName
Input_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Input_2.BackgroundTransparency = 1.000
Input_2.Position = UDim2.new(0, 1, 0, 1)
Input_2.Size = UDim2.new(0.804347813, 0, 0.804347813, 0)
Input_2.Font = Enum.Font.SourceSans
Input_2.Text = ""
Input_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Input_2.TextScaled = true
Input_2.TextSize = 14.000
Input_2.TextWrapped = true

UITextSizeConstraint_7.Parent = Input_2
UITextSizeConstraint_7.MaxTextSize = 37

Title_5.Name = "Title"
Title_5.Parent = HostName
Title_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title_5.BackgroundTransparency = 1.000
Title_5.BorderSizePixel = 0
Title_5.Position = UDim2.new(0, 1, 0, 1)
Title_5.Size = UDim2.new(5.04347849, 0, 0.739130437, 0)
Title_5.Font = Enum.Font.Nunito
Title_5.Text = "title of host"
Title_5.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_5.TextScaled = true
Title_5.TextSize = 14.000
Title_5.TextWrapped = true

UITextSizeConstraint_8.Parent = Title_5
UITextSizeConstraint_8.MaxTextSize = 34

Line_5.Name = "Line"
Line_5.Parent = HostName
Line_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Line_5.BorderSizePixel = 0
Line_5.Position = UDim2.new(1.31599998, 0, 0.939999998, 0)
Line_5.Size = UDim2.new(2.347826, 0, 0.0217391308, 0)

Suffix.Name = "Suffix"
Suffix.Parent = Main
Suffix.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Suffix.BackgroundTransparency = 1.000
Suffix.BorderSizePixel = 0
Suffix.Position = UDim2.new(0.180000007, 0, 0.574999988, 0)
Suffix.Size = UDim2.new(0.0684523806, 0, 0.120418847, 0)
Suffix.Image = "rbxassetid://7129688503"
Suffix.ScaleType = Enum.ScaleType.Slice

Input_3.Name = "Input"
Input_3.Parent = Suffix
Input_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Input_3.BackgroundTransparency = 1.000
Input_3.Position = UDim2.new(0, 1, 0, 1)
Input_3.Size = UDim2.new(0.804347813, 0, 0.804347813, 0)
Input_3.Font = Enum.Font.SourceSans
Input_3.Text = ""
Input_3.TextColor3 = Color3.fromRGB(255, 255, 255)
Input_3.TextScaled = true
Input_3.TextSize = 14.000
Input_3.TextWrapped = true

UITextSizeConstraint_9.Parent = Input_3
UITextSizeConstraint_9.MaxTextSize = 37

Line_6.Name = "Line"
Line_6.Parent = Suffix
Line_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Line_6.BorderSizePixel = 0
Line_6.Position = UDim2.new(1.31599998, 0, 0.958999991, 0)
Line_6.Size = UDim2.new(2.347826, 0, 0.0217391308, 0)

Title_6.Name = "Title"
Title_6.Parent = Suffix
Title_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title_6.BackgroundTransparency = 1.000
Title_6.BorderSizePixel = 0
Title_6.Position = UDim2.new(0, 1, 0, 1)
Title_6.Size = UDim2.new(5.04347849, 0, 0.739130437, 0)
Title_6.Font = Enum.Font.Nunito
Title_6.Text = "chat suffix"
Title_6.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_6.TextScaled = true
Title_6.TextSize = 14.000
Title_6.TextWrapped = true

UITextSizeConstraint_10.Parent = Title_6
UITextSizeConstraint_10.MaxTextSize = 34

-- Scripts:

local function NXUJ_fake_script() -- Main.ClientHandler 
	local script = Instance.new('LocalScript', Main) -- BEFORE YOU SAY ANYTHING YES I KNOW MY SCRIPT IS SHIT AND INEFFICIENT STFU I DIDNT CARE MUCH TO MAKE IT NICE

	local localPlayer = game.Players.LocalPlayer
	local localCharacter = localPlayer.Character:WaitForChild("Humanoid")
	local replicatedStorage = game:GetService('ReplicatedStorage')
	local chatEvent = replicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest
	
	local mainFrame = script.Parent
	local startButton = mainFrame:FindFirstChild('Start')
	local stopButton = mainFrame:FindFirstChild('Stop')
	local pauseButton = mainFrame:FindFirstChild('Pause')
	local amountInputBox = mainFrame:WaitForChild("AmountBox"):WaitForChild("Input")
	local hostTitleInputBox = mainFrame:WaitForChild("HostName"):WaitForChild("Input")
	local chatSuffixInputBox = mainFrame:WaitForChild("Suffix"):WaitForChild("Input")
	local insertAndSelectBox = mainFrame:WaitForChild("InsertAndSelect")
	local capitalizedChatSelectBox = mainFrame:WaitForChild("CapsSelect")
	local errorTextBar = mainFrame:WaitForChild("Error")
	
	local countNumber = 1
	local insertWordAND = false -- 101 = "one hundred and one" / "one hundred one"
	local capsText = false
	local operationIsRunning = false
	local operationIsPaused = false
	
	-- Number to Text Translator
	
	local append, concat, floor, abs = table.insert, table.concat, math.floor, math.abs
	local num = {'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten', 'Eleven',
		'Twelve', 'Thirteen', 'Fourteen', 'Fifteen', 'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen'}
	local tens = {'Twenty', 'Thirty', 'Forty', 'Fifty', 'Sixty', 'Seventy', 'Eighty', 'Ninety'}
	local bases = {{floor(1e18), ' Quintillion'}, {floor(1e15), ' Quadrillion'}, {floor(1e12), ' Trillion'},
	{floor(1e9), ' Billion'}, {1000000, ' Million'}, {1000, ' Thousand'}, {100, ' Hundred'}}
	
	local function IntegerNumberInWords(n)
		local str = {}
		if n < 0 then
			append(str, "minus")
		end
		n = floor(abs(n))
		if n == 0 then
			return "zero"
		end
		if n >= 1e21 then
			append(str, "infinity")
		else
			local AND
			for _, base in ipairs(bases) do
				local value = base[1]
				if n >= value then
					append(str, IntegerNumberInWords(n / value)..base[2])
					n, AND = n % value, insertWordAND or nil
				end
			end
			if n > 0 then
				append(str, AND and "and")
				append(str, num[n] or tens[floor(n/10)-1]..(n%10 ~= 0 and ' '..num[n%10] or ''))
			end
		end
		return concat(str, ' ')
	end
	
	-- Disabling Non-Number Inputs Into Textboxs
	
	amountInputBox:GetPropertyChangedSignal("Text"):Connect(function()
		amountInputBox.Text = amountInputBox.Text:gsub('%D+', '');
	end)
	
	-- Selection Boxes Functionality
	
	capitalizedChatSelectBox.MouseButton1Down:Connect(function()
		if capsText == false then
			capsText = true
			capitalizedChatSelectBox.HoverImage = "rbxassetid://7129682183"
			capitalizedChatSelectBox.Image = "rbxassetid://7132693335"
		elseif capsText == true then
			capsText = false
			capitalizedChatSelectBox.HoverImage = "rbxassetid://7132693335"
			capitalizedChatSelectBox.Image = "rbxassetid://7129682183"
		end
	end)
	
	insertAndSelectBox.MouseButton1Down:Connect(function()
		if insertWordAND == false then
			insertWordAND = true
			insertAndSelectBox.HoverImage = "rbxassetid://7129682183"
			insertAndSelectBox.Image = "rbxassetid://7132693335"
		elseif insertWordAND == true then
			insertWordAND = false
			insertAndSelectBox.HoverImage = "rbxassetid://7132693335"
			insertAndSelectBox.Image = "rbxassetid://7129682183"
		end
	end)
	
	-- Setting up Functions
	
	local function doJumpingJackNumber(number)
		local numberToText = IntegerNumberInWords(tonumber(number))
		if capsText == true then
			numberToText = string.upper(IntegerNumberInWords(tonumber(number)))
		end
		
		if #numberToText <= 5 then
			wait(tonumber(#numberToText)*0.6)
			chatEvent:FireServer(numberToText..chatSuffixInputBox.Text, "All")
			wait(Random.new():NextNumber(0.2, .85))
			localCharacter.Jump = true
		elseif #numberToText >= 6 and #numberToText <= 12 then
			wait(tonumber(#numberToText)*0.235)
			chatEvent:FireServer(numberToText..chatSuffixInputBox.Text, "All")
			wait(Random.new():NextNumber(0.2, .85))
			localCharacter.Jump = true
		elseif #numberToText >= 13 then
			wait(tonumber(#numberToText)*0.175)
			chatEvent:FireServer(numberToText..chatSuffixInputBox.Text, "All")
			wait(Random.new():NextNumber(0.2, .85))
			localCharacter.Jump = true
		end
	end
	
	local function stopOperation()
		if operationIsRunning == true then
			errorTextBar.Text = "[ SUCCESS: OPERATION ENDED ]"
			errorTextBar.TextColor3 = Color3.new(0.517647, 1, 0)
			wait(2)
			errorTextBar.Text = "[ ERROR OUTPUT HERE ]"
			errorTextBar.TextColor3 = Color3.new(1, 1, 1)
			
			operationIsRunning = false
			countNumber = 1
			amountInputBox.Text = ""
			chatSuffixInputBox.Text = ""
			hostTitleInputBox.Text = ""
		end
	end
	
	local function startOperation()
		if operationIsRunning == false then
			if amountInputBox.Text ~= "" then
					operationIsRunning = true
					operationIsPaused = false
	
					for countNumber = 1, amountInputBox.Text, 1 do
						if operationIsRunning == true then
							if operationIsPaused == false then
								doJumpingJackNumber(countNumber)
							else
								repeat wait() until operationIsPaused == false
								doJumpingJackNumber(countNumber)
							end
						end
					end
				if operationIsRunning == true and operationIsPaused == false then
					if hostTitleInputBox.Text ~= "" then
						wait(tonumber(#hostTitleInputBox.Text)*0.15+1.75)
						chatEvent:FireServer("Done, "..hostTitleInputBox.Text.."!", "All")
					end
					stopOperation()
				end
			elseif amountInputBox.Text == "" then
				errorTextBar.Text = "[ ERROR: MISSING PARAMETER (# OF JUMPS) ]"
				errorTextBar.TextColor3 = Color3.new(1, 0.239216, 0.239216)
				wait(2)
				errorTextBar.Text = "[ ERROR OUTPUT HERE ]"
				errorTextBar.TextColor3 = Color3.new(1, 1, 1)
			end	
		end
	end
	
	local function pauseOperation()
		if operationIsPaused == false and operationIsRunning == true then
			operationIsPaused = true
			errorTextBar.Text = "[ SUCCESS: OPERATION PAUSED ]"
			errorTextBar.TextColor3 = Color3.new(0.517647, 1, 0)
			wait(2)
			errorTextBar.Text = "[ PRESS PAUSE TO UNPAUSE OPERATION ]"
			errorTextBar.TextColor3 = Color3.new(1, 0.615686, 0)
	
			pauseButton.ImageColor3 = Color3.new(1, 0.615686, 0)
		elseif operationIsPaused == true and operationIsRunning == true then
			operationIsPaused = false
			errorTextBar.Text = "[ SUCCESS: OPERATION UNPAUSED ]"
			errorTextBar.TextColor3 = Color3.new(0.517647, 1, 0)
			wait(2)
			errorTextBar.Text = "[ ERROR OUTPUT HERE ]"
			errorTextBar.TextColor3 = Color3.new(1, 1, 1)
	
			pauseButton.ImageColor3 = Color3.new(1, 1, 1)
		end	
	end
	
	startButton.MouseButton1Down:Connect(startOperation)
	stopButton.MouseButton1Down:Connect(stopOperation)
	pauseButton.MouseButton1Down:Connect(pauseOperation)
	
	-- Draggable Frame
	mainFrame.Draggable = true
	mainFrame.Active = true
	mainFrame.Selectable = true
end
coroutine.wrap(NXUJ_fake_script)()
