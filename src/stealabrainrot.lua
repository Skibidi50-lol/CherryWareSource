--random sab speedhack lol
local ReGui = loadstring(game:HttpGet('https://raw.githubusercontent.com/depthso/Dear-ReGui/refs/heads/main/ReGui.lua'))()

ReGui:DefineTheme("Cherry", {
    TitleAlign = Enum.TextXAlignment.Center,
    TextDisabled = Color3.fromRGB(120, 100, 120),
    Text = Color3.fromRGB(200, 180, 200),

    FrameBg = Color3.fromRGB(25, 20, 25),
    FrameBgTransparency = 0.4,
    FrameBgActive = Color3.fromRGB(120, 100, 120),
    FrameBgTransparencyActive = 0.4,

    CheckMark = Color3.fromRGB(150, 100, 150),
    SliderGrab = Color3.fromRGB(150, 100, 150),
    ButtonsBg = Color3.fromRGB(150, 100, 150),
    CollapsingHeaderBg = Color3.fromRGB(150, 100, 150),
    CollapsingHeaderText = Color3.fromRGB(200, 180, 200),
    RadioButtonHoveredBg = Color3.fromRGB(150, 100, 150),

    WindowBg = Color3.fromRGB(35, 30, 35),
    TitleBarBg = Color3.fromRGB(35, 30, 35),
    TitleBarBgActive = Color3.fromRGB(50, 45, 50),

    Border = Color3.fromRGB(50, 45, 50),
    ResizeGrab = Color3.fromRGB(50, 45, 50),
    RegionBgTransparency = 1,
})

local speedHackEnabled = false
local currentSpeed = 50

game:GetService("RunService").Heartbeat:Connect(function()
    pcall(function()
        if speedHackEnabled then
            local cam = workspace.CurrentCamera
            local move = Vector3.zero
            local character = game.Players.LocalPlayer.Character
            local root = character and character:FindFirstChild("HumanoidRootPart")

            if not root then return end

            local forward = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z).Unit
            local right = Vector3.new(cam.CFrame.RightVector.X, 0, cam.CFrame.RightVector.Z).Unit

            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                move += forward
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                move -= forward
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                move -= right
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                move += right
            end

            if move.Magnitude > 0 then
                root.Velocity = move.Unit * currentSpeed
            end
        end
    end)
end)

local Window = ReGui:Window({
    Title = "Steal A Brainrot - Cherry Ware",
    Theme = "Cherry",
    Size = UDim2.fromOffset(300, 200)
}):Center()

Window:Checkbox({
    Value = speedHackEnabled,
    Label = "WalkSpeed",
    Callback = function(self, Value: boolean)
        speedHackEnabled = Value
    end
})

Window:Slider({
    Value = currentSpeed,
    Min = 10,
    Max = 200,
    Label = "Speed",
    Callback = function(self, Value: number)
        currentSpeed = Value
    end
})
