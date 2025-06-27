local ReGui = loadstring(game:HttpGet('https://raw.githubusercontent.com/depthso/Dear-ReGui/refs/heads/main/ReGui.lua'))()

local dhlock = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/DH-Lua-Lock/refs/heads/main/Main.lua"))()
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/linemaster2/esp-library/main/library.lua"))();

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

--// Tabs
local Window = ReGui:Window({
    Title = "CherryWare | Universal Beta 1",
    Theme = "Cherry",
    NoClose = false,
    Size = UDim2.new(0, 600, 0, 400),
}):Center()

local ModalWindow = Window:PopupModal({
    Title = "CherryWare",
    AutoSize = "Y"
})

ModalWindow:Label({
    Text = [[ Thank you for using CherryWare 😁]],
    TextWrapped = true
})
ModalWindow:Separator()

ModalWindow:Button({
    Text = "Okay",
    Callback = function()
        ModalWindow:ClosePopup()
    end,
})

local Group = Window:List({
    UiPadding = 2,
    HorizontalFlex = Enum.UIFlexAlignment.Fill,
})

local TabsBar = Group:List({
    Border = true,
    UiPadding = 5,
    BorderColor = Window:GetThemeKey("Border"),
    BorderThickness = 1,
    HorizontalFlex = Enum.UIFlexAlignment.Fill,
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    AutomaticSize = Enum.AutomaticSize.None,
    FlexMode = Enum.UIFlexMode.None,
    Size = UDim2.new(0, 40, 1, 0),
    CornerRadius = UDim.new(0, 5)
})
local TabSelector = Group:TabSelector({
    NoTabsBar = true,
    Size = UDim2.fromScale(0.5, 1)
})

local function CreateTab(Name: string, Icon)
    local Tab = TabSelector:CreateTab({
        Name = Name
    })

    local List = Tab:List({
        HorizontalFlex = Enum.UIFlexAlignment.Fill,
        UiPadding = 1,
        Spacing = 10
    })

    local Button = TabsBar:Image({
        Image = Icon,
        Ratio = 1,
        RatioAxis = Enum.DominantAxis.Width,
        Size = UDim2.fromScale(1, 1),
        Callback = function(self)
            TabSelector:SetActiveTab(Tab)
        end,
    })

    ReGui:SetItemTooltip(Button, function(Canvas)
        Canvas:Label({
            Text = Name
        })
    end)

    return List
end

local function CreateRegion(Parent, Title)
    local Region = Parent:Region({
        Border = true,
        BorderColor = Window:GetThemeKey("Border"),
        BorderThickness = 1,
        CornerRadius = UDim.new(0, 5)
    })

    Region:Label({
        Text = Title
    })

    return Region
end

local General = CreateTab("General", 139650104834071)
local Settings = CreateTab("Settings", ReGui.Icons.Settings)

local AimbotSection = CreateRegion(General, "Aimbot") 
local ESPSection = CreateRegion(General, "ESP") 

--Aimbot
AimbotSection:Checkbox({
    Label = "Enabled",
    Value = false,
    Callback = function(self, Value)
       getgenv().dhlock.enabled = Value
    end
})

AimbotSection:Checkbox({
    Label = "FOV",
    Value = false,
    Callback = function(self, Value)
       getgenv().dhlock.showfov = Value
    end
})

AimbotSection:SliderInt({
    Label = "Aim Size (FOV)",
    Default = 50,
    Minimum = 50,
    Maximum = 500,
    Callback = function(self, Value)
        getgenv().dhlock.fov = Value
    end
})
--ESP
ESPSection:Checkbox({
    Label = "Enabled",
    Value = false,
    Callback = function(self, Value)
       ESP.Enabled = Value
    end
})

ESPSection:Checkbox({
    Label = "Boxes",
    Value = false,
    Callback = function(self, Value)
       ESP.ShowBox = Value
    end
})

ESPSection:Checkbox({
    Label = "Name",
    Value = false,
    Callback = function(self, Value)
       ESP.ShowName = Value
    end
})

ESPSection:Checkbox({
    Label = "Health",
    Value = false,
    Callback = function(self, Value)
       ESP.ShowHealth = Value
    end
})

ESPSection:Checkbox({
    Label = "Tracer",
    Value = false,
    Callback = function(self, Value)
       ESP.ShowTracer = Value
    end
})

ESPSection:Checkbox({
    Label = "Distance",
    Value = false,
    Callback = function(self, Value)
       ESP.ShowDistance = Value
    end
})

ESPSection:Separator({Text = "Chams Settings"})

ESPSection:Checkbox({
    Label = "Enabled",
    Value = false,
    Callback = function(self, Value)
       print("Soon")
    end
})
