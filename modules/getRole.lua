-- getRole.lua
-- VERSI UNTUK LOADER SIMPLE

if _G.RoleData then return end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

_G.RoleData = {
    TeamName = "",
    IsLobby = false
}

local UpdateEvent = Instance.new("BindableEvent")
_G.RoleUpdate = UpdateEvent.Event

local function getTeamName(plr)
    if plr.Team then
        return plr.Team.Name:lower()
    end
    return ""
end

local lastStatus = nil
local lastTeam = nil

RunService.Heartbeat:Connect(function()
    local team = getTeamName(player)
    local isLobbyNow = (team == "spectator")

    _G.RoleData.TeamName = team
    _G.RoleData.IsLobby = isLobbyNow

    -- PRINT HANYA KALAU BERUBAH
    if lastStatus ~= isLobbyNow or lastTeam ~= team then
        lastStatus = isLobbyNow
        lastTeam = team
        UpdateEvent:Fire()
        
        if isLobbyNow then
            print("📡 [getRole] STATUS: LOBBY")
        else
            print("📡 [getRole] STATUS: INGAME | ROLE:", team)
        end
    end
end)

print("✅ [GETROLE] LOADED!")
