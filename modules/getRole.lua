-- modules/getRole.lua

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local UpdateEvent = Instance.new("BindableEvent")

local RoleData = {
    TeamName = "",
    IsLobby = false
}

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

    RoleData.TeamName = team
    RoleData.IsLobby = lobby

    if last ~= lobby or last ~= team then
        last = lobby
        UpdateEvent:Fire()
        print("📡 [getRole] Update ->", team, "| Lobby:", lobby)
    end
end)

return {
    Data = RoleData,
    OnUpdate = UpdateEvent.Event
}
