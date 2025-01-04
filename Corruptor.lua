-- Var --

local tweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut, 0, false, 0)
local tweenInfoButtons = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0)

local player = game.Players.LocalPlayer

local playerGui = player.PlayerGui
local soundService = game:GetService("SoundService")
local lighting = game.Lighting

local uiToggled = true

local uiFrame = nil

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
	ui = false,
	lighting = false,
	screen = false,
	camera = false,
	shape = false,
	fog = false,
	light = false,
}

local corruptionDebounce = false

local info = [[
Thanks for using HGTP's RBLX Corrupter!

This is a little GUI to simulate Roblox corruptions, 
doesn't actually corrupt the game though.
Not made to cheat, that was a warn!

WARNING!!! Some games have anti-cheats, also recommend 
using a private server! Recommended to use a alt account!

The amount of corruption can go from 1, to 100.

How to use :
1. Click all the buttons in the middle you want to be modified. 
(It will show a brighter color turned on.)
2. Set a custom value for the amount of corruption. 
(Recommend a smaller value with more buttons clicked.)
3. Click the corrupt button!
4. Watch as objects, sounds, etc. change in real time!

Note - Big games with a lot of objects may take a while to finish corrupting!

Note - This is all client sided so other players will only see 
you floating, going through objects, etc.
]]

-- Func --

function createUi()
	local ui = Instance.new("ScreenGui")
	ui.Name = "CorruptorGUI"
	ui.IgnoreGuiInset = true
	ui.ResetOnSpawn = false
	ui.DisplayOrder = 100
	ui.Parent = game.Players.LocalPlayer.PlayerGui

	local loadingFrame = Instance.new("TextLabel")
	loadingFrame.Name = "LoadingFrame"
	loadingFrame.BackgroundColor3 = Color3.new(0.141176, 0.137255, 0.129412)
	loadingFrame.Size = UDim2.fromScale(1, 1)
	loadingFrame.Text = "Loading Roblox Corruption UI! Thanks for using! :D Credits to HGTP!"
	loadingFrame.TextScaled = true
	loadingFrame.TextColor3 = Color3.new(0.901961, 0.929412, 0.980392)
	loadingFrame.ZIndex = 100
	loadingFrame.Parent = ui
	loadingFrame.BackgroundTransparency = 0.35

	local frame = Instance.new("Frame")
	frame.Name = "Main"
	frame.BackgroundColor3 = Color3.fromRGB(41, 43, 44)
	frame.BackgroundTransparency = 0.5
	frame.Size = UDim2.fromScale(0.6, 0.6)
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
	hideButton.Text = "V1 | Hide Corruptor"
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

	local list = Instance.new("ScrollingFrame")
	list.Name = "ValuesList"
	list.BackgroundColor3 = Color3.fromRGB(41, 43, 44)
	list.BackgroundTransparency = 0.4
	list.Size = UDim2.fromScale(0.9, 0.75)
	list.AnchorPoint = Vector2.new(0.5, 0.5)
	list.Position = UDim2.fromScale(0.5, 0.6)
	list.ScrollBarThickness = 10
	list.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
	list.CanvasSize = UDim2.fromScale(0, 4.5)
	list.Parent = frame
	local layout = Instance.new("UIListLayout")
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.Padding = UDim.new(0.004, 0)
	layout.SortOrder = Enum.SortOrder.Name
	layout.Parent = list

	for i, e in values do
		if i == "amount" then
			local amountText = Instance.new("TextBox")
			amountText.Text = 50
			amountText.Size = UDim2.fromScale(0.9, 0.9)
			amountText.BackgroundColor3 = Color3.fromRGB(41, 43, 44)
			amountText.BackgroundTransparency = 0.4
			amountText.TextColor3 = Color3.fromRGB(241, 243, 233)
			amountText.TextScaled = true
			amountText.TextColor3 = Color3.fromRGB(250, 249, 243)
			amountText.Name = i
			amountText.Active = true
			amountText.Parent = list
			local ratio = Instance.new("UIAspectRatioConstraint")
			ratio.AspectRatio = 3.3
			ratio.Parent = amountText
		else
			local button = Instance.new("TextButton")
			button.Text = i
			button.Size = UDim2.fromScale(0.9, 0.9)
			button.BackgroundColor3 = Color3.fromRGB(41, 43, 44)
			button.BackgroundTransparency = 0.4
			button.TextColor3 = Color3.fromRGB(241, 243, 233)
			button.TextScaled = true
			button.TextColor3 = Color3.fromRGB(250, 249, 243)
			button.Name = i
			button.Parent = list
			local ratio = Instance.new("UIAspectRatioConstraint")
			ratio.AspectRatio = 3.3
			ratio.Parent = button
		end
	end

	local infoText = Instance.new("TextLabel")
	infoText.Size = UDim2.fromScale(1, 1)
	infoText.Position = UDim2.fromScale(1, 0)
	infoText.Text = info
	infoText.TextXAlignment = Enum.TextXAlignment.Left
	infoText.TextYAlignment = Enum.TextYAlignment.Top
	infoText.TextSize = 12
	infoText.BackgroundTransparency = 1
	infoText.TextColor3 = Color3.fromRGB(179, 183, 189)
	infoText.Parent = frame

	for _, i in ipairs(frame:GetDescendants()) do
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0.4, 0)
		corner.Parent = i
	end

	task.wait(3)

	loadingFrame.Text = "Loading finished!"

	uiFrame = frame

	task.wait(3)

	loadingFrame:Destroy()

	start()
end

function start()
	if uiFrame then
		local tween = tweenService:Create(uiFrame, tweenInfo, {Position = UDim2.fromScale(0.5, 0.5)})
		tween:Play()

		local hideButton = uiFrame:FindFirstChild("HideButton")

		if hideButton then
			hideButton.MouseButton1Click:Connect(toggleUi)
		end

		local list = uiFrame:FindFirstChild("ValuesList")

		if list then
			for _, i in list:GetChildren() do
				if i:IsA("TextButton") then
					i.MouseButton1Click:Connect(function()
						buttonPressed(i)
					end)
				end
			end
		end

		local amount: TextBox = list:FindFirstChild("amount")

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

function toggleUi()
	if uiFrame then
		if uiToggled then
			uiToggled = false

			local hideButton = uiFrame:FindFirstChild("HideButton")

			if hideButton then
				hideButton.Text = "V1 | Show Corruptor"
			end

			local tween = tweenService:Create(uiFrame, tweenInfo, {Position = UDim2.fromScale(0.5, 1.3)})
			tween:Play()
		else
			uiToggled = true

			local hideButton = uiFrame:FindFirstChild("HideButton")

			if hideButton then
				hideButton.Text = "V1 | Hide Corruptor"
			end

			local tween = tweenService:Create(uiFrame, tweenInfo, {Position = UDim2.fromScale(0.5, 0.5)})
			tween:Play()
		end
	end
end

function buttonPressed(button)
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

function corruptObjects(button)
	if not corruptionDebounce then
		corruptionDebounce = true

		button.Text = "Corrupting..."

		for i, e in values do
			if e then
				if i == "position" then
					for _, i in workspace:GetDescendants() do
						local chance = math.random(1, 100)
						if chance <= values["amount"] then
							if i:IsA("Part") or i:IsA("UnionOperation") then
								i:PivotTo(i.CFrame * CFrame.new(Vector3.new(math.random(1.5, 4.0), math.random(1.5, 4.0), math.random(1.5, 4.0))))
							elseif i:IsA("Model") then
								i:PivotTo(i.WorldPivot * CFrame.new(Vector3.new(math.random(1.5, 4.0), math.random(1.5, 4.0), math.random(1.5, 4.0))))
							end
						end
					end
				elseif i == "rotation" then
					for _, i in workspace:GetDescendants() do
						local chance = math.random(1, 100)
						if chance <= values["amount"] then
							if i:IsA("Part") or i:IsA("UnionOperation") then
								i.Rotation += Vector3.new(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
							end
						end
					end
				elseif i == "size" then
					for _, i in workspace:GetDescendants() do
						local chance = math.random(1, 100)
						if chance <= values["amount"] then
							if i:IsA("Part") or i:IsA("UnionOperation") then
								i.Size += Vector3.new(math.random(-20, 20), math.random(-20, 20), math.random(-20, 20))
							end
						end
					end
				elseif i == "color" then
					for _, i in workspace:GetDescendants() do
						local chance = math.random(1, 100)
						if chance <= values["amount"] then
							if i:IsA("Part") then
								i.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
							elseif i:IsA("UnionOperation") then
								i.UsePartColor = true
								i.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
							end
						end
					end
				elseif i == "material" then
					for _, i in workspace:GetDescendants() do
						local chance = math.random(1, 100)
						if chance <= values["amount"] then
							if i:IsA("Part") or i:IsA("UnionOperation") then
								i.Material = Enum.Material:GetEnumItems()[math.random(1, #Enum.Material:GetEnumItems())]
							end
						end
					end
				elseif i == "shape" then
					for _, i in workspace:GetDescendants() do
						local chance = math.random(1, 100)
						if chance <= values["amount"] then
							if i:IsA("Part") then
								i.Shape = Enum.PartType:GetEnumItems()[math.random(1, #Enum.PartType:GetEnumItems())]
							end
						end
					end
				elseif i == "ui" then
					for _, i in playerGui:GetChildren() do
						if i.Name ~= "CorruptorGUI" and i:IsA("GuiBase") then
							for _, i in i:GetDescendants() do
								local chance = math.random(1, 100)
								if chance <= values["amount"] then
									if i:IsA("GuiObject") then
										i.Position += UDim2.fromOffset(math.random(-50, 50), math.random(-50, 50))
										i.Rotation += math.random(-360, 360)
										i.Size += UDim2.fromOffset(math.random(-50, 50), math.random(-50, 50))
										i.BackgroundTransparency = (math.random(0, 10) / 10)
										i.BackgroundColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
										if i:IsA("TextLabel") or i:IsA("TextButton") or i:IsA("TextBox") then
											i.TextTransparency = (math.random(0, 10) / 10)
											i.TextColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
										end
										i.BorderColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
									end
								end
							end
						end
					end

					for _, i in workspace:GetDescendants() do
						if i:IsA("GuiBase") then
							for _, i in i:GetDescendants() do
								local chance = math.random(1, 100)
								if chance <= values["amount"] then
									if i:IsA("GuiObject") then
										i.Position += UDim2.fromOffset(math.random(-50, 50), math.random(-50, 50))
										i.Rotation += math.random(-360, 360)
										i.Size += UDim2.fromOffset(math.random(-50, 50), math.random(-50, 50))
										i.BackgroundTransparency = (math.random(0, 10) / 10)
										i.BackgroundColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
										if i:IsA("TextLabel") or i:IsA("TextButton") or i:IsA("TextBox") then
											i.TextTransparency = (math.random(0, 10) / 10)
											i.TextColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
										end
										i.BorderColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
									end
								end
							end
						end
					end
				elseif i == "volume" then
					local function audioVolume()
						local val = math.random(1, 4)
						if val == 1 then
							return 0
						elseif val == 2 then
							return 0.5
						elseif val == 3 then
							return 5
						elseif val == 4 then
							return 10
						end
					end

					for _, i in workspace:GetDescendants() do
						local chance = math.random(1, 100)
						if chance <= values["amount"] then
							if i:IsA("Sound") then
								i.Volume = audioVolume()
							end
						end
					end

					for _, i in soundService:GetDescendants() do
						local chance = math.random(1, 100)
						if chance <= values["amount"] then
							if i:IsA("Sound") then
								i.Volume = audioVolume()
							end
						end
					end
				elseif i == "pitch" then
					local function audioPitch()
						local val = math.random(1, 3)
						if val == 1 then
							return 0.5
						elseif val == 2 then
							return 2
						elseif val == 3 then
							return 5
						end
					end

					for _, i in workspace:GetDescendants() do
						local chance = math.random(1, 100)
						if chance <= values["amount"] then
							if i:IsA("Sound") then
								i.PlaybackSpeed = audioPitch()
							end
						end
					end

					for _, i in soundService:GetDescendants() do
						local chance = math.random(1, 100)
						if chance <= values["amount"] then
							if i:IsA("Sound") then
								i.PlaybackSpeed = audioPitch()
							end
						end
					end
				elseif i == "reverb" then
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
				elseif i == "humanoid" then
					for _, i in workspace:GetDescendants() do
						local chance = math.random(1, 100)
						if chance <= values["amount"] then
							if i:IsA("Humanoid") then
								local function randomTOrF()
									local random = math.random(1, 2)
									if random == 1 then
										return true
									elseif random == 2 then
										return false
									end
								end

								i.UseJumpPower = true
								i.Sit = randomTOrF()
								i.PlatformStand = randomTOrF()
								i.WalkSpeed = (math.random(0, 10000) / 10)
								i.JumpPower = (math.random(0, 10000) / 10)
							end
						end
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
				elseif i == "light" then
					for _, i in workspace:GetDescendants() do
						local chance = math.random(1, 100)
						if chance <= values["amount"] then
							if i:IsA("Light") then
								i.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
								i.Brightness = (math.random(0, 500) / 10)
								i.Range = math.random(0, 100)
							end
						end
					end
				end
			end
		end

		button.Text = "Corrupt"

		corruptionDebounce = false
	end
end

-- Exec --

createUi()
