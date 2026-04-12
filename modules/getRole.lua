-- getRole.lua

if _G.__LOADER_ROLE then return end
_G.__LOADER_ROLE = true

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Buat Event untuk memberi sinyal ke main.lua
local UpdateEvent = Instance.new("BindableEvent")
_G.RoleUpdate = UpdateEvent.Event

_G.RoleData = {
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

RunService.RenderStepped:Connect(function()
    local team = getTeamName(player)
    local isLobbyNow = (team == "spectator")

    -- Cek kalau ada perubahan
    if isLobbyNow ~= lastStatus or team ~= lastTeam then
        lastStatus = isLobbyNow
        lastTeam = team
        
        -- Simpan data terbaru
        _G.RoleData.TeamName = team
        _G.RoleData.IsLobby = isLobbyNow

        -- KIRIM SINYAL KE MAIN.LUA
        UpdateEvent:Fire()

        -- Print di sini saja
        if isLobbyNow then
            print("📡 [getRole] STATUS: LOBBY")
        else
            print("📡 [getRole] STATUS: INGAME | ROLE:", team)
        end
    end
end)
