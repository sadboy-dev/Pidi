-- main.lua

if _G.__MAIN then return end
_G.__MAIN = true

-- VARIABEL PENGAMAN
local lastStatus = nil

local function onUpdate()
    local data = _G.RoleData
    local isLobby = data.IsLobby
    local team = data.TeamName

    -- HANYA PRINT KALAU BERUBAH
    if lastStatus ~= isLobby then
        lastStatus = isLobby

        if isLobby then
            print("📍 STATUS: LOBBY / SPECTATOR")
        else
            print("📍 STATUS: INGAME | TEAM: " .. team)
        end
    end
end

-- JALANKAN
repeat task.wait() until _G.RoleData and _G.RoleUpdate
_G.RoleUpdate:Connect(onUpdate)
task.wait(0.1)
onUpdate()
