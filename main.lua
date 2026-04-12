-- ANTI DOUBLE RUN
if _G.__LOADER_FINAL then return end
_G.__LOADER_FINAL = true

--------------------------------------------------
-- SERVICES
--------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local function getTeam(plr)
    if plr.Team then
        return plr.Team.Name:lower()
    end
    return "" -- Kembalikan kosong kalau tidak ada team
end

local lastTeam = ""

RunService.RenderStepped:Connect(function()
    local team = getTeam(player)
    
    if team == "spectator" then
        print("📍 STATUS: LOBBY")
    else
        print("📍 STATUS: INGAME")
        print("🎭 ROLE KAMU:", team)
    end
    
    lastTeam = team
end)
