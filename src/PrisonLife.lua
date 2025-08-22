local ArrayField = loadstring(game:HttpGet('https://raw.githubusercontent.com/Skibidi50-lol/ArrayField/refs/heads/main/Source.lua'))()

local Window = ArrayField:CreateWindow({
   Name = "CherryWare - Prison Life",
   LoadingTitle = "Loading....",
   LoadingSubtitle = "by Cherry",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Hubs"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
        Title = "Cherry Key",
        Subtitle = "Key System",
        Note = "Check The Github Link (github.com/Skibidi50-lol/SyntixCode)",
        FileName = "ArrayFieldsKeys",
        SaveKey = true,
        GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like ArrayField to get the key from
        Key = {"https://pastebin.com/raw/sDPVE2G7"},
        Actions = {
                [1] = {
                    Text = 'Click here to copy the key link',
                    OnPress = function()
                        setclipboard("https://pastebin.com/raw/Q9pJMv43")
                    end,
                }
        },
        }
    })
--Variables
local LocalPlayer = game:GetService("Players").LocalPlayer
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SelfRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
local SelfName = game.Players.LocalPlayer.Name
local DamageRemote = game.ReplicatedStorage.meleeEvent
backpack = game:GetService("Players").LocalPlayer.Backpack

--Toggles & Main Variables
local InfiniteJumpEnabled = false
local noclipEnabled = false
local Sonic = false
local KillAuraEnabled = false
local KillAllEnabled = false

local loopKillPlayerName = ""
local LoopKillPlayerEnabled = false

local LoopKillGuardsEnabled = false
local LoopKillInmatesEnabled = false
local LoopKillCriminalsEnabled = false

local message = ""
local ChatSpamEnabled = false

local guntocolor = "";
local color = BrickColor.Red();

--main function
local gun = "";

local SP = {}
local PG = {
    ["AK-47"] = true,
    ["Remington 870"] = true,
    ["M9"] = true,
    ["M4A1"] = false,
    ["All"] = true
}

local SetCFrame = function(x : CFrame)
    LocalPlayer.Character['HumanoidRootPart'].CFrame = x;
end

local GrabItem = function(itemorigin, item)
    local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
    local timeout = tick() + 5

    if hrp then 
        SP.GetGunOldPos = not SP.GetGunOldPos and hrp.CFrame or SP.GetGunOldPos;
    end

    local ItemToGrab = itemorigin:FindFirstChild(item)
    local IP = ItemToGrab['ITEMPICKUP']
    local IPPos= IP.Position

    if hrp then 
        SetCFrame(CFrame.new(IPPos));
    end; 

    repeat task.wait()

        pcall(function()
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = false;
            SetCFrame(CFrame.new(IP))
        end); 
        task.spawn(function()
            game:GetService("Workspace").Remote.ItemHandler:InvokeServer(IP)
        end)

    until LocalPlayer.Backpack:FindFirstChild(item) or LocalPlayer.Character:FindFirstChild(item) or tick() - timeout >=0

    pcall(function() 
        SetCFrame(SP.GetGunOldPos);
    end) 


    SP.GetGunOldPos = nil
end

local GiveItem = function(gungiver, gun)
    if gungiver and gungiver == "old" then
        game:GetService("Workspace").Remote.ItemHandler:InvokeServer(gun)

        return
    end

    for _, givers in pairs(workspace.Prison_ITEMS:GetChildren()) do
        if givers:FindFirstChild(gun) then
            GrabItem(gungiver, gun)
            break
        end

        return
    end

    if gungiver then
        workspace.Remote.ItemHandler:InvokeServer({Position = LocalPlayer.Character.Head.Position, Parent = gungiver:FindFirstChild(gun)})
    else
        workspace.Remote.ItemHandler:InvokeServer({Position = LocalPlayer.Character.Head.Position, Parent = workspace.Prison_ITEMS.giver:FindFirstChild(gun) or workspace.Prison_ITEMS.single:FindFirstChild(gun)})
    end
end

local SpawnGun = function(guntogive : string)
    if guntogive ~= "All" then
        workspace.Remote.ItemHandler:InvokeServer({
            Position = LocalPlayer.Character.Head.Position,
            Parent = workspace.Prison_ITEMS.giver:FindFirstChild(guntogive)
                or workspace.Prison_ITEMS.single:FindFirstChild(guntogive)
        })
    else
        for gunName, _ in pairs(PG) do
            if gunName ~= "All" then
                workspace.Remote.ItemHandler:InvokeServer({
                    Position = LocalPlayer.Character.Head.Position,
                    Parent = workspace.Prison_ITEMS.giver:FindFirstChild(gunName)
                        or workspace.Prison_ITEMS.single:FindFirstChild(gunName)
                })
            end
        end
    end
end
--INFJUMP
game:GetService("UserInputService").JumpRequest:connect(function()
	if InfiniteJumpEnabled then
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
	end
end)
--NOCLIP
RunService.Stepped:Connect(function()
    if noclipEnabled then
        local player = Players.LocalPlayer
        local character = player and player.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end
end)
--Sonic
function Sonic()
    if Sonic then
        local Char = LocalPlayer.Character
        Char.Humanoid.WalkSpeed = 42
    end
end
-- KILL AURA
RunService.Stepped:Connect(function()
    if KillAuraEnabled then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if distance < 15 then
                    pcall(function()
                        DamageRemote:FireServer(player)
                    end) -- THIS ')' WAS MISSING
                end
            end
        end
    end
end)

-- KILL ALL
RunService.Stepped:Connect(function()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("HumanoidRootPart") then
            if player.Character:FindFirstChildOfClass("ForceField") == nil and player.Character.Humanoid.Health > 0 then
                LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                DamageRemote:FireServer(player)
            end
        end
    end
end) -- THIS ')' WAS MISSING TOO
--LOOPKILL GUARD
RunService.RenderStepped:Connect(function()
    if LoopKillGuardsEnabled then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= LocalPlayer 
                and player.Team == game:GetService("Teams"):FindFirstChild("Guards") 
                and player.Character 
                and player.Character:FindFirstChild("Humanoid") 
                and player.Character:FindFirstChild("HumanoidRootPart") 
                and not player.Character:FindFirstChildOfClass("ForceField") 
                and player.Character.Humanoid.Health > 0 then

                LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                DamageRemote:FireServer(player)
            end
        end
    end
end)
--LOOPKILL INMATES
RunService.RenderStepped:Connect(function()
    if LoopKillInmatesEnabled then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= LocalPlayer 
                and player.Team == game:GetService("Teams"):FindFirstChild("Inmates") 
                and player.Character 
                and player.Character:FindFirstChild("Humanoid") 
                and player.Character:FindFirstChild("HumanoidRootPart") 
                and not player.Character:FindFirstChildOfClass("ForceField") 
                and player.Character.Humanoid.Health > 0 then

                LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                DamageRemote:FireServer(player)
            end
        end
    end
end)

--LOOPKILL CRIMINALS
RunService.RenderStepped:Connect(function()
        if LoopKillCriminalsEnabled then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= LocalPlayer 
                and player.Team == game:GetService("Teams"):FindFirstChild("Criminals") 
                and player.Character 
                and player.Character:FindFirstChild("Humanoid") 
                and player.Character:FindFirstChild("HumanoidRootPart") 
                and not player.Character:FindFirstChildOfClass("ForceField") 
                and player.Character.Humanoid.Health > 0 then

                LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                DamageRemote:FireServer(player)
            end
        end
    end
end)
--LOOPKILL PLAYER
RunService.RenderStepped:Connect(function()
   if LoopKillPlayerEnabled and loopKillPlayerName ~= "" then
      local target = Players:FindFirstChild(loopKillPlayerName)
      if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and target.Character:FindFirstChild("Humanoid") then
         if not target.Character:FindFirstChildOfClass("ForceField") and target.Character.Humanoid.Health > 0 then
            LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
            DamageRemote:FireServer(target)
         end
      end
   end
end)
--TABS
local MainTab = Window:CreateTab("Main", 121160482905138)
local LoopTab = Window:CreateTab("Loops", 121160482905138)
local PlayerTab = Window:CreateTab("Player", 121160482905138)
--MAIN
local MainSection = MainTab:CreateSection("Main Settings",false)

local Dropdown = MainTab:CreateDropdown({
   Name = "Get Gun",
   Options = {"M9","Remington 870", "AK-47", "M4A1"},
   CurrentOption = nil,
   SectionParent = MainSection,
   MultiSelection = false, -- If MultiSelections is allowed
   Flag = "GunDropdown",
   Callback = function(Option)
   gun = Option
   if PG[gun] then
   SpawnGun(gun);
   ArrayField:Notify({
            Title = "Gun Spawner",
            Content = "Successfully Gave You "..gun,
            Duration = 4.5,
            Image = 121160482905138,
        })
      end
   end,
})

local Button = MainTab:CreateButton({
   Name = "Get All Guns",
   Interact = 'Button',
   SectionParent = MainSection,
   Callback = function()
      if PG["All"] then
         SpawnGun("All")
         ArrayField:Notify({
            Title = "Gun Spawner",
            Content = "Successfully Gave You All Guns",
            Duration = 4.5,
            Image = 121160482905138,
        })
      end
   end,
})

local Button = MainTab:CreateButton({
   Name = "Kill All",
   SectionParent = MainSection,
   Interact = 'Button',
   Callback = function()
            spawn(function()
                wait(0.1)
                for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                    pcall(function()
                        if v ~= game:GetService("Players").LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") then
                            if not v.Character:FindFirstChildOfClass("ForceField") and v.Character.Humanoid.Health > 0 then
                                while v.Character.Humanoid.Health > 0 do
                                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                                    for _, c in pairs(game:GetService("Players"):GetPlayers()) do
                                        if c ~= game:GetService("Players").LocalPlayer then
                                            game.ReplicatedStorage.meleeEvent:FireServer(c)
                                        end
                                    end
                                    wait()
                                end
                            end
                        end
                    end)
                    wait()
                end
            end)
        ArrayField:Notify({
            Title = "Kill All",
            Content = "Successfully Kill All The Player!",
            Duration = 4.5,
            Image = 121160482905138,
        })
   end,
})

local Button = MainTab:CreateButton({
   Name = "Get Secret Mirror",
   SectionParent = MainSection,
   Interact = 'Button',
   Callback = function()
      local mirror = game.ReplicatedStorage.Tools["Extendo mirror"]:Clone()
      mirror.Parent = game.Players.LocalPlayer.Backpack
      --Nofacations
        ArrayField:Notify({
            Title = "Item Spawner",
            Content = "Successfully Gave You Extendo mirror",
            Duration = 4.5,
            Image = 121160482905138,
        })
   end,
})

local Dropdown = MainTab:CreateDropdown({
   Name = "Gun To Color",
   Options = {"M9","Remington 870", "AK-47", "M4A1"},
   CurrentOption = nil,
   SectionParent = MainSection,
   MultiSelection = false, -- If MultiSelections is allowed
   Flag = "GunToColorDropdown",
   Callback = function(Option)
      guntocolor = Option
   end,
})

local Dropdown = MainTab:CreateDropdown({
   Name = "Select Color",
   Options = {"Red","Blue", "Green", "Purple"},
   CurrentOption = "Red",
   SectionParent = MainSection,
   MultiSelection = false,
   Flag = "GunColorDropdown",
   Callback = function(Option)
      if Option == "Red" then
         color = BrickColor.new("Bright red")
      elseif Option == "Blue" then
         color = BrickColor.new("Bright blue")
      elseif Option == "Green" then
         color = BrickColor.new("Lime green")
      elseif Option == "Purple" then
         color = BrickColor.new("Royal purple")
      end
   end,
})

local Button = MainTab:CreateButton({
   Name = "Apply Color",
   SectionParent = MainSection,
   Interact = 'Button',
   Callback = function()
        for i,x in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if x:IsA("Tool") and x.Name == guntocolor then
                for i,z in pairs(x:GetDescendants()) do
                    if z:IsA("BasePart") then
                        z.CastShadow = false;
                        z.Material = Enum.Material.Neon
                        z.BrickColor = color
                    end
                end
            end
        end

        ArrayField:Notify({
            Title = "Gun Color",
            Content = "Successfully Change Your Gun Color!",
            Duration = 4.5,
            Image = 121160482905138,
        })
   end,
})

local Paragraph = MainTab:CreateParagraph({Title = "Information:", Content = "Make sure that the gun is equipted."},MainSection)

local FunSection = MainTab:CreateSection("Fun",false)

local Input = MainTab:CreateInput({
   Name = "Chat Spammer Message",
   PlaceholderText = "Enter Message",
   SectionParent = FunSection,
   NumbersOnly = false, -- If the user can only type numbers. Remove or set to false if none.
   CharacterLimit = 75, --max character limit. Remove or set to false
   OnEnter = false, -- Will callback only if the user pressed ENTER while being focused on the the box.
   RemoveTextAfterFocusLost = false, -- Speaks for itself.
   Callback = function(Text)
      message = Text
   end,
})

local Toggle = MainTab:CreateToggle({
   Name = "Chat Spam",
   SectionParent = FunSection,
   CurrentValue = false,
   Flag = "ChatToggle",
   Callback = function(Value)
      ChatSpamEnabled = Value
      while ChatSpamEnabled do
         game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
         wait(1.5)
      end
   end,
})
--LOOPS
local LoopsSection = LoopTab:CreateSection("Loops Settings",false)

local Toggle = LoopTab:CreateToggle({
   Name = "Kill Aura",
   SectionParent = LoopsSection,
   CurrentValue = false,
   Flag = "AuraToggle",
   Callback = function(Value)
      KillAuraEnabled = Value
   end,
})

local Toggle = LoopTab:CreateToggle({
   Name = "Loop Kill All",
   SectionParent = LoopsSection,
   CurrentValue = false,
   Flag = "KillToggle",
   Callback = function(Value)
        KillAllEnabled = Value
   end,
})

local Toggle = LoopTab:CreateToggle({
   Name = "Loop Kill Guards",
   SectionParent = LoopsSection,
   CurrentValue = false,
   Flag = "LoopKillGuardsToggle",
   Callback = function(Value)
      LoopKillGuardsEnabled = Value
   end,
})

local Toggle = LoopTab:CreateToggle({
   Name = "Loop Kill Inmates",
   SectionParent = LoopsSection,
   CurrentValue = false,
   Flag = "LoopKillInmatesToggle",
   Callback = function(Value)
      LoopKillInmatesEnabled = Value
   end,
})

local Toggle = LoopTab:CreateToggle({
   Name = "Loop Kill Criminals",
   SectionParent = LoopsSection,
   CurrentValue = false,
   Flag = "LoopKillCriminalsToggle",
   Callback = function(Value)
      LoopKillCriminalsEnabled = Value
   end,
})


local Input = LoopTab:CreateInput({
   Name = "Loop Kill Player",
   PlaceholderText = "Enter player name",
   SectionParent = LoopsSection,
   CharacterLimit = 30,
   Callback = function(Text)
      loopKillPlayerName = Text
   end,
})

local Toggle = LoopTab:CreateToggle({
   Name = "Loop Kill Player",
   SectionParent = LoopsSection,
   CurrentValue = false,
   Flag = "LoopKillPlayerToggle",
   Callback = function(Value)
      LoopKillPlayerEnabled = Value
   end,
})


--PLAYER
local PlayerSection = PlayerTab:CreateSection("Player Settings",false)
local Slider = PlayerTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 500},
   Increment = 1,
   SectionParent = PlayerSection,
   Suffix = "WS",
   CurrentValue = 16,
   Flag = "SpeedSlider1",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

local Slider = PlayerTab:CreateSlider({
   Name = "JumpPower",
   Range = {50, 500},
   Increment = 1,
   SectionParent = PlayerSection,
   Suffix = "JP",
   CurrentValue = 50,
   Flag = "JumpSlider",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})

local Toggle = PlayerTab:CreateToggle({
   Name = "Infinite Jump",
   SectionParent = PlayerSection,
   CurrentValue = false,
   Flag = "InfToggle",
   Callback = function(Value)
      InfiniteJumpEnabled = Value
   end,
})

local Toggle = PlayerTab:CreateToggle({
   Name = "Noclip",
   SectionParent = PlayerSection,
   CurrentValue = false,
   Flag = "NoclipToggle",
   Callback = function(Value)
      noclipEnabled = Value
   end,
})

local Toggle = PlayerTab:CreateToggle({
   Name = "Sonic",
   SectionParent = PlayerSection,
   CurrentValue = false,
   Flag = "SonicToggle",
   Callback = function(Value)
      Sonic = Value
      Sonic()
   end,
})

ArrayField:Notify({
   Title = "Script Executed!",
   Content = "You Executed Syntix Hub!",
   Duration = 4.5,
   Image = 121160482905138,
   Actions = {
      Ignore = {
         Name = "Okay!",
         Callback = function()
         
      end
   },
 },
})
