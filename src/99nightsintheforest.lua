local ReGui = loadstring(game:HttpGet('https://raw.githubusercontent.com/depthso/Dear-ReGui/refs/heads/main/ReGui.lua'))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")

--Brings Items By Names
local function bringItemsByName(name)
    for _, item in ipairs(workspace.Items:GetChildren()) do
        if item.Name:lower():find(name:lower()) then
            local part = item:FindFirstChildWhichIsA("BasePart") or item:IsA("BasePart") and item
            if part then
                part.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            end
        end
    end
end
--Auto Cook Meat
local function bringMeat()
    for _, item in pairs(workspace.Items:GetChildren()) do
        if item:IsA("Model") or item:IsA("BasePart") then
            local name = item.Name:lower()
            if name:find("meat") then
                local part = item:FindFirstChildWhichIsA("BasePart") or item
                if part then
                    part.CFrame = CFrame.new(campfirePos + Vector3.new(math.random(-2,2), 0.5, math.random(-2,2)))
                end
            end
        end
    end
end

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


local Window = ReGui:Window({
	Title = "CherryWare",
    Theme = "Cherry",
	Size = UDim2.fromOffset(300, 200)
})

Window:Button({
	Text = "Teleport to Camp",
	Callback = function(self)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(
                13.287363052368164, 3.999999761581421, 0.36212217807769775,
                0.6022269129753113, -2.275036159460342e-08, 0.7983249425888062,
                6.430457055728311e-09, 1, 2.364672191390582e-08,
                -0.7983249425888062, -9.1070981866892e-09, 0.6022269129753113
            )
        end
	end
})

Window:Button({
	Text = "Teleport to Trader",
	Callback = function(self)
        local pos = Vector3.new(-37.08, 3.98, -16.33)
        local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        hrp.CFrame = CFrame.new(pos)
	end
})
--Brings

Window:Button({
	Text = "Bring Everything",
	Callback = function(self)
		for _, item in ipairs(workspace.Items:GetChildren()) do
            local part = item:FindFirstChildWhichIsA("BasePart") or item:IsA("BasePart") and item
            if part then
                part.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            end
        end
	end
})

Window:Button({
	Text = "Auto Cook Meat",
	Callback = bringMeat
})

Window:Button({
	Text = "Bring Logs",
	Callback = function(self)
        local lp = game:GetService("Players").LocalPlayer
        local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        local count = 0
        for _, item in pairs(workspace.Items:GetChildren()) do
            if item.Name:lower():find("log") and item:IsA("Model") then
                local main = item:FindFirstChildWhichIsA("BasePart")
                if main then
                main.CFrame = root.CFrame * CFrame.new(math.random(-5,5), 0, math.random(-5,5))
                count += 1
                end
            end
        end
    end
})

Window:Button({
	Text = "Bring Coal",
	Callback = function(self)
        local lp = game:GetService("Players").LocalPlayer
        local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        local count = 0
        for _, item in pairs(workspace.Items:GetChildren()) do
            if item.Name:lower():find("coal") and item:IsA("Model") then
                local main = item:FindFirstChildWhichIsA("BasePart")
                if main then
                main.CFrame = root.CFrame * CFrame.new(math.random(-5,5), 0, math.random(-5,5))
                count += 1
                end
            end
        end
	end
})

Window:Button({
	Text = "Bring Meat (Raw + Cooked)",
	Callback = function(self)
        local lp = game:GetService("Players").LocalPlayer
        local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        local count = 0
        for _, item in pairs(workspace.Items:GetChildren()) do
            local name = item.Name:lower()
            if (name:find("meat") or name:find("cooked")) and item:IsA("Model") then
                local main = item:FindFirstChildWhichIsA("BasePart")
                if main then
                main.CFrame = root.CFrame * CFrame.new(math.random(-5,5), 0, math.random(-5,5))
                count += 1
                end
            end
        end
    end
})

Window:Button({
	Text = "Bring Flashlight",
	Callback = function(self)
        bringItemsByName("Flashlight")      
    end
})

Window:Button({
	Text = "Bring Nails",
	Callback = function(self)
        bringItemsByName("Nails")      
    end
})

Window:Button({
	Text = "Bring Fan",
	Callback = function(self)
        bringItemsByName("Fan")      
    end
})

Window:Button({
	Text = "Bring Ammo",
	Callback = function(self)
        local keywords = {"ammo"}
        local root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end

        for _, item in ipairs(workspace.Items:GetChildren()) do
            for _, word in ipairs(keywords) do
                if item.Name:lower():find(word) then
                    local part = item:FindFirstChildWhichIsA("BasePart") or item:IsA("BasePart") and item
                    if part then
                        part.CFrame = root.CFrame + Vector3.new(math.random(-5,5), 0, math.random(-5,5))
                    end
                end
            end
        end
    end
})

Window:Button({
	Text = "Bring Sheet Metal",
	Callback = function(self)
        local keyword = "sheet metal"
        local root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end

        for _, item in ipairs(workspace.Items:GetChildren()) do
            if item.Name:lower():find(keyword) then
                local part = item:FindFirstChildWhichIsA("BasePart") or item:IsA("BasePart") and item
                if part then
                    part.CFrame = root.CFrame + Vector3.new(math.random(-5,5), 0, math.random(-5,5))
                end
            end
        end   
    end
})

Window:Button({
	Text = "Bring Fuel Canister",
	Callback = function(self)
        local keyword = "fuel canister"
        local root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end

        for _, item in ipairs(workspace.Items:GetChildren()) do
            if item.Name:lower():find(keyword) then
                local part = item:FindFirstChildWhichIsA("BasePart") or (item:IsA("BasePart") and item)
                if part then
                    part.CFrame = root.CFrame + Vector3.new(math.random(-5,5), 0, math.random(-5,5))
                end
            end
        end
    end
})

Window:Button({
	Text = "Bring Bandage",
	Callback = function(self)
        local lp = game.Players.LocalPlayer
        local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end

        for _, item in ipairs(workspace.Items:GetChildren()) do
            if item:IsA("Model") and item.Name:lower():find("bandage") then
                local part = item:FindFirstChildWhichIsA("BasePart")
                if part then
                    part.CFrame = root.CFrame + Vector3.new(0, 2, 0)
                end
            end
        end
    end
})

Window:Button({
	Text = "Bring Revolver",
	Callback = function(self)
        for _, item in ipairs(workspace.Items:GetChildren()) do
            if item:IsA("Model") and item.Name:lower():find("revolver") then
                local part = item:FindFirstChildWhichIsA("BasePart")
                if part then
                    part.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 2, 0)
                end
            end
        end
    end
})

Window:Button({
	Text = "Bring Lost Child",
	Callback = function(self)
        for _, model in ipairs(workspace:GetDescendants()) do
            if model:IsA("Model") and model.Name:lower():find("lost") and model:FindFirstChild("HumanoidRootPart") then
                model:PivotTo(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 2, 0))
            end
        end
    end
})
