local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local introGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
introGui.IgnoreGuiInset = true
introGui.ResetOnSpawn = false
introGui.Name = "IntroGui"

local blackFrame = Instance.new("Frame")
blackFrame.Size = UDim2.new(1, 0, 1, 0)
blackFrame.BackgroundColor3 = Color3.new(0, 0, 0)
blackFrame.BorderSizePixel = 0
blackFrame.Parent = introGui

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0)
label.Position = UDim2.new(0, 0, 0, -50)
label.BackgroundTransparency = 1
label.Text = "made by No_1"
label.TextScaled = true
label.Font = Enum.Font.SourceSansBold
label.TextStrokeTransparency = 0.2
label.TextColor3 = Color3.fromRGB(255, 0, 0)
label.Parent = blackFrame

local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(1, 0, 0, 50)
copyButton.Position = UDim2.new(0, 0, 0.65, 0)
copyButton.BackgroundTransparency = 1
copyButton.Text = "디스코드서버(클릭시 복사)"
copyButton.TextScaled = true
copyButton.Font = Enum.Font.SourceSans
copyButton.TextColor3 = Color3.new(1, 1, 1)
copyButton.Parent = blackFrame

local setclipboard = setclipboard or (Clipboard and Clipboard.set)
copyButton.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard("https://discord.gg/3Xdm4csK")
	end
end)

local startTime = tick()
local connection

connection = RunService.RenderStepped:Connect(function()
	local t = tick() - startTime
	label.TextColor3 = Color3.fromHSV(t % 1, 1, 1)
	if t >= 5 then
		connection:Disconnect()
		introGui:Destroy()

		local char = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = char:WaitForChild("HumanoidRootPart")

		local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
		gui.Name = "VoidGui"
		gui.ResetOnSpawn = false

		local teleportButton = Instance.new("TextButton", gui)
		teleportButton.Name = "VoidButton"
		teleportButton.Size = UDim2.new(0, 80, 0, 30)
		teleportButton.Position = UDim2.new(0, 10, 0, 10)
		teleportButton.Text = "void"
		teleportButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		teleportButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		teleportButton.Font = Enum.Font.GothamBold
		teleportButton.TextSize = 14
		teleportButton.BorderSizePixel = 0
		teleportButton.AutoButtonColor = true

		local targetPosition = Vector3.new(0, -500, 0)

		local function teleportTemporarily()
			if not humanoidRootPart then return end
			local originalPosition = humanoidRootPart.Position
			humanoidRootPart.CFrame = CFrame.new(targetPosition)
			task.delay(0.5, function()
				humanoidRootPart.CFrame = CFrame.new(originalPosition)
			end)
		end

		teleportButton.MouseButton1Click:Connect(teleportTemporarily)

		UIS.InputBegan:Connect(function(input, isTyping)
			if isTyping then return end
			if input.KeyCode == Enum.KeyCode.E then
				teleportTemporarily()
			end
		end)
	end
end)
