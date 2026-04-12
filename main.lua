-- main.lua

if _G.__LOADER_MAIN then return end
_G.__LOADER_MAIN = true

-- Tunggu sampai data dan event siap
repeat task.wait() until _G.RoleData and _G.RoleUpdate

-- Fungsi ini JALAN OTOMATIS kalau team/status berubah
local function onStatusChanged()
    local isLobby = _G.RoleData.IsLobby
    local team = _G.RoleData.TeamName

    if isLobby then
        print("📍 [main] Sedang di Lobby")
        -- Matikan fitur di sini kalau perlu
    else
        print("📍 [main] Sedang InGame | Role: " .. team)
        -- Jalanin fitur Aimbot/ESP di sini
    end
end

-- PASANG LISTENER
-- Sekarang main.lua tidak perlu ngecek terus menerus
-- Cukup tunggu dikabari sama getRole.lua
_G.RoleUpdate:Connect(onStatusChanged)

-- Cek sekali saat pertama jalan
onStatusChanged()

print("✅ Main Script Ready!")
