local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Turtle-Brand/Turtle-Lib/main/source.lua"))()

local window = library:Window("Create A Factory - CherryWare")

window:Button("Get 500B", function()
    local args = {
        workspace:WaitForChild("Base3"):WaitForChild("PlacedPieces"):WaitForChild("Seller"),
        500000000000
    }
end)

window:Button("Auto Get Moon", function()
    game:GetService("ReplicatedStorage"):WaitForChild("GiveMoonCoin"):FireServer()
        game:GetService("ReplicatedStorage"):WaitForChild("GiveMoonCoin"):FireServer()
        wait()
    end
end)
