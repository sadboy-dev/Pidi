-- getRole.lua

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

local last = nil

RunService.Heartbeat:Connect(function()
    local team = getTeamName(player)
    local lobby = (team == "spectator")

    _G.RoleData.TeamName = team
    _G.RoleData.IsLobby = lobby

    if last ~= lobby or last ~= team then
        last = lobby
        UpdateEvent:Fire()
        print("📡 [GETROLE] Update ->", team, "Lobby:", lobby)
    end
end)

print("✅ [GETROLE] LOADED!")
