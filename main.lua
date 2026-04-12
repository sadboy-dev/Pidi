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
    return ""
end

local lastStatus = nil -- Untuk menyimpan status sebelumnya

RunService.RenderStepped:Connect(function()
    local team = getTeam(player)
    local currentStatus

    if team == "spectator" then
        currentStatus = "LOBBY"
    else
        currentStatus = "INGAME - "..team
    end

    -- Hanya print kalau statusnya BERUBAH
    if currentStatus ~= lastStatus then
        lastStatus = currentStatus
        print("📍 STATUS:", currentStatus)
    end
end)
