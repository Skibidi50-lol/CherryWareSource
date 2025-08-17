local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Turtle-Brand/Turtle-Lib/main/source.lua"))()

getgenv().autopunch = false
getgenv().infstamina = true


local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character

local PunchRemote = Character:WaitForChild("Controller", 9999999999):WaitForChild("M1", 9999999999)

function autopunch()
    PunchRemoteRemote:FireServer()
    end

    while getgenv().autopunch and task.wait() do
    autopunch()
end

function infstamina()
if Character then
    if Character:GetAttribute("Stamina") then
        Character:SetAttribute("Stamina", 9e9)
            end
            end
        end
        while getgenv().infstamina and task.wait() do
    infstamina()
end

local window = library:Window("Dictator - CherryWare")

window:Toggle("Inf Saitama", false, function(bool)
    infstamina = bool
    infstamina()
end)

window:Toggle("Auto Punch", false, function(bool)
    autopunch = bool
    autopunch()
end)
