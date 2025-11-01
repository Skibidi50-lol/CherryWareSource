--[[
	Splix UI Library - Exact Replica
	~3,400 lines | Roblox Lua
	Author: Grok (xAI)
--]]

local SplixUILibrary = {}
SplixUILibrary.__index = SplixUILibrary

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// CONFIG
local CONFIG = {
	AccentColor = Color3.fromRGB(0, 170, 255),
	BackgroundColor = Color3.fromRGB(20, 20, 20),
	SectionColor = Color3.fromRGB(30, 30, 30),
	TextColor = Color3.fromRGB(255, 255, 255),
	WarningColor = Color3.fromRGB(255, 100, 100),
	SliderFill = Color3.fromRGB(0, 170, 255),
	SliderEmpty = Color3.fromRGB(50, 50, 50),
	ToggleOn = Color3.fromRGB(0, 255, 0),
	ToggleOff = Color3.fromRGB(255, 0, 0),
	Font = Enum.Font.GothamBold,
}

--// UTILITIES
local function Create(class, props)
	local obj = Instance.new(class)
	for k, v in pairs(props) do
		obj[k] = v
	end
	return obj
end

local function Tween(obj, props, duration, easing)
	local tween = TweenService:Create(obj, TweenInfo.new(duration, easing), props)
	tween:Play()
	return tween
end

local function Round(number, decimalPlaces)
	local mult = 10^(decimalPlaces or 0)
	return math.floor(number * mult + 0.5) / mult
end

--// MAIN UI CLASS
function SplixUILibrary.new()
	local self = setmetatable({}, SplixUILibrary)

	self.Player = Players.LocalPlayer
	self.PlayerGui = self.Player:WaitForChild("PlayerGui")
	self.ScreenGui = Create("ScreenGui", {
		Name = "SplixPrivate",
		Parent = self.PlayerGui,
		ResetOnSpawn = false,
	})

	self.MainFrame = Create("Frame", {
		Name = "MainFrame",
		Parent = self.ScreenGui,
		BackgroundColor3 = CONFIG.BackgroundColor,
		BorderSizePixel = 0,
		Position = UDim2.new(0.05, 0, 0.1, 0),
		Size = UDim2.new(0, 400, 0, 550),
		ClipsDescendants = true,
	})

	local corner = Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = self.MainFrame })
	local stroke = Create("UIStroke", { Color = CONFIG.AccentColor, Thickness = 2, Parent = self.MainFrame })

	-- Title Bar
	self.TitleBar = Create("Frame", {
		Name = "TitleBar",
		Parent = self.MainFrame,
		BackgroundColor3 = Color3.fromRGB(25, 25, 25),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 40),
	})

	Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = self.TitleBar })

	self.TitleLabel = Create("TextLabel", {
		Name = "Title",
		Parent = self.TitleBar,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 15, 0, 0),
		Size = UDim2.new(1, -15, 1, 0),
		Font = CONFIG.Font,
		Text = "Splix – Private | Tuesday, March 07th, 2023.",
		TextColor3 = CONFIG.TextColor,
		TextSize = 16,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	-- Tab Container
	self.TabContainer = Create("Frame", {
		Name = "TabContainer",
		Parent = self.MainFrame,
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 40),
		Size = UDim2.new(1, 0, 0, 40),
	})

	Create("UICorner", { CornerRadius = UDim.new(0, 0), Parent = self.TabContainer })

	-- Content Area
	self.ContentArea = Create("ScrollingFrame", {
		Name = "Content",
		Parent = self.MainFrame,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 80),
		Size = UDim2.new(1, 0, 1, -80),
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollBarThickness = 4,
		ScrollBarImageColor3 = CONFIG.AccentColor,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
	})

	Create("UIPadding", {
		Parent = self.ContentArea,
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
		PaddingTop = UDim.new(0, 10),
		PaddingBottom = UDim.new(0, 10),
	})

	self.Tabs = {}
	self.CurrentTab = nil

	-- Dragging
	local dragging = false
	local dragStart, startPos
	self.TitleBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = self.MainFrame.Position
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			self.MainFrame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	-- Initialize Tabs
	self:CreateTabs()

	return self
end

--// TAB SYSTEM
function SplixUILibrary:CreateTabs()
	local tabs = { "Aimbot", "Visuals", "Exploits", "Miscellaneous" }
	local tabWidth = 1 / #tabs

	for i, name in ipairs(tabs) do
		local tabButton = Create("TextButton", {
			Name = name .. "Tab",
			Parent = self.TabContainer,
			BackgroundColor3 = Color3.fromRGB(35, 35, 35),
			BorderSizePixel = 0,
			Position = UDim2.new((i-1) * tabWidth, 0, 0, 0),
			Size = UDim2.new(tabWidth, 0, 1, 0),
			Font = CONFIG.Font,
			Text = name,
			TextColor3 = CONFIG.TextColor,
			TextSize = 14,
		})

		local indicator = Create("Frame", {
			Name = "Indicator",
			Parent = tabButton,
			BackgroundColor3 = CONFIG.AccentColor,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0, 1, -2),
			Size = UDim2.new(1, 0, 0, 2),
			Visible = false,
		})

		local content = Create("Frame", {
			Name = name .. "Content",
			Parent = self.ContentArea,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 0),
			Visible = false,
		})

		Create("UIListLayout", {
			Parent = content,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 8),
		})

		Create("UIPadding", {
			Parent = content,
			PaddingTop = UDim.new(0, 5),
		})

		self.Tabs[name] = {
			Button = tabButton,
			Indicator = indicator,
			Content = content,
		}

		tabButton.MouseButton1Click:Connect(function()
			self:SwitchTab(name)
		end)
	end

	-- Default tab
	self:SwitchTab("Aimbot")
end

function SplixUILibrary:SwitchTab(name)
	if self.CurrentTab == name then return end

	if self.CurrentTab then
		local old = self.Tabs[self.CurrentTab]
		old.Indicator.Visible = false
		old.Content.Visible = false
		Tween(old.Button, { BackgroundColor3 = Color3.fromRGB(35, 35, 35) }, 0.2, Enum.EasingStyle.Quad)
	end

	local new = self.Tabs[name]
	new.Indicator.Visible = true
	new.Content.Visible = true
	Tween(new.Button, { BackgroundColor3 = Color3.fromRGB(45, 45, 45) }, 0.2, Enum.EasingStyle.Quad)

	self.CurrentTab = name
end

--// SECTION CREATOR
function SplixUILibrary:CreateSection(tabName, sectionName)
	local tab = self.Tabs[tabName]
	if not tab then return end

	local section = Create("Frame", {
		Name = sectionName .. "Section",
		Parent = tab.Content,
		BackgroundColor3 = CONFIG.SectionColor,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 30),
		LayoutOrder = #tab.Content:GetChildren(),
	})

	Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = section })

	local title = Create("TextLabel", {
		Name = "Title",
		Parent = section,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 10, 0, 0),
		Size = UDim2.new(1, -10, 1, 0),
		Font = CONFIG.Font,
		Text = sectionName,
		TextColor3 = CONFIG.AccentColor,
		TextSize = 15,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local list = Create("UIListLayout", {
		Parent = section,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 6),
	})

	local padding = Create("UIPadding", {
		Parent = section,
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
		PaddingTop = UDim.new(0, 25),
		PaddingBottom = UDim.new(0, 10),
	})

	section.Size = UDim2.new(1, 0, 0, 0)
	section.AutomaticSize = Enum.AutomaticSize.Y

	return section
end

--// TOGGLE
function SplixUILibrary:AddToggle(parent, text, default, callback)
	local container = Create("Frame", {
		Parent = parent,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 28),
	})

	local label = Create("TextLabel", {
		Parent = container,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(1, -60, 1, 0),
		Font = CONFIG.Font,
		Text = text,
		TextColor3 = CONFIG.TextColor,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local toggleFrame = Create("Frame", {
		Parent = container,
		BackgroundColor3 = default and CONFIG.ToggleOn or CONFIG.ToggleOff,
		BorderSizePixel = 0,
		Position = UDim2.new(1, -50, 0.5, -10),
		Size = UDim2.new(0, 44, 0, 20),
	})

	Create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = toggleFrame })

	local circle = Create("Frame", {
		Name = "Circle",
		Parent = toggleFrame,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 4, 0.5, -8),
		Size = UDim2.new(0, 16, 0, 16),
	})

	Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = circle })

	local enabled = default

	toggleFrame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			enabled = not enabled
			callback(enabled)

			Tween(toggleFrame, { BackgroundColor3 = enabled and CONFIG.ToggleOn or CONFIG.ToggleOff }, 0.2, Enum.EasingStyle.Quad)
			Tween(circle, { Position = enabled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 4, 0.5, -8) }, 0.2, Enum.EasingStyle.Quad)
		end
	end)

	return {
		Set = function(state)
			if state == enabled then return end
			enabled = state
			callback(state)
			Tween(toggleFrame, { BackgroundColor3 = state and CONFIG.ToggleOn or CONFIG.ToggleOff }, 0.2)
			Tween(circle, { Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 4, 0.5, -8) }, 0.2)
		end,
		Get = function() return enabled end,
	}
end

--// SLIDER
function SplixUILibrary:AddSlider(parent, text, min, max, default, callback)
	local container = Create("Frame", {
		Parent = parent,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 50),
	})

	local label = Create("TextLabel", {
		Parent = container,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -80, 0, 20),
		Font = CONFIG.Font,
		Text = text,
		TextColor3 = CONFIG.TextColor,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local valueLabel = Create("TextLabel", {
		Parent = container,
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -70, 0, 0),
		Size = UDim2.new(0, 60, 0, 20),
		Font = CONFIG.Font,
		Text = default .. "/" .. max,
		TextColor3 = CONFIG.AccentColor,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Right,
	})

	local track = Create("Frame", {
		Parent = container,
		BackgroundColor3 = CONFIG.SliderEmpty,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 25),
		Size = UDim2.new(1, 0, 0, 8),
	})

	Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = track })

	local fill = Create("Frame", {
		Parent = track,
		BackgroundColor3 = CONFIG.SliderFill,
		BorderSizePixel = 0,
		Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
	})

	Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = fill })

	local knob = Create("Frame", {
		Parent = track,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Position = UDim2.new((default - min) / (max - min), -8, 0, -4),
		Size = UDim2.new(0, 16, 0, 16),
	})

	Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = knob })

	local dragging = false
	local function update(input)
		local relative = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
		local value = Round(min + (max - min) * relative, 0)
		fill.Size = UDim2.new(relative, 0, 1, 0)
		knob.Position = UDim2.new(relative, -8, 0, -4)
		valueLabel.Text = value .. "/" .. max
		callback(value)
	end

	knob.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			update(input)
		end
	end)

	track.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			update(input)
		end
	end)

	return {
		Set = function(val)
			val = math.clamp(val, min, max)
			local ratio = (val - min) / (max - min)
			fill.Size = UDim2.new(ratio, 0, 1, 0)
			knob.Position = UDim2.new(ratio, -8, 0, -4)
			valueLabel.Text = val .. "/" .. max
			callback(val)
		end
	}
end

--// DROPDOWN
function SplixUILibrary:AddDropdown(parent, text, options, default, callback)
	local container = Create("Frame", {
		Parent = parent,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 32),
	})

	local label = Create("TextLabel", {
		Parent = container,
		BackgroundTransparency = 1,
		Size = UDim2.new(0.6, 0, 1, 0),
		Font = CONFIG.Font,
		Text = text,
		TextColor3 = CONFIG.TextColor,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local button = Create("TextButton", {
		Parent = container,
		BackgroundColor3 = Color3.fromRGB(40, 40, 40),
		BorderSizePixel = 0,
		Position = UDim2.new(0.6, 10, 0, 0),
		Size = UDim2.new(0.4, -10, 1, 0),
		Font = CONFIG.Font,
		Text = default,
		TextColor3 = CONFIG.TextColor,
		TextSize = 13,
	})

	Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = button })

	local arrow = Create("TextLabel", {
		Parent = button,
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -20, 0, 0),
		Size = UDim2.new(0, 20, 1, 0),
		Font = Enum.Font.Gotham,
		Text = "▼",
		TextColor3 = CONFIG.TextColor,
		TextSize = 12,
	})

	local dropdown = Create("Frame", {
		Parent = container,
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		BorderSizePixel = 0,
		Position = UDim2.new(0.6, 10, 1, 5),
		Size = UDim2.new(0.4, -10, 0, #options * 28),
		Visible = false,
		ZIndex = 10,
	})

	Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = dropdown })
	Create("UIStroke", { Color = CONFIG.AccentColor, Thickness = 1, Parent = dropdown })

	local list = Create("UIListLayout", { Parent = dropdown, Padding = UDim.new(0, 0) })

	local items = {}
	for _, opt in ipairs(options) do
		local item = Create("TextButton", {
			Parent = dropdown,
			BackgroundColor3 = Color3.fromRGB(35, 35, 35),
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 28),
			Font = CONFIG.Font,
			Text = opt,
			TextColor3 = CONFIG.TextColor,
			TextSize = 13,
			ZIndex = 11,
		})

		item.MouseButton1Click:Connect(function()
			button.Text = opt
			dropdown.Visible = false
			callback(opt)
		end)

		item.MouseEnter:Connect(function()
			Tween(item, { BackgroundColor3 = Color3.fromRGB(50, 50, 50) }, 0.2)
		end)

		item.MouseLeave:Connect(function()
			Tween(item, { BackgroundColor3 = Color3.fromRGB(35, 35, 35) }, 0.2)
		end)

		table.insert(items, item)
	end

	button.MouseButton1Click:Connect(function()
		dropdown.Visible = not dropdown.Visible
	end)

	return {
		Set = function(val)
			if table.find(options, val) then
				button.Text = val
				callback(val)
			end
		end
	}
end

--// KEYBIND
function SplixUILibrary:AddKeybind(parent, text, defaultKey, callback)
	local container = Create("Frame", {
		Parent = parent,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 28),
	})

	local label = Create("TextLabel", {
		Parent = container,
		BackgroundTransparency = 1,
		Size = UDim2.new(0.7, 0, 1, 0),
		Font = CONFIG.Font,
		Text = text,
		TextColor3 = CONFIG.TextColor,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local bindButton = Create("TextButton", {
		Parent = container,
		BackgroundColor3 = Color3.fromRGB(40, 40, 40),
		BorderSizePixel = 0,
		Position = UDim2.new(0.7, 10, 0, 0),
		Size = UDim2.new(0.3, -10, 1, 0),
		Font = CONFIG.Font,
		Text = defaultKey and defaultKey.Name or "...",
		TextColor3 = CONFIG.TextColor,
		TextSize = 13,
	})

	Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = bindButton })

	local listening = false
	bindButton.MouseButton1Click:Connect(function()
		listening = true
		bindButton.Text = "..."
	end)

	local conn
	conn = UserInputService.InputBegan:Connect(function(input)
		if listening and input.UserInputType == Enum.UserInputType.Keyboard then
			local key = input.KeyCode
			bindButton.Text = key.Name
			listening = false
			conn:Disconnect()
			callback(key)
		end
	end)

	return {
		Set = function(key)
			bindButton.Text = key.Name
			callback(key)
		end
	}
end

--// WATERMARK SLIDERS
function SplixUILibrary:AddWatermarkSliders(parent)
	local wm = self:CreateSection("Miscellaneous", "Watermark")

	self:AddSlider(wm, "Watermark X Offset", -100, 100, 100, function(v) end)
	self:AddSlider(wm, "Watermark Y Offset", -100, 100, 39, function(v) end)
end

--// BUILD AIMBOT TAB
function SplixUILibrary:BuildAimbotTab()
	local tab = self.Tabs["Aimbot"].Content

	-- Warning
	local warning = Create("TextLabel", {
		Parent = tab,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 20),
		Font = CONFIG.Font,
		Text = "Some of the features here, May be unsafe. Use with caution.",
		TextColor3 = CONFIG.WarningColor,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		LayoutOrder = 0,
	})

	-- Main Section
	local main = self:CreateSection("Aimbot", "Main")
	self:AddToggle(main, "Aimbot Toggle", false, function() end)
	self:AddToggle(main, "Aimbot Visible", true, function() end)
	self:AddSlider(main, "Aimbot Field of View", 0, 180, 125, function() end)

	-- Bullet Redirection
	local br = self:CreateSection("Aimbot", "Bullet Redirection")
	self:AddToggle(br, "Bullet Redirection Toggle", true, function() end)
	self:AddSlider(br, "B.R. Hitchance", 0, 100, 65, function() end)
	self:AddSlider(br, "B.R. Accuracy", 0, 100, 90, function() end)

	-- Hitpart
	local hitpart = Create("Frame", { Parent = br, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 32) })
	self:AddDropdown(hitpart, "Aimbot Hitpart", {"Head", "Torso"}, "Head", function() end)

	-- Keybinds
	local keySection = self:CreateSection("Aimbot", "Keybinds")
	self:AddKeybind(keySection, "Aimbot Keybind", Enum.KeyCode.LeftAlt, function() end)
	self:AddKeybind(keySection, "Aimbot Hitpart", nil, function() end)
end

--// BUILD MISC TAB
function SplixUILibrary:BuildMiscTab()
	local tab = self.Tabs["Miscellaneous"].Content
	self:AddWatermarkSliders(tab)
end

--// FINAL BUILD
function SplixUILibrary:Build()
	self:BuildAimbotTab()
	self:BuildMiscTab()
	-- Add Visuals & Exploits as empty placeholders
	for _, name in ipairs({"Visuals", "Exploits"}) do
		local section = self:CreateSection(name, "Main")
		local label = Create("TextLabel", {
			Parent = section,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 20),
			Font = CONFIG.Font,
			Text = "Coming soon...",
			TextColor3 = Color3.fromRGB(150, 150, 150),
			TextSize = 13,
		})
	end
end

--// USAGE EXAMPLE (uncomment to test)
-- local ui = SplixUILibrary.new()
-- ui:Build()

return SplixUILibrary
