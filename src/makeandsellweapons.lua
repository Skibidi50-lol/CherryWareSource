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

local inf = false

local Window = ReGui:Window({
    Title = "Make And Sell Weapons - Cherry Ware",
    Theme = "Cherry",
    Size = UDim2.fromOffset(300, 200)
}):Center()

Window:Button({
	Text = "Everything Infinite",
	Callback = function(self)

	end
})

Window:Checkbox({
	Value = false,
	Label = "Everything INF",
	Callback = function(self, Value: boolean)
        inf = Value
		while inf do
    local args = {
        9e99,
        9e99
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Event"):WaitForChild("SellWeapon"):FireServer(unpack(args))
    local args = {
        9e99
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Event"):WaitForChild("Train"):FireServer(unpack(args))
    local args = {
        "Stick",
        9e99
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Event"):WaitForChild("CraftWeapon"):FireServer(unpack(args))
    wait()
end
	end
})
