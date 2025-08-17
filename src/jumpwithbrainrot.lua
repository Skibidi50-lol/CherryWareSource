--why did i make this........

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Turtle-Brand/Turtle-Lib/main/source.lua"))()

local aure = false

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rebirth = ReplicatedStorage.Events.Rebirth
local GiveOutReward = ReplicatedStorage.Remotes.Roulette.GiveOutReward

local rewardValue = 5000

function aure()
    while aure do
        Rebirth:FireServer()
        wait()
    end
end

local window = library:Window("Jump With Brainrot - CherryWare")

window:Box("Set Money", function(text)
    local numValue = tonumber(Value)
        if numValue and numValue > 0 then
            rewardValue = numValue
        else
    end
end)

window:Button("Get Money", function()
    GiveOutReward:FireServer({
        value = rewardValue,
        type = "Money",
        chance = 0.45
    })
end)

local LayerChanged = ReplicatedStorage.Events.LayerChanged

window:Button("Inf Wins", function()
    LayerChanged:FireServer("Layer6")
end)

window:Toggle("Auto Rebirth", false, function(bool)
    aure = bool
    aure()
end)
