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

local lastStatus = nil
local lastTeam = nil

RunService.Heartbeat:Connect(function()
    local team = getTeamName(player)
    local isLobbyNow = (team == "spectator")

    RoleData.TeamName = team
    RoleData.IsLobby = isLobbyNow

    if lastStatus ~= isLobbyNow or lastTeam ~= team then
        lastStatus = isLobbyNow
        lastTeam = team
        UpdateEvent:Fire()
        print("📡 [getRole] Update ->", team, "| Lobby:", isLobbyNow)
    end
end)

return {
    Data = RoleData,
    OnUpdate = UpdateEvent.Event
}
