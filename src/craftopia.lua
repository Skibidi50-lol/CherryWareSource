local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local xrayOn = false
local chestESPOn = false
local diamondESPOn = false
local highlightFolder = Instance.new("Folder", game.CoreGui)
highlightFolder.Name = "ESP_Highlights"

local Window = Rayfield:CreateWindow({
   Name = "CherryWare - Craftopia",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "CherryWare",
   LoadingSubtitle = "by Syntix",
   ShowText = "Rayfield", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Amethyst", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "CherryHub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local XrayTab = Window:CreateTab("Xray", "box")
local Section = XrayTab:CreateSection("Xray Settings")

local function createHighlight(part, color)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = part
    highlight.FillColor = color
    highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
    highlight.Parent = highlightFolder
end

local function toggleXRay()
    xrayOn = not xrayOn

    highlightFolder:ClearAllChildren()

    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            local name = v.Name:lower()
            if name:find("diamond") then
                createHighlight(v, Color3.fromRGB(0, 255, 255)) -- Cyan
                v.Transparency = 0
            elseif name:find("iron") then
                createHighlight(v, Color3.fromRGB(128, 128, 128)) -- Gray
                v.Transparency = 0
            elseif name:find("coal") then
                createHighlight(v, Color3.fromRGB(0, 0, 0)) -- Black
                v.Transparency = 0
            else
                v.Transparency = xrayOn and 1 or 0
            end
        end
    end
end

local function toggleChestESP()
    chestESPOn = not chestESPOn

    if chestESPOn then
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name:lower():find("chest") then
                createHighlight(v, Color3.fromRGB(255, 255, 0)) -- Yellow
            end
        end
    else
        for _, v in ipairs(highlightFolder:GetChildren()) do
            if v:IsA("Highlight") and v.FillColor == Color3.fromRGB(255, 255, 0) then
                v:Destroy()
            end
        end
    end
end

local function toggleDiamondESP()
    diamondESPOn = not diamondESPOn

    if diamondESPOn then
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name:lower():find("diamond") then
                createHighlight(v, Color3.fromRGB(0, 255, 255)) -- Cyan
            end
        end
    else
        for _, v in ipairs(highlightFolder:GetChildren()) do
            if v:IsA("Highlight") and v.FillColor == Color3.fromRGB(0, 255, 255) then
                v:Destroy()
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(v)
    if v:IsA("BasePart") then
        local name = v.Name:lower()

        if xrayOn then
            if name:find("diamond") then
                createHighlight(v, Color3.fromRGB(0, 255, 255))
                v.Transparency = 0
            elseif name:find("iron") then
                createHighlight(v, Color3.fromRGB(128, 128, 128))
                v.Transparency = 0
            elseif name:find("coal") then
                createHighlight(v, Color3.fromRGB(0, 0, 0))
                v.Transparency = 0
            else
                v.Transparency = 1
            end
        end

        if chestESPOn and name:find("chest") then
            createHighlight(v, Color3.fromRGB(255, 255, 0))
        end

        if diamondESPOn and name:find("diamond") then
            createHighlight(v, Color3.fromRGB(0, 255, 255))
        end
    end
end)

local Toggle = XrayTab:CreateToggle({
   Name = "Xray",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        toggleXRay()
   end,
})

local Toggle = XrayTab:CreateToggle({
   Name = "Diamond ESP",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        toggleDiamondESP()
   end,
})

local Toggle = XrayTab:CreateToggle({
   Name = "Chest ESP",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        toggleChestESP()
   end,
})
