--Simple Silent Aim + ESP

local NEVERLOSE = loadstring(game:HttpGet("https://raw.githubusercontent.com/Skibidi50-lol/CherryWareSource/refs/heads/main/crackscript/src/ui/ronix.lua"))()
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/linemaster2/esp-library/main/library.lua"))();

local silentAimEnabled = false
local fovEnabled = false
local fovRadius = 50
local fovCircleColor = Color3.fromRGB(255, 255, 255)
local targetPartName = "Head" --change it if you want

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local fovCircle = Drawing.new("Circle")
fovCircle.Color = fovCircleColor
fovCircle.Thickness = 2
fovCircle.Filled = false
fovCircle.NumSides = 100
fovCircle.Radius = fovRadius
fovCircle.Visible = false
fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

RunService.RenderStepped:Connect(function()
	fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
	fovCircle.Radius = fovRadius
end)

local function getNearestTargetPart()
	local closestPlayer = nil
	local shortestDistance = math.huge
	local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(targetPartName) then
			local part = player.Character[targetPartName]
			local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)

			if onScreen then
				local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
				if screenDist < fovRadius and screenDist < shortestDistance then
					shortestDistance = screenDist
					closestPlayer = player
				end
			end
		end
	end

	if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild(targetPartName) then
		return closestPlayer.Character[targetPartName]
	end

	return nil
end

UserInputService.InputBegan:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.KeyCode == Enum.KeyCode.ButtonR2) and silentAimEnabled then
		local targetPart = getNearestTargetPart()
		if targetPart then
			local aimPosition = targetPart.Position
			Camera.CFrame = CFrame.new(Camera.CFrame.Position, aimPosition)
			ReplicatedStorage.Remotes.Attack:FireServer(targetPart)
		end
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		spamming = false
	end
end)

NEVERLOSE:Theme("nightly")

local Window = NEVERLOSE:AddWindow("CherryWare", "Rivals")

local MainTab = Window:AddTab("Combat", "crosshair")
local CombatSection = MainTab:AddSection("Aimbot Settings", "left")

CombatSection:AddToggle("Silent Aim", false, function(state)
    silentAimEnabled = state
end)

CombatSection:AddToggle("FOV Circle", false, function(state)
    fovEnabled = state
    fovCircle.Visible = state
end)

CombatSection:AddSlider("FOV Circle Size", 50, 500, 50, function(t)
    fovRadius = t
end)

local espTab = Window:AddTab("Visuals", "earth")
local espSection = espTab:AddSection("Visuals Settings", "left")

espSection:AddToggle("Enable ESP", false, function(state)
    ESP.Enabled = state
end)

espSection:AddToggle("Boxes", false, function(state)
    ESP.ShowBox = state
end)

espSection:AddToggle("Names", false, function(state)
    ESP.ShowName = state
end)

espSection:AddToggle("Health", false, function(state)
    ESP.ShowHealth = state
end)

espSection:AddToggle("Distance", false, function(state)
    ESP.ShowDistance = state
end)
