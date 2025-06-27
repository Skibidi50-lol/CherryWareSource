--CherryWare Beta | Testing | Custom UI & More

local InfiniteJumpEnabled = false
local XrayEnabled = false
local Noclip = nil
local Clip = nil

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
backpack = game:GetService("Players").LocalPlayer.Backpack
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui")) 
gui.Name = "CustomNotificationUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

--Credit to https://scriptblox.com/script/Universal-Script-Noclip-5473 for the noclip script
function noclip()
    Clip = false
    local function Nocl()
        if Clip == false and game.Players.LocalPlayer.Character ~= nil then
            for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
                    v.CanCollide = false
                end
            end
        end
        wait(0.21)
    end
    Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
end

function clip()
    if Noclip then Noclip:Disconnect() end
    Clip = true
end

-- Notification function
function ShowNotification(title, text, duration)
    duration = duration or 3

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 250, 0, 80)
    frame.Position = UDim2.new(1, -260, 1, -100)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 0.2
    frame.Parent = gui
    frame.AnchorPoint = Vector2.new(0, 1)

    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 10)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = title
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, -20, 0, 24)
    titleLabel.Position = UDim2.new(0, 10, 0, 6)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = frame

    local messageLabel = Instance.new("TextLabel")
    messageLabel.Text = text
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextSize = 14
    messageLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Size = UDim2.new(1, -20, 1, -34)
    messageLabel.Position = UDim2.new(0, 10, 0, 30)
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextYAlignment = Enum.TextYAlignment.Top
    messageLabel.Parent = frame

    frame.Position = frame.Position + UDim2.new(0, 0, 0, 20)
    TweenService:Create(frame, TweenInfo.new(0.3), {Position = UDim2.new(1, -260, 1, -100)}):Play()

    task.delay(duration, function()
        TweenService:Create(frame, TweenInfo.new(0.3), {Position = frame.Position + UDim2.new(0, 0, 0, 20)}):Play()
        task.wait(0.3)
        frame:Destroy()
    end)
end

local IsOnMobile = table.find({
    Enum.Platform.IOS,
    Enum.Platform.Android
}, UserInputService:GetPlatform())
local iswave = false
if detourfunction then
    if not IsOnMobile then
        iswave = true
    end
end



local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local MainFrame = Instance.new("Frame")
local ScrollFrame = Instance.new("ScrollingFrame")
local WelcomeLabel = Instance.new("TextLabel")
local CreditsLabel = Instance.new("TextLabel")
local UIStroke = Instance.new("UIStroke")
local UICorner = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
-- Sound Effects
local HoverSound = Instance.new("Sound")
HoverSound.SoundId = "rbxassetid://9114454769"
HoverSound.Volume = 0.5
HoverSound.Parent = ScreenGui

local ClickSound = Instance.new("Sound")
ClickSound.SoundId = "rbxassetid://452267918"
ClickSound.Volume = 0.7
ClickSound.Parent = ScreenGui

-- Parent Setup
ScreenGui.Name = "CleanScriptHub"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
-- Toggle Button
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -25)
ToggleButton.Size = UDim2.new(0, 100, 0, 50)
ToggleButton.Text = "Toggle UI"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 14
ToggleButton.Active = true
ToggleButton.Draggable = true

UICorner:Clone().Parent = ToggleButton
UIStroke:Clone().Parent = ToggleButton
-- Main Frame
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BackgroundTransparency = 0.2
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -120)
MainFrame.Size = UDim2.new(0, 300, 0, 240)
MainFrame.Visible = true
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 25)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 40))
})

UIGradient.Rotation = 45
UIGradient.Parent = MainFrame
UICorner:Clone().Parent = MainFrame
UIStroke.Parent = MainFrame
UIStroke.Color = Color3.fromRGB(100, 100, 100)
UIStroke.Thickness = 2
-- Scroll Frame
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Parent = MainFrame
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.Size = UDim2.new(1, -10, 1, -40)
ScrollFrame.Position = UDim2.new(0, 5, 0, 30)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
ScrollFrame.ScrollBarThickness = 6
-- Welcome Label
WelcomeLabel.Parent = ScrollFrame
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.Position = UDim2.new(0, 0, 0, 10)
WelcomeLabel.Size = UDim2.new(1, 0, 0, 30)
WelcomeLabel.Text = "Welcome, " .. game.Players.LocalPlayer.Name
WelcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeLabel.Font = Enum.Font.GothamBold
WelcomeLabel.TextSize = 24
WelcomeLabel.TextTransparency = 0
-- Credits Label
CreditsLabel.Parent = ScrollFrame
CreditsLabel.BackgroundTransparency = 1
CreditsLabel.Position = UDim2.new(0, 0, 0, 40)
CreditsLabel.Size = UDim2.new(1, 0, 0, 20)
CreditsLabel.Text = "CREDITS BY JAMAL_HYROX For the UI"
CreditsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
CreditsLabel.Font = Enum.Font.Gotham
CreditsLabel.TextSize = 14
-- Button Creation Function
local function createScriptButton(name, scriptContent, parent, position)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(0.3, 0, 0, 40)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 12
    button.AutoButtonColor = false
    button.Parent = parent
    local uiCorner = UICorner:Clone()
    uiCorner.Parent = button
    local uiStroke = UIStroke:Clone()
    uiStroke.Parent = button
    -- Hover Effects
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        HoverSound:Play()
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end)
    -- Click Effect
    button.MouseButton1Click:Connect(function()
        ClickSound:Play()
        pcall(function()
            loadstring(scriptContent)()
        end)
    end)
    return button
end
-- Add Scripts
local scripts = {
    {
        name = "Sonic",
        script = [[
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 40
        ]]
    },

    {
        name = "UnSonic",
        script = [[
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        ]]
    },

    {
        name = "Jump Boost",
        script = [[
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 100
        ]]
    },

    {
        name = "UnJump Boost",
        script = [[
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
        ]]
    },

    {
        name = "Infinite Yield",
        script = [[
            if IsOnMobile then
                loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/mobile-delta-inf-yield/main/deltainfyield.txt"))()
            else
                loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
            end
        ]]
    },

    {
        name = "Nameless Admin",
        script = [[
            loadstring(game:HttpGet('https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source'))()
        ]]
    },

    {
        name = "CMD Admin",
        script = [[
           loadstring(game:HttpGet("https://raw.githubusercontent.com/lxte/cmd/main/main.lua"))()
        ]]
    },

    {
        name = "Aimbot GUI",
        script = [[
            loadstring(game:HttpGet('https://raw.githubusercontent.com/Skibidi50-lol/SyntixCode/refs/heads/main/Aimbot.lua'))()
        ]]
    },

    {
        name = "Flashback",
        script = [[
            loadstring(game:HttpGet("https://mscripts.vercel.app/scfiles/reverse-script.lua"))()
        ]]
    },

    {
        name = "Mobile Keyboard",
        script = [[
            loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt"))()
        ]]
    },

    {
        name = "ShiftLock",
        script = [[
            loadstring(game:HttpGet("https://raw.githubusercontent.com/prosadaf/Example/refs/heads/main/Video"))()
        ]]
    },

    {name = "FPS Shower", script = [[-- Services
    local RunService = game:GetService("RunService")
    local Stats = game:GetService("Stats")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local StarterGui = game:GetService("StarterGui")

    -- Create GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FPS_Ping_Display"
    ScreenGui.Parent = game:GetService("CoreGui")

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 200, 0, 80)
    Frame.Position = UDim2.new(0.7, 0, 0.05, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Frame.BackgroundTransparency = 0.3
    Frame.BorderSizePixel = 2
    Frame.Parent = ScreenGui
    Frame.Active = true
    Frame.Draggable = true -- Makes the GUI movable

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0.3, 0)
    TitleLabel.Position = UDim2.new(0, 0, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "FPS & Ping counter"
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.TextSize = 16
    TitleLabel.TextColor3 = Color3.new(1, 1, 1)
    TitleLabel.Parent = Frame

    local FPSText = Instance.new("TextLabel")
    FPSText.Size = UDim2.new(1, 0, 0.35, 0)
    FPSText.Position = UDim2.new(0, 0, 0.3, 0)
    FPSText.BackgroundTransparency = 1
    FPSText.Font = Enum.Font.SourceSansBold
    FPSText.TextSize = 16
    FPSText.TextColor3 = Color3.new(1, 1, 1)
    FPSText.Parent = Frame

    local PingText = Instance.new("TextLabel")
    PingText.Size = UDim2.new(1, 0, 0.35, 0)
    PingText.Position = UDim2.new(0, 0, 0.65, 0)
    PingText.BackgroundTransparency = 1
    PingText.Font = Enum.Font.SourceSansBold
    PingText.TextSize = 16
    PingText.TextColor3 = Color3.new(1, 1, 1)
    PingText.Parent = Frame
    -- Send a welcoming notification to the player
    StarterGui:SetCore("SendNotification", {
        Title = "Yippee!",
        Text = "Thanks you for choosing this script!",
        Icon = "rbxassetid://15652789465", -- New icon ID
        Duration = 5
    })

    -- Update FPS & Ping every second
    task.spawn(function()
        while true do
            -- FPS Calculation
            local fps = math.floor(1 / RunService.RenderStepped:Wait())
            -- Ping Calculation
            local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            -- FPS Rating
            local fpsRating = (fps > 60 and "Excellent (Ultra Smooth)") or 
                            (fps >= 30 and "Playable") or 
                            "Choppy (Bad)"
            -- Ping Rating
            local pingRating = (ping <= 50 and "Good") or 
                            (ping <= 100 and "Decent") or 
                            "Bad (High Ping)"
            -- Update GUI Text
            FPSText.Text = "FPS: " .. fps .. " (" .. fpsRating .. ")"
            PingText.Text = "Ping: " .. ping .. "ms (" .. pingRating .. ")"
            task.wait(1) -- Update every second
        end
    end)]]},

    {
        name = "Low GFX",
        script = [[
            local Terrain = game:GetService("Workspace"):FindFirstChildOfClass('Terrain')
            Lighting = game:GetService("Lighting")
            Terrain.WaterWaveSize = 0
            Terrain.WaterWaveSpeed = 0
            Terrain.WaterReflectance = 0
            Terrain.WaterTransparency = 0
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
            for i,v in pairs(game:GetDescendants()) do
                if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                    v.Material = "Plastic"
                    v.Reflectance = 0
                elseif v:IsA("Decal") then
                    v.Transparency = 1
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Lifetime = NumberRange.new(0)
                elseif v:IsA("Explosion") then
                    v.BlastPressure = 1
                    v.BlastRadius = 1
                end
            end
            for i,v in pairs(Lighting:GetDescendants()) do
                if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                    v.Enabled = false
                end
            end
            game:GetService("Workspace").DescendantAdded:Connect(function(child)
                task.spawn(function()
                    if child:IsA('ForceField') then
                        game:GetService("RunService").Heartbeat:Wait()
                        child:Destroy()
                    elseif child:IsA('Sparkles') then
                        game:GetService("RunService").Heartbeat:Wait()
                        child:Destroy()
                    elseif child:IsA('Smoke') or child:IsA('Fire') then
                        game:GetService("RunService").Heartbeat:Wait()
                        child:Destroy()
                    end
                end)
            end)
        ]]
    },

    {
        name = "Aimbot TC",
        script = [[
            local UIS = game:GetService("UserInputService")
            local RunService = game:GetService("RunService")

            local _G = _G
            _G.aim = false -- Flag to track whether the aimbot is active
            local aimingConnection -- Store the connection to RenderStepped

            -- Function to get the closest enemy player
            function getClosest()
                local closestDistance = math.huge  -- Start with a very large number
                local closestPlayer = nil

                -- Loop through all players in the game
                for _, player in pairs(game.Players:GetChildren()) do
                    if player ~= game.Players.LocalPlayer and player.Team ~= game.Players.LocalPlayer.Team then
                        local character = player.Character
                        if character and character:FindFirstChild("HumanoidRootPart") then
                            -- Calculate the distance between the local player and the other player's HumanoidRootPart
                            local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
                            -- If the distance is smaller than the previous closest, update the closest player
                            if distance < closestDistance then
                                closestDistance = distance
                                closestPlayer = player
                            end
                        end
                    end
                end

                return closestPlayer
            end

            -- MouseButton2 pressed
            UIS.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton2 then
                    _G.aim = true  -- Set aiming to true when the right mouse button is pressed

                    -- Only create a new connection if it's not already running
                    if not aimingConnection then
                        aimingConnection = RunService.RenderStepped:Connect(function()
                            if _G.aim then
                                local closestPlayer = getClosest()
                                if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("Head") then
                                    local camera = game.Workspace.CurrentCamera
                                    -- Smoothly aim at the closest player's head
                                    local targetPosition = closestPlayer.Character.Head.Position
                                    local cameraPosition = camera.CFrame.Position
                                    local newCFrame = CFrame.new(cameraPosition, targetPosition)
                                    camera.CFrame = CFrame.new(cameraPosition, targetPosition)
                                end
                            end
                        end)
                    end
                end
            end)

            -- MouseButton2 released
            UIS.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton2 then
                    _G.aim = false  -- Set aiming to false when the right mouse button is released

                    -- Disconnect the aiming connection when the button is released
                    if aimingConnection then
                        aimingConnection:Disconnect()
                        aimingConnection = nil
                    end
                end
            end)
        ]]
    },

    {
        name = "Highlight ESP",
        script = [[
            local Players = game:GetService("Players")

            local function applyHighlight(player)
            local function onCharacterAdded(character)
            local highlight = Instance.new("Highlight", character)

            highlight.Archivable = true
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Enabled = true
            highlight.FillColor = Color3.fromRGB(255, 0, 4)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0 
            end

            if player.Character then
            onCharacterAdded(player.Character)
            end

            player.CharacterAdded:Connect(onCharacterAdded)
            end

            for _, player in pairs(Players:GetPlayers()) do
            applyHighlight(player)
            end

            Players.PlayerAdded:Connect(applyHighlight)
        ]]
    },

    {
        name = "Skid Chams",
        script = [[
            _G.FriendColor = Color3.fromRGB(0, 0, 255)
            _G.EnemyColor = Color3.fromRGB(255, 0, 0)
            _G.UseTeamColor = true


            local Holder = Instance.new("Folder", game.CoreGui)
            Holder.Name = "ESP"

            local Box = Instance.new("BoxHandleAdornment")
            Box.Name = "nilBox"
            Box.Size = Vector3.new(1, 2, 1)
            Box.Color3 = Color3.new(100 / 255, 100 / 255, 100 / 255)
            Box.Transparency = 0.7
            Box.ZIndex = 0
            Box.AlwaysOnTop = false
            Box.Visible = false

            local NameTag = Instance.new("BillboardGui")
            NameTag.Name = "nilNameTag"
            NameTag.Enabled = false
            NameTag.Size = UDim2.new(0, 200, 0, 50)
            NameTag.AlwaysOnTop = true
            NameTag.StudsOffset = Vector3.new(0, 1.8, 0)
            local Tag = Instance.new("TextLabel", NameTag)
            Tag.Name = "Tag"
            Tag.BackgroundTransparency = 1
            Tag.Position = UDim2.new(0, -50, 0, 0)
            Tag.Size = UDim2.new(0, 300, 0, 20)
            Tag.TextSize = 15
            Tag.TextColor3 = Color3.new(100 / 255, 100 / 255, 100 / 255)
            Tag.TextStrokeColor3 = Color3.new(0 / 255, 0 / 255, 0 / 255)
            Tag.TextStrokeTransparency = 0.4
            Tag.Text = "nil"
            Tag.Font = Enum.Font.SourceSansBold
            Tag.TextScaled = false

            local LoadCharacter = function(v)
                repeat wait() until v.Character ~= nil
                v.Character:WaitForChild("Humanoid")
                local vHolder = Holder:FindFirstChild(v.Name)
                vHolder:ClearAllChildren()
                local b = Box:Clone()
                b.Name = v.Name .. "Box"
                b.Adornee = v.Character
                b.Parent = vHolder
                local t = NameTag:Clone()
                t.Name = v.Name .. "NameTag"
                t.Enabled = true
                t.Parent = vHolder
                t.Adornee = v.Character:WaitForChild("Head", 5)
                if not t.Adornee then
                    return UnloadCharacter(v)
                end
                t.Tag.Text = v.Name
                b.Color3 = Color3.new(v.TeamColor.r, v.TeamColor.g, v.TeamColor.b)
                t.Tag.TextColor3 = Color3.new(v.TeamColor.r, v.TeamColor.g, v.TeamColor.b)
                local Update
                local UpdateNameTag = function()
                    if not pcall(function()
                        v.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                        local maxh = math.floor(v.Character.Humanoid.MaxHealth)
                        local h = math.floor(v.Character.Humanoid.Health)
                    end) then
                        Update:Disconnect()
                    end
                end
                UpdateNameTag()
                Update = v.Character.Humanoid.Changed:Connect(UpdateNameTag)
            end

            local UnloadCharacter = function(v)
                local vHolder = Holder:FindFirstChild(v.Name)
                if vHolder and (vHolder:FindFirstChild(v.Name .. "Box") ~= nil or vHolder:FindFirstChild(v.Name .. "NameTag") ~= nil) then
                    vHolder:ClearAllChildren()
                end
            end

            local LoadPlayer = function(v)
                local vHolder = Instance.new("Folder", Holder)
                vHolder.Name = v.Name
                v.CharacterAdded:Connect(function()
                    pcall(LoadCharacter, v)
                end)
                v.CharacterRemoving:Connect(function()
                    pcall(UnloadCharacter, v)
                end)
                v.Changed:Connect(function(prop)
                    if prop == "TeamColor" then
                        UnloadCharacter(v)
                        wait()
                        LoadCharacter(v)
                    end
                end)
                LoadCharacter(v)
            end

            local UnloadPlayer = function(v)
                UnloadCharacter(v)
                local vHolder = Holder:FindFirstChild(v.Name)
                if vHolder then
                    vHolder:Destroy()
                end
            end

            for i,v in pairs(game:GetService("Players"):GetPlayers()) do
                spawn(function() pcall(LoadPlayer, v) end)
            end

            game:GetService("Players").PlayerAdded:Connect(function(v)
                pcall(LoadPlayer, v)
            end)

            game:GetService("Players").PlayerRemoving:Connect(function(v)
                pcall(UnloadPlayer, v)
            end)

            game:GetService("Players").LocalPlayer.NameDisplayDistance = 0

            if _G.Reantheajfdfjdgs then
                return
            end

            _G.Reantheajfdfjdgs = ":suifayhgvsdghfsfkajewfrhk321rk213kjrgkhj432rj34f67df"

            local players = game:GetService("Players")
            local plr = players.LocalPlayer

            function esp(target, color)
                if target.Character then
                    if not target.Character:FindFirstChild("GetReal") then
                        local highlight = Instance.new("Highlight")
                        highlight.RobloxLocked = true
                        highlight.Name = "GetReal"
                        highlight.Adornee = target.Character
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.FillColor = color
                        highlight.Parent = target.Character
                    else
                        target.Character.GetReal.FillColor = color
                    end
                end
            end

            while task.wait() do
                for i, v in pairs(players:GetPlayers()) do
                    if v ~= plr then
                        esp(v, _G.UseTeamColor and v.TeamColor.Color or ((plr.TeamColor == v.TeamColor) and _G.FriendColor or _G.EnemyColor))
                    end
                end
            end
        ]]
    },

    {
        name = "Anti Lag",
        script = [[
            loadstring(game:HttpGet("https://raw.githubusercontent.com/MarsQQ/ScriptHubScripts/master/FPS%20Boost"))();
        ]]
    },

    {
        name = "Infinite Jump",
        script = [[
            InfiniteJumpEnabled = true
            game:GetService("UserInputService").JumpRequest:connect(function()
                if InfiniteJumpEnabled then
                    game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
                end
            end)
        ]]
    },

    {
        name = "UnInfinite Jump",
        script = [[
            InfiniteJumpEnabled = false
        ]]
    },

    {
        name = "Btools",
        script = [[
            hammer = Instance.new("HopperBin")
            hammer.Name = "Hammer"
            hammer.BinType = 4
            hammer.Parent = backpack

            cloneTool = Instance.new("HopperBin")
            cloneTool.Name = "Clone"
            cloneTool.BinType = 3
            cloneTool.Parent = backpack

            grabTool = Instance.new("HopperBin")
            grabTool.Name = "Grab"
            grabTool.BinType = 2
            grabTool.Parent = backpack
        ]]
    },

    {
        name = "Chat Spammer",
        script = [[
            while true do
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Hi i'm a hacker", "All")
                wait(2)
            end
        ]]
    },

    {
        name = "Noclip",
        script = [[
            noclip()
            Noclip = true
            Clip = false
        ]]
    },

    {
        name = "Clip",
        script = [[
            clip()
            Clip = true
            Noclip = false
        ]]
    },

    {
        name = "Reset Character",
        script = [[
            game.Players.LocalPlayer.Character:BreakJoints()
        ]]
    },

    {
        name = "Anti-AFK",
        script = [[
            ANTIAFK = game:GetService("Players").LocalPlayer.Idled:connect(function()
                game:FindService("VirtualUser"):Button2Down(Vector2.new(0,0),game:GetService("Workspace").CurrentCamera.CFrame)
                task.wait(1)
                game:FindService("VirtualUser"):Button2Up(Vector2.new(0,0),game:GetService("Workspace").CurrentCamera.CFrame)
            end)
            ShowNotification("Syntix Hub", "Successfully Enabled Anti-AFK", 3)
        ]]
    },

    {
        name = "UnAnti-AFK",
        script = [[
            ANTIAFK:Disconnect()
            wait();
            ShowNotification("Syntix Hub", "Successfully Disabled Anti-AFK", 3)
        ]]
    },


    {
        name = "Max Camera Zoom",
        script = [[
            game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = 9999
        ]]
    },

    {
        name = "Xray (Broken)",
        script = [[
            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0.5
                end
            end
        ]]
    },

    {
        name = "UnXray",
        script = [[
            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0
                end
            end
        ]]
    },

    {
        name = "Flight",
        script = [[
            local UIS = game:GetService("UserInputService")
            local RunService = game:GetService("RunService")
            local Player = game.Players.LocalPlayer
            local Character = Player.Character or Player.CharacterAdded:Wait()
            local HRP = Character:WaitForChild("HumanoidRootPart")

            local speed = 50
            local vel = Instance.new("BodyVelocity")
            vel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            vel.Velocity = Vector3.zero
            vel.Parent = HRP

            local gyro = Instance.new("BodyGyro")
            gyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            gyro.P = 10000
            gyro.CFrame = HRP.CFrame
            gyro.Parent = HRP

            RunService.RenderStepped:Connect(function()
                local cam = workspace.CurrentCamera
                local dir = Vector3.zero

                if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0, 1, 0) end
                if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0, 1, 0) end

                vel.Velocity = dir.Magnitude > 0 and dir.Unit * speed or Vector3.zero
                gyro.CFrame = cam.CFrame
            end)
        ]]
    },

        {
        name = "UnFlight",
        script = [[
            local Player = game.Players.LocalPlayer
            local Character = Player.Character or Player.CharacterAdded:Wait()
            local HRP = Character:FindFirstChild("HumanoidRootPart")

            if HRP then
                for _, obj in ipairs(HRP:GetChildren()) do
                    if obj:IsA("BodyVelocity") or obj:IsA("BodyGyro") then
                        obj:Destroy()
                    end
                end
            end
        ]]
    },


    {
        name = "TP To Random",
        script = [[
            local players = game.Players:GetPlayers()
            local localPlayer = game.Players.LocalPlayer

            for i = #players, 1, -1 do
                if players[i] == localPlayer then
                    table.remove(players, i)
                end
            end

            if #players > 0 then
                local randomPlayer = players[math.random(1, #players)]
                if randomPlayer.Character and randomPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local targetPos = randomPlayer.Character.HumanoidRootPart.Position
                    if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        localPlayer.Character:MoveTo(targetPos + Vector3.new(2, 0, 2))
                    end
                end
            else
               ShowNotification("Syntix Hub", "No Others Player To Teleport", 3)
            end
        ]]
    },

    {
        name = "TP To All",
        script = [[
            local players = game.Players:GetPlayers()
            local localPlayer = game.Players.LocalPlayer

            for _, player in ipairs(players) do
                if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local targetPos = player.Character.HumanoidRootPart.Position
                    if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        localPlayer.Character:MoveTo(targetPos + Vector3.new(2, 0, 2))
                        wait(1)
                    end
                end
            end
        ]]
    },

    {
        name = "Brook Fly GUI",
        script = [[
            loadstring(game:HttpGet("https://pastebin.com/raw/KZhWuaEz"))()
        ]]
    },

    {
        name = "Fly GUI V3",
        script = [[
            loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\40\39\104\116\116\112\115\58\47\47\103\105\115\116\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\109\101\111\122\111\110\101\89\84\47\98\102\48\51\55\100\102\102\57\102\48\97\55\48\48\49\55\51\48\52\100\100\100\54\55\102\100\99\100\51\55\48\47\114\97\119\47\101\49\52\101\55\52\102\52\50\53\98\48\54\48\100\102\53\50\51\51\52\51\99\102\51\48\98\55\56\55\48\55\52\101\98\51\99\53\100\50\47\97\114\99\101\117\115\37\50\53\50\48\120\37\50\53\50\48\102\108\121\37\50\53\50\48\50\37\50\53\50\48\111\98\102\108\117\99\97\116\111\114\39\41\44\116\114\117\101\41\41\40\41\10\10")()
        ]]
    },

    {
        name = "Orca Hub",
        script = [[
            loadstring(
                game:HttpGetAsync("https://raw.githubusercontent.com/richie0866/orca/master/public/latest.lua")
            )()
        ]]
    },

    {
        name = "Rivals Aimbot",
        script = [[
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scripter66/EmberHub/refs/heads/main/Rivals.lua"))()      
        ]]
    },

    {
        name = "BB Auto Parry",
        script = [[
          loadstring(game:HttpGet('https://raw.githubusercontent.com/SpiderScriptRB/Blade-ball-OP-/refs/heads/main/Protected_3291800768430903.txt'))()  
        ]]
    },

    {
        name = "Speed Hub X",
        script = [[
            loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
        ]]
    },

    {
        name = "DH Triggerbot",
        script = [[
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ggslashtraced/Triggerbot/refs/heads/main/Triggerbotmain.lua"))()
        ]]
    },

    {
        name = "Save Place",
        script = [[
            saveinstance()
        ]]
    },

    {
        name = "Save Place 2",
        script = [[
            getgenv().saveinstance = nil
            loadstring(game:HttpGet("https://github.com/MuhXd/Roblox-mobile-script/blob/main/Arecus-X-Neo/Saveinstance.lua?raw=true"))();
        ]]
    },

    {
        name = "Rivals SA",
        script = [[
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Yizziii/RSA-Roblox/refs/heads/main/RSA.lua"))()
        ]]
    },

    {
        name = "Soluna Hub MM2",
        script = [[
            loadstring(game:HttpGet("https://soluna-script.vercel.app/murder-mystery-2.lua",true))()
        ]]
    },

    {
        name = "Tora Dead Rails",
        script = [[
            loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/DeadRails", true))()
        ]]
    },

    {
        name = "FF Auto Play",
        script = [[
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Nadir3709/ScriptHub/main/Loader"))()
        ]]
    },

    {
        name = "Script Blox GUI",
        script = [[
            loadstring(game:HttpGet("https://pastefy.app/cIrUcSTO/raw"))()
        ]]
    }
}
-- Scripts Grid Layout
local row = 0
local col = 0

for i, scriptInfo in ipairs(scripts) do
    local position = UDim2.new(col * 0.33, 5, 0, row * 45 + 70)
    createScriptButton(scriptInfo.name, scriptInfo.script, ScrollFrame, position)
    col = col + 1
    if col >= 3 then
        col = 0
        row = row + 1
    end
end
-- Welcome Fade (disabled)
--[[
    task.delay(10, function()
    for i = 0, 1, 0.1 do
        WelcomeLabel.TextTransparency = i
        task.wait(0.05)
    end
    WelcomeLabel.Visible = false
end)
]]
-- Toggle Logic
ToggleButton.MouseButton1Click:Connect(function()
    ClickSound:Play()
    if MainFrame.Visible then
        for i = 0, 1, 0.1 do
            MainFrame.BackgroundTransparency = i
            task.wait(0.02)
        end
        MainFrame.Visible = false
    else
        MainFrame.Visible = true
        MainFrame.BackgroundTransparency = 1
        for i = 1, 0, -0.1 do
            MainFrame.BackgroundTransparency = i
            task.wait(0.02)
        end
        MainFrame.BackgroundTransparency = 0.2
    end
end)
--Smooth Dragging OMG
local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            local newPos = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )

            TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = newPos
            }):Play()
        end
    end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

--Window Key
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.K then
        if MainFrame.Visible then
            -- Fade out
            for i = 0, 1, 0.1 do
                MainFrame.BackgroundTransparency = i
                task.wait(0.02)
            end
            MainFrame.Visible = false
            ShowNotification("Syntix Hub", "UI Hidden", 2)
        else
            -- Fade in
            MainFrame.Visible = true
            MainFrame.BackgroundTransparency = 1
            for i = 1, 0, -0.1 do
                MainFrame.BackgroundTransparency = i
                task.wait(0.02)
            end
            MainFrame.BackgroundTransparency = 0.2
            ShowNotification("Syntix Hub", "UI Visible", 2)
        end
    end
end)

ShowNotification("Syntix Hub", "Click K to Toggle UI", 3)

for i, scriptInfo in ipairs(scripts) do
    local position = UDim2.new(col * 0.33, 5, 0, row * 45 + 70)
    createScriptButton(scriptInfo.name, scriptInfo.script, ScrollFrame, position)

    col = col + 1
    if col >= 3 then
        col = 0
        row = row + 1
    end
end

task.wait(0.1)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, row * 45 + 140)

makeDraggable(MainFrame)
makeDraggable(ToggleButton)
