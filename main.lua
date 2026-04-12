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
        local n = plr.Team.Name:lower()
        return n
    end
    return plr.Team.Name
end

local team = ""
RunService.RenderStepped:Connect(function()
        local team = getTeam(player)
        if team == Spectator or team == spectator then
            print("📍 STATUS: LOBBY")
        else
            print("📍 STATUS: INGAME")
            print("🎭 ROLE KAMU:",team)
        end
        lastTeam = team
    end
end
