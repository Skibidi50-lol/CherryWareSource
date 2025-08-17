local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Turtle-Brand/Turtle-Lib/main/source.lua"))()

local af = false

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

pcall(function()
    print("auto farm loaded")
end)

local function autoFarm()
    local event = ReplicatedStorage:WaitForChild("Events"):WaitForChild("MoveHazmatEvent")
    RunService.Heartbeat:Connect(function()
        if af then
            pcall(function()
                event:FireServer()
            end)
        end
    end)
end

local window = library:Window("Thats Not My Neighbour - CherryWare")

window:Toggle("Auto Farm", false, function(bool)
    af = bool
    autoFarm()
end)
