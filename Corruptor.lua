-- Var --

local lighting = game:GetService("Lighting")
local soundService = game:GetService("SoundService")
local tweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local tweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0)
local tweenInfoButtons = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0)

local player = game.Players.LocalPlayer

local playerGui = player.PlayerGui

local uiToggled = false
local uiFrame = nil
local uiEnabled = false

local values = {
	amount = 50,
	color = false,
	position = false,
	rotation = false,
	size = false,
	volume = false,
	pitch = false,
	reverb = false,
	distanceFactor = false,
	dopplerScale = false,
	material = false,
	humanoid = false,
	uiTransform = false,
	uiTransparency = false,
	uiColor = false,
	lighting = false,
	screen = false,
	camera = false,
	shape = false,
	fog = false,
	light = false,
	special = false,
	decals = false,
	textures = false,
	motor6d = false,
	accessories = false,
	collision = false,
}

local corruptionDebounce = false

local info = [[
Thanks for using HGTP's RBLX Corrupter!

This is a little GUI to simulate Roblox corruptions, doesn't actually corrupt the game though.

WARNING!!! Not made to cheat!!! Some games have anti-cheats and you can get banned!! I recommened using a private server and I recommended to use a alt account!

The amount of corruption can go from 1, to 100.

How to use :
1. Click all the buttons in the middle you want to be modified. 
(It will show a brighter color turned on.)
2. Set a custom value for the amount of corruption. 
(Recommend a smaller value with more buttons clicked.)
3. Click the corrupt button!
4. Watch as objects, sounds, etc. change in real time!

Note - Big games with a lot of objects may take a while to finish corrupting!

Note - This is all client sided so other players will only see you floating, going through objects, etc.
]]

local currentCorruptionType = "one"
local corruptionTypes = {
	"one",
	"one-",
	"two",
	"two-",
	"three",
	"five",
	"extended",
	"extended-",
	"ultra extended",
	"huge",
	"huge-",
}

local versionNumber = "V1.63"

local corruptWorkspace = false
local corruptRSAndRF = false
local corruptWholeGame = false

local useCoreGui = false
local hiddenUi = nil
local coreGui = game:FindFirstChild("CoreGui")
if coreGui then
	local hiddenUI = coreGui:FindFirstChild("HiddenUI")
	if hiddenUI then
		hiddenUi = hiddenUI
		useCoreGui = true
	else
		useCoreGui = false
	end
else
	useCoreGui = false
end

local autoObjectCreateCorrupt = false

-- Func --

function corruptSpecificObject(obj)
	local function calculateCorruptValue()
		local value = 2

		if currentCorruptionType == "one" then
			value = 2
		elseif currentCorruptionType == "two" then
			value = 2 * 2
		elseif currentCorruptionType == "three" then
			value = 2 * 3
		elseif currentCorruptionType == "five" then
			value = 2 * 5
		elseif currentCorruptionType == "extended" then
			value = 2 * 50
		elseif currentCorruptionType == "ultra extended" then
			value = 2 * 100
		elseif currentCorruptionType == "huge" then
			value = math.huge
		elseif currentCorruptionType == "one-" then
			value = -2
		elseif currentCorruptionType == "two-" then
			value = -2 * 2
		elseif currentCorruptionType == "extended-" then
			value = -2 * 50
		elseif currentCorruptionType == "huge-" then
			value = -math.huge
		else
			value = 2
		end

		return value
	end

	local ccv = calculateCorruptValue()

	for i, e in values do
		if e then
			if i == "position" then
				local chance = math.random(1, 100)
				if chance <= values["amount"] then
					if obj:IsA("BasePart") then
						obj:PivotTo(obj.CFrame * CFrame.new(Vector3.new(math.random(1.5, 4.0), math.random(1.5, 4.0), math.random(1.5, 4.0))))
					elseif obj:IsA("Model") then
						obj:PivotTo(obj.WorldPivot * CFrame.new(Vector3.new(math.random(1.5, 4.0), math.random(1.5, 4.0), math.random(1.5, 4.0))))
					end
				end
			elseif i == "rotation" then
				local chance = math.random(1, 100)
				if chance <= values["amount"] then
					if obj:IsA("BasePart") then
						obj.Rotation += Vector3.new(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
					end
				end
			elseif i == "size" then
				local chance = math.random(1, 100)
				if chance <= values["amount"] then
					if obj:IsA("BasePart") then
						obj.Size += Vector3.new(math.random(-20, 20), math.random(-20, 20), math.random(-20, 20))
					end
				end
			elseif i == "color" then
				local chance = math.random(1, 100)
				if chance <= values["amount"] then
					if obj:IsA("Part") then
						obj.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
					elseif obj:IsA("UnionOperation") then
						obj.UsePartColor = true
						obj.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
					end
				end
			elseif i == "material" then
				local chance = math.random(1, 100)
				if chance <= values["amount"] then
					if obj:IsA("BasePart") then
						obj.Material = Enum.Material:GetEnumItems()[math.random(1, #Enum.Material:GetEnumItems())]
					end
				end
			elseif i == "shape" then
				local chance = math.random(1, 100)
				if chance <= values["amount"] then
					if obj:IsA("Part") then
						obj.Shape = Enum.PartType:GetEnumItems()[math.random(1, #Enum.PartType:GetEnumItems())]
					end
				end
			elseif i == "uiTransform" then
				local function setUiValues(i)
					for _, i in i:GetDescendants() do
						local chance = math.random(1, 100)
						if chance <= values["amount"] then
							if i:IsA("GuiObject") then
								i.Position += UDim2.fromOffset(math.random(-ccv, ccv) * 3, math.random(-ccv, ccv) * 3)
								i.Rotation += 90 * math.random(0, 3)
								i.Size += UDim2.fromOffset(i.Size.X.Offset * math.random(-ccv, ccv), i.Size.Y.Offset * math.random(-ccv, ccv))
							end
						end
					end
				end

				setUiValues(obj)
			elseif i == "uiColor" then
				local function setUiValues(i)
					for _, i in i:GetDescendants() do
						local chance = math.random(1, 100)
						if chance <= values["amount"] then
							if i:IsA("GuiObject") then
								i.BackgroundColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
								if i:IsA("TextLabel") or i:IsA("TextButton") or i:IsA("TextBox") then
									i.TextColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
								end
								i.BorderColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
							end
						end
					end
				end

				setUiValues(obj)
			elseif i == "uiTransparency" then
				local function setUiValues(i)
					for _, i in i:GetDescendants() do
						local chance = math.random(1, 100)
						if chance <= values["amount"] then
							if i:IsA("GuiObject") then
								local function getNewVal(old)
									local new = 0
									
									local val = math.random(0, 3)
									if val == 0 then
										new = 0
									elseif val == 1 then
										new = old * ccv
									elseif val == 2 then
										new = old / ccv
									elseif val == 3 then
										new = 1
									end
									
									return new
								end
								
								local val = getNewVal(i.BackgroundTransparency)
								i.BackgroundTransparency = val
								if i:IsA("TextLabel") or i:IsA("TextButton") or i:IsA("TextBox") then
									if i.TextTransparency > 0 then
										local val = getNewVal(i.TextTransparency)
										i.TextTransparency = val	
									end
								end
							end
						end
					end
				end

				setUiValues(obj)
			elseif i == "volume" then
				local function audioVolume(i)
					local val2 = i.Volume

					local val = math.random(0, 1)
					if val == 0 then
						if val2 > 0 then
							val2 = val2 * ccv
						else
							val2 = 1 * ccv
						end
					elseif val == 1 then
						if val2 > 0 then
							val2 = val2 / ccv
						else
							val2 = 1 / ccv
						end
					end

					return val2
				end

				local chance = math.random(1, 100)
				if chance <= values["amount"] then
					if obj:IsA("Sound") then
						obj.Volume = audioVolume(obj)
					end
				end
			elseif i == "pitch" then
				local function audioPitch(i)
					local val2 = i.PlaybackSpeed

					local val = math.random(0, 3)
					if val > 0 then
						if val2 > 0 then
							val2 = val2 * ccv
						else
							val2 = 1 * ccv
						end
					else
						if val2 > 0 then
							val2 = val2 / ccv
						else
							val2 = 1 / ccv
						end
					end

					return val2
				end

				local chance = math.random(1, 100)
				if chance <= values["amount"] then
					if obj:IsA("Sound") then
						obj.PlaybackSpeed = audioPitch(obj)
					end
				end
			elseif i == "humanoid" then
				local chance = math.random(1, 100)
				if chance <= values["amount"] then
					if obj:IsA("Humanoid") then
						local function randomTOrF()
							local random = math.random(1, 2)
							if random == 1 then
								return true
							elseif random == 2 then
								return false
							end
						end

						obj.UseJumpPower = true
						obj.Sit = randomTOrF()
						obj.PlatformStand = randomTOrF()
						obj.WalkSpeed = (math.random(0, 10000) / 10)
						obj.JumpPower = (math.random(0, 10000) / 10)
					end
				end
			elseif i == "light" then
				local chance = math.random(1, 100)
				if chance <= values["amount"] then
					if obj:IsA("Light") then
						obj.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
						obj.Brightness = (math.random(0, 500) / 10)
						obj.Range = math.random(0, 100)
					end
				end
			elseif i == "motor6d" then
				local chance = math.random(1, 100)
				if chance <= values["amount"] then
					if obj:IsA("Motor6D") then
						if math.random(0, 1) == 1 then
							obj.C0 = obj.C0 * CFrame.new(Vector3.new(math.random(1.5, 4.0), math.random(1.5, 4.0), math.random(1.5, 4.0))) * CFrame.fromOrientation(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
							obj.C1 = obj.C1 * CFrame.new(Vector3.new(math.random(1.5, 4.0), math.random(1.5, 4.0), math.random(1.5, 4.0))) * CFrame.fromOrientation(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
						else
							obj.C0 = CFrame.new(Vector3.new(0, 0, 0)) * CFrame.fromOrientation(0, 0, 0)
							obj.C1 = CFrame.new(Vector3.new(0, 0, 0)) * CFrame.fromOrientation(0, 0, 0)
						end
					end
				end
			end
		end
	end
end

function corruptNonSpaceObjects()
	local function calculateCorruptValue()
		local value = 2

		if currentCorruptionType == "one" then
			value = 2
		elseif currentCorruptionType == "two" then
			value = 2 * 2
		elseif currentCorruptionType == "three" then
			value = 2 * 3
		elseif currentCorruptionType == "five" then
			value = 2 * 5
		elseif currentCorruptionType == "extended" then
			value = 2 * 50
		elseif currentCorruptionType == "ultra extended" then
			value = 2 * 100
		elseif currentCorruptionType == "huge" then
			value = math.huge
		elseif currentCorruptionType == "one-" then
			value = -2
		elseif currentCorruptionType == "two-" then
			value = -2 * 2
		elseif currentCorruptionType == "extended-" then
			value = -2 * 50
		elseif currentCorruptionType == "huge-" then
			value = -math.huge
		else
			value = 2
		end

		return value
	end

	local ccv = calculateCorruptValue()

	for i, e in values do
		if e then
			if i == "reverb" then
				local chance = math.random(1, 100)
				if chance <= values["amount"] then
					soundService.AmbientReverb = Enum.ReverbType:GetEnumItems()[math.random(1, #Enum.ReverbType:GetEnumItems())]
				end
			elseif i == "dopplerScale" then
				local chance = math.random(1, 100)
				if chance <= values["amount"] then
					soundService.DopplerScale = (math.random(0, 100) / 10)
				end
			elseif i == "distanceFactor" then
				local chance = math.random(1, 100)
				if chance <= values["amount"] then
					soundService.DistanceFactor = (math.random(10, 500) / 10)
				end
			elseif i == "camera" then
				local chance = math.random(1, 100)
				if chance <= values["amount"] then
					local camera = workspace.CurrentCamera

					camera.CFrame = (workspace.CurrentCamera.CFrame * CFrame.fromOrientation(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360)))
					camera.FieldOfView = math.random(1, 120)
				end
			elseif i == "lighting" then
				local chance = math.random(1, 100)
				if chance <= values["amount"] then
					lighting.Brightness = (math.random(0, 50) / 10)
					lighting.ClockTime = (math.random(0, 240) / 10)
					lighting.OutdoorAmbient = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
					lighting.Ambient = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
				end
			elseif i == "screen" then
				local bloom = lighting:FindFirstChildOfClass("BloomEffect")
				if bloom then
					local chance = math.random(1, 100)
					if chance <= values["amount"] then
						bloom.Intensity = (math.random(0, 100) / 10)
						bloom.Size = math.random(0, 56)
						bloom.Threshold = (math.random(0, 60) / 10)
					end
				else
					local chance = math.random(1, 100)
					if chance <= values["amount"] then
						local newBloom = Instance.new("BloomEffect")
						newBloom.Intensity = (math.random(0, 100) / 10)
						newBloom.Size = math.random(0, 56)
						newBloom.Threshold = (math.random(0, 60) / 10)
						newBloom.Parent = lighting
					end
				end
				local color = lighting:FindFirstChildOfClass("ColorCorrectionEffect")
				if color then
					local chance = math.random(1, 100)
					if chance <= values["amount"] then
						color.Brightness = (math.random(-15, 15) / 10)
						color.Contrast = (math.random(-15, 15) / 10)
						color.TintColor = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
						color.Saturation = (math.random(-15, 15) / 10)
					end
				else
					local chance = math.random(1, 100)
					if chance <= values["amount"] then
						local newColor = Instance.new("ColorCorrectionEffect")
						newColor.Brightness = (math.random(-15, 15) / 10)
						newColor.Contrast = (math.random(-15, 15) / 10)
						newColor.TintColor = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
						newColor.Saturation = (math.random(-15, 15) / 10)
						newColor.Parent = lighting
					end
				end
			elseif i == "fog" then
				local chance = math.random(1, 100)
				if chance <= values["amount"] then
					lighting.FogEnd = math.random(0, 2000)
					lighting.FogStart = math.random(0, 100)
					lighting.FogColor = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
				end
			end
		end
	end
end

function loadCorruption()
	local function getObjects()
		local objects = {}

		if corruptWorkspace then
			for _, i in workspace:GetDescendants() do
				table.insert(objects, i)
			end
		end

		if corruptRSAndRF then
			for _, i in game:GetService("ReplicatedStorage"):GetDescendants() do
				table.insert(objects, i)
			end

			for _, i in game:GetService("ReplicatedFirst"):GetDescendants() do
				table.insert(objects, i)
			end
		end

		return objects
	end

	local function getGuiObjects()
		local objects = {}

		for _, i in playerGui:GetDescendants() do
			if i.Name ~= "CorruptorGUI" and i:IsA("ScreenGui") then
				table.insert(objects, i)
			end
		end

		if useCoreGui then
			for _, i in hiddenUi.Parent:GetDescendants() do
				if i.Name ~= "CorruptorGUI" and i:IsA("ScreenGui") and not i:IsDescendantOf(hiddenUi) then
					table.insert(objects, i)
				end
			end
		end

		return objects
	end

	local corruptObjects = getObjects()
	local corruptGuiObjects = getGuiObjects()
	
	for _, i in corruptObjects do
		corruptSpecificObject(i)
	end
	for _, i in corruptGuiObjects do
		corruptSpecificObject(i)
	end
	corruptNonSpaceObjects()
end

function afterCorruption(button)
	task.wait(0.2)

	button.Text = "Corrupt"

	corruptionDebounce = false
end

function corruptObjects(button)
	if not corruptionDebounce then
		corruptionDebounce = true

		button.Text = "Corrupting..."

		task.wait()

		loadCorruption()

		task.wait()

		afterCorruption(button)
	end
end

function start()
	if uiFrame then
		local tween = tweenService:Create(uiFrame, tweenInfo, {Position = UDim2.fromScale(0.5, 1.4)})
		tween:Play()

		local hideButton = uiFrame:FindFirstChild("HideButton")
		local RSRFButton = uiFrame:FindFirstChild("RSRFButton")
		local WSButton = uiFrame:FindFirstChild("WSEButton")
		local AutoSpawnCorruptButton = uiFrame:FindFirstChild("AutoSpawnCorruptButton")
		if hideButton then
			hideButton.MouseButton1Click:Connect(toggleUi)
		end
		if RSRFButton then
			RSRFButton.MouseButton1Click:Connect(function()
				buttonPressed(RSRFButton, "RSRF")
			end)
		end
		if WSButton then
			WSButton.MouseButton1Click:Connect(function()
				buttonPressed(WSButton, "WS")
			end)
		end
		if AutoSpawnCorruptButton then
			AutoSpawnCorruptButton.MouseButton1Click:Connect(function()
				buttonPressed(AutoSpawnCorruptButton, "AutoSpawnCorrupt")
			end)
		end

		local list = uiFrame:FindFirstChild("ListFrame"):FindFirstChild("ValuesList"):GetChildren()

		if list then
			for _, i in list do
				if i:IsA("TextButton") then
					i.MouseButton1Click:Connect(function()
						buttonPressed(i)
					end)
				end
			end
		end

		local amount: TextBox = uiFrame:FindFirstChild("AmountTextBox")

		if amount then
			amount.FocusLost:Connect(function()
				local number = tonumber(amount.Text)

				if number and number <= 100 and number >= 1 then
					values["amount"] = number
				elseif number and number > 100 then
					amount.Text = "100"
				elseif number and number < 1 then
					amount.Text = "1"
				else
					amount.Text = "50"
				end
			end)
		end

		local corruptButton = uiFrame:FindFirstChild("CorruptButton")

		if corruptButton then
			corruptButton.MouseButton1Click:Connect(function()
				corruptObjects(corruptButton)
			end)
		end
	end
end

function createUi()
	local ui = Instance.new("ScreenGui")
	ui.Name = "CorruptorGUI"
	ui.IgnoreGuiInset = true
	ui.ResetOnSpawn = false
	ui.DisplayOrder = 100
	if useCoreGui then
		ui.Parent = hiddenUi
	else
		ui.Parent = playerGui
	end

	local loadingFrame = Instance.new("TextLabel")
	loadingFrame.Name = "LoadingFrame"
	loadingFrame.BackgroundColor3 = Color3.new(0.141176, 0.137255, 0.129412)
	loadingFrame.Size = UDim2.fromScale(1, 1)
	loadingFrame.Text = [[
	Loading Roblox Corruption UI!
	Thanks for using! :D
	Credits to HGTP (Me)!
	]]
	loadingFrame.TextScaled = true
	loadingFrame.TextColor3 = Color3.new(0.901961, 0.929412, 0.980392)
	loadingFrame.ZIndex = 100
	loadingFrame.Parent = ui
	loadingFrame.BackgroundTransparency = 0.35

	local frame = Instance.new("Frame")
	frame.Name = "Main"
	frame.BackgroundColor3 = Color3.fromRGB(41, 43, 44)
	frame.BackgroundTransparency = 0.5
	frame.Size = UDim2.fromScale(1, 0.8)
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.Position = UDim2.fromScale(0.5, 1.5)
	frame.Parent = ui
	local ratio = Instance.new("UIAspectRatioConstraint")
	ratio.AspectRatio = 0.72
	ratio.Parent = frame
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0.06, 0)
	corner.Parent = frame

	local hideButton = Instance.new("TextButton")
	hideButton.Name = "HideButton"
	hideButton.BackgroundColor3 = Color3.fromRGB(31, 32, 33)
	hideButton.BackgroundTransparency = 0.4
	hideButton.Size = UDim2.fromScale(1, 0.10)
	hideButton.AnchorPoint = Vector2.new(0.5, 1)
	hideButton.Position = UDim2.fromScale(0.5, 0)
	hideButton.Text = "  "..versionNumber.." | Show Corruptor  "
	hideButton.TextColor3 = Color3.fromRGB(241, 243, 233)
	hideButton.TextScaled = true
	hideButton.Parent = frame

	local corruptButton = Instance.new("TextButton")
	corruptButton.Name = "CorruptButton"
	corruptButton.BackgroundColor3 = Color3.fromRGB(46, 48, 50)
	corruptButton.BackgroundTransparency = 0.35
	corruptButton.Size = UDim2.fromScale(0.85, 0.15)
	corruptButton.AnchorPoint = Vector2.new(0.5, 0.5)
	corruptButton.Position = UDim2.fromScale(0.5, 0.11)
	corruptButton.Text = "Corrupt"
	corruptButton.TextColor3 = Color3.fromRGB(241, 243, 233)
	corruptButton.TextScaled = true
	corruptButton.Parent = frame
	
	local listFrame = Instance.new("Frame")
	listFrame.Name = "ListFrame"
	listFrame.BackgroundColor3 = Color3.fromRGB(41, 43, 44)
	listFrame.BackgroundTransparency = 0.5
	listFrame.Size = UDim2.fromScale(0.8, 0.8)
	listFrame.AnchorPoint = Vector2.new(1, 0.5)
	listFrame.Position = UDim2.fromScale(-0.1, 0.5)
	listFrame.Parent = frame
	local ratio = Instance.new("UIAspectRatioConstraint")
	ratio.AspectRatio = 0.72
	ratio.Parent = listFrame
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0.055, 0)
	corner.Parent = listFrame

	local list = Instance.new("ScrollingFrame")
	list.Name = "ValuesList"
	list.BackgroundColor3 = Color3.fromRGB(41, 43, 44)
	list.BackgroundTransparency = 0.4
	list.Size = UDim2.fromScale(0.9, 0.92)
	list.AnchorPoint = Vector2.new(0.5, 0.5)
	list.Position = UDim2.fromScale(0.5, 0.5)
	list.ScrollBarThickness = 10
	list.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
	list.CanvasSize = UDim2.fromScale(0, 6)
	list.Parent = listFrame
	local layout = Instance.new("UIListLayout")
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.Padding = UDim.new(0.004, 0)
	layout.SortOrder = Enum.SortOrder.Name
	layout.Parent = list

	for i, e in values do
		if i == "amount" then
			local amountText = Instance.new("TextBox")
			amountText.Text = 50
			amountText.Size = UDim2.fromScale(0.4, 0.4)
			amountText.BackgroundColor3 = Color3.fromRGB(41, 43, 44)
			amountText.BackgroundTransparency = 0.4
			amountText.TextScaled = true
			amountText.TextColor3 = Color3.fromRGB(250, 249, 243)
			amountText.Name = "AmountTextBox"
			amountText.Active = true
			amountText.AnchorPoint = Vector2.new(1, 0)
			amountText.Position = UDim2.fromScale(0.96, 0.25)
			amountText.Parent = frame
			local ratio = Instance.new("UIAspectRatioConstraint")
			ratio.AspectRatio = 2
			ratio.Parent = amountText
			local amountTextText = Instance.new("TextLabel")
			amountTextText.Size = UDim2.fromScale(0.48, 0.48)
			amountTextText.Position = UDim2.fromScale(0.05, 0.32)
			amountTextText.AnchorPoint = Vector2.new(0, 0.5)
			amountTextText.Text = "Amount of Corruption"
			amountTextText.TextXAlignment = Enum.TextXAlignment.Center
			amountTextText.TextYAlignment = Enum.TextYAlignment.Center
			amountTextText.TextScaled = true
			amountTextText.BackgroundTransparency = 0.85
			amountTextText.TextColor3 = Color3.fromRGB(179, 183, 189)
			amountTextText.TextStrokeTransparency = 0.25
			amountTextText.TextStrokeColor3 = Color3.fromRGB(26, 25, 23)
			amountTextText.TextWrapped = true
			amountTextText.Parent = frame
			local ratio = Instance.new("UIAspectRatioConstraint")
			ratio.AspectRatio = 2.6
			ratio.Parent = amountTextText
		else
			local button = Instance.new("TextButton")
			button.Text = i
			button.Size = UDim2.fromScale(0.9, 0.9)
			button.BackgroundColor3 = Color3.fromRGB(41, 43, 44)
			button.BackgroundTransparency = 0.4
			button.TextScaled = true
			button.TextColor3 = Color3.fromRGB(250, 249, 243)
			button.Name = i
			button.Parent = list
			local ratio = Instance.new("UIAspectRatioConstraint")
			ratio.AspectRatio = 3.3
			ratio.Parent = button
		end
	end

	local workspaceEnabledButton = Instance.new("TextButton")
	workspaceEnabledButton.Text = "Corrupt Workspace?"
	workspaceEnabledButton.Size = UDim2.fromScale(0.43, 0.4)
	workspaceEnabledButton.BackgroundColor3 = Color3.fromRGB(41, 43, 44)
	workspaceEnabledButton.BackgroundTransparency = 0.4
	workspaceEnabledButton.TextScaled = true
	workspaceEnabledButton.TextColor3 = Color3.fromRGB(250, 249, 243)
	workspaceEnabledButton.Name = "WSEButton"
	workspaceEnabledButton.Active = true
	workspaceEnabledButton.AnchorPoint = Vector2.new(0, 0)
	workspaceEnabledButton.Position = UDim2.fromScale(0.04, 0.42)
	workspaceEnabledButton.Parent = frame
	local ratio = Instance.new("UIAspectRatioConstraint")
	ratio.AspectRatio = 2
	ratio.Parent = workspaceEnabledButton

	local RSAndRFEnabledButton = Instance.new("TextButton")
	RSAndRFEnabledButton.Text = "Corrupt Replicated Storage and Replicated First?"
	RSAndRFEnabledButton.Size = UDim2.fromScale(0.43, 0.4)
	RSAndRFEnabledButton.BackgroundColor3 = Color3.fromRGB(41, 43, 44)
	RSAndRFEnabledButton.BackgroundTransparency = 0.4
	RSAndRFEnabledButton.TextScaled = true
	RSAndRFEnabledButton.TextColor3 = Color3.fromRGB(250, 249, 243)
	RSAndRFEnabledButton.Name = "RSRFButton"
	RSAndRFEnabledButton.Active = true
	RSAndRFEnabledButton.AnchorPoint = Vector2.new(1, 0)
	RSAndRFEnabledButton.Position = UDim2.fromScale(0.96, 0.42)
	RSAndRFEnabledButton.Parent = frame
	local ratio = Instance.new("UIAspectRatioConstraint")
	ratio.AspectRatio = 2
	ratio.Parent = RSAndRFEnabledButton

	local spawnAutoCorruptButton = Instance.new("TextButton")
	spawnAutoCorruptButton.Text = "Auto Corrupt Objects on Create"
	spawnAutoCorruptButton.Size = UDim2.fromScale(0.43, 0.4)
	spawnAutoCorruptButton.BackgroundColor3 = Color3.fromRGB(41, 43, 44)
	spawnAutoCorruptButton.BackgroundTransparency = 0.4
	spawnAutoCorruptButton.TextScaled = true
	spawnAutoCorruptButton.TextColor3 = Color3.fromRGB(250, 249, 243)
	spawnAutoCorruptButton.Name = "AutoSpawnCorruptButton"
	spawnAutoCorruptButton.Active = true
	spawnAutoCorruptButton.AnchorPoint = Vector2.new(1, 0)
	spawnAutoCorruptButton.Position = UDim2.fromScale(0.96, 0.58)
	spawnAutoCorruptButton.Parent = frame
	local ratio = Instance.new("UIAspectRatioConstraint")
	ratio.AspectRatio = 2
	ratio.Parent = spawnAutoCorruptButton

	local infoText = Instance.new("TextLabel")
	infoText.Size = UDim2.fromScale(0.85, 0.85)
	infoText.Position = UDim2.fromScale(1.1, 0.5)
	infoText.AnchorPoint = Vector2.new(0, 0.5)
	infoText.Text = info
	infoText.TextXAlignment = Enum.TextXAlignment.Left
	infoText.TextYAlignment = Enum.TextYAlignment.Center
	infoText.TextSize = 14
	infoText.BackgroundTransparency = 1
	infoText.TextColor3 = Color3.fromRGB(179, 183, 189)
	infoText.TextStrokeTransparency = 0.25
	infoText.TextStrokeColor3 = Color3.fromRGB(26, 25, 23)
	infoText.TextWrapped = true
	infoText.Parent = frame

	for _, i in ipairs(frame:GetDescendants()) do
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0.4, 0)
		corner.Parent = i
	end

	task.wait(1)

	loadingFrame.Text = "Loading finished!"

	uiFrame = frame
	
	task.wait(1)
	
	loadingFrame.Text = "Be careful which games you use this on!!!"
	
	uiEnabled = true
	
	task.spawn(start)

	task.wait(2.5)
	
	local tween = tweenService:Create(loadingFrame, tweenInfo, {BackgroundTransparency = 1, TextTransparency = 1})
	tween:Play()
	tween.Completed:Connect(function()
		loadingFrame:Destroy()
	end)
end

function toggleUi()
	if uiFrame then
		if uiToggled then
			uiToggled = false

			local hideButton = uiFrame:FindFirstChild("HideButton")

			if hideButton then
				hideButton.Text = "  "..versionNumber.." | Show Corruptor  "
			end

			local tween = tweenService:Create(uiFrame, tweenInfo, {Position = UDim2.fromScale(0.5, 1.4)})
			tween:Play()
		else
			uiToggled = true

			local hideButton = uiFrame:FindFirstChild("HideButton")

			if hideButton then
				hideButton.Text = "  "..versionNumber.." | Hide Corruptor  "
			end

			local tween = tweenService:Create(uiFrame, tweenInfo, {Position = UDim2.fromScale(0.5, 0.54)})
			tween:Play()
		end
	end
end

function buttonPressed(button, otherVal)
	if button and otherVal == "RSRF" then
		corruptRSAndRF = not corruptRSAndRF

		if corruptRSAndRF then
			local tween = tweenService:Create(button, tweenInfoButtons, {BackgroundColor3 = Color3.fromRGB(152, 151, 147)})
			tween:Play()
		else
			local tween = tweenService:Create(button, tweenInfoButtons, {BackgroundColor3 = Color3.fromRGB(41, 43, 44)})
			tween:Play()
		end
	elseif button and otherVal == "WS" then
		corruptWorkspace = not corruptWorkspace

		if corruptWorkspace then
			local tween = tweenService:Create(button, tweenInfoButtons, {BackgroundColor3 = Color3.fromRGB(152, 151, 147)})
			tween:Play()
		else
			local tween = tweenService:Create(button, tweenInfoButtons, {BackgroundColor3 = Color3.fromRGB(41, 43, 44)})
			tween:Play()
		end
	elseif button and otherVal == "AutoSpawnCorrupt" then
		autoObjectCreateCorrupt = not autoObjectCreateCorrupt

		if autoObjectCreateCorrupt then
			local tween = tweenService:Create(button, tweenInfoButtons, {BackgroundColor3 = Color3.fromRGB(152, 151, 147)})
			tween:Play()
		else
			local tween = tweenService:Create(button, tweenInfoButtons, {BackgroundColor3 = Color3.fromRGB(41, 43, 44)})
			tween:Play()
		end
	else
		if button then
			for i, e in values do
				if i == button.Text then
					if not e then
						values[i] = true

						local tween = tweenService:Create(button, tweenInfoButtons, {BackgroundColor3 = Color3.fromRGB(152, 151, 147)})
						tween:Play()
					else
						values[i] = false

						local tween = tweenService:Create(button, tweenInfoButtons, {BackgroundColor3 = Color3.fromRGB(41, 43, 44)})
						tween:Play()
					end
				end
			end
		end
	end
end

function renderStepped()
	if uiEnabled and uiToggled then
		if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		end
		if not UserInputService.MouseIconEnabled then
			UserInputService.MouseIconEnabled = true
		end
	end
end

function inputBegan(input:InputObject)
	if uiEnabled then
		if input.KeyCode == Enum.KeyCode.Q then
			toggleUi()
		end
	end
end

function onObjectCreated(gameObject)
	if autoObjectCreateCorrupt then
		if gameObject then
			if corruptWholeGame then
				corruptSpecificObject(gameObject)
			elseif gameObject:IsDescendantOf(workspace) and corruptWorkspace then
				corruptSpecificObject(gameObject)
			elseif (gameObject:IsDescendantOf(game:GetService("ReplicatedStorage")) or gameObject:IsDescendantOf(game:GetService("ReplicatedFirst"))) and corruptRSAndRF then
				corruptSpecificObject(gameObject)
			end
		end
	end
end

-- Exec --

task.spawn(createUi)

RunService.RenderStepped:Connect(renderStepped)

UserInputService.InputBegan:Connect(inputBegan)

game.DescendantAdded:Connect(onObjectCreated)
