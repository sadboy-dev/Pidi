-- main.lua
if not _G.RoleData or not _G.RoleUpdate then
    error("❌ getRole.lua belum terdeteksi! Pastikan loader berjalan benar.")
end

-- Tabel global untuk menyimpan status ON/OFF semua fitur
_G.FeatureState = _G.FeatureState or {
    AutoFarm = false,
    ESP = false,
    KillAura = false,
    -- Tambahkan fitur baru di sini
}

-- Simpan role sebelumnya
local roleOld = _G.RoleData.IsLobby and "LOBBY" or string.upper(_G.RoleData.TeamName)

print("✅ main.lua loaded sebagai base. Role awal:", roleOld)

-- =============================================
-- FUNCTION KHUSUS
-- =============================================

-- Reset / matikan SEMUA fitur sekaligus
function _G.ResetAllFeatures()
    for featureName, _ in pairs(_G.FeatureState) do
        _G.FeatureState[featureName] = false
    end
    print("🔄 Semua fitur telah di-reset (dimatikan)")
end

-- Fungsi utama untuk sortir fitur berdasarkan role
function _G.SortFeaturesByRole()
    local currentRole = _G.RoleData.IsLobby and "LOBBY" or string.upper(_G.RoleData.TeamName)
    
    print("🔀 Sorting fitur untuk role:", currentRole)

    _G.ResetAllFeatures()  -- Matikan semua fitur dulu setiap role berubah

    if currentRole == "LOBBY" or currentRole == "SPECTATOR" or currentRole == "SURVIVOR" then
        print("🏠 Mode: Lobby / Spectator / Survivor")
        -- Contoh: Fitur yang boleh aktif di lobby/spectator/survivor
        -- _G.Toggle("ESP", true)           -- contoh
        -- _G.Toggle("AutoFarm", false)     -- matikan yang berbahaya

    elseif currentRole == "KILLER" then
        print("🔪 Mode: KILLER")
        -- Fitur khusus Killer
        -- _G.Toggle("KillAura", true)
        -- _G.Toggle("AutoFarm", true)

    else
        print("🌐 Mode: All Role / Role Lainnya")
        -- Fitur yang aktif untuk semua role selain di atas
        -- _G.Toggle("ESP", true)
    end
end

-- Fungsi global untuk toggle fitur (bisa dipanggil dari script lain)
function _G.Toggle(featureName, enabled)
    if _G.FeatureState[featureName] ~= nil then
        _G.FeatureState[featureName] = enabled
        print("🔄 [" .. featureName .. "] " .. (enabled and "ON" or "OFF"))
    else
        warn("❌ Fitur tidak ditemukan: " .. featureName)
    end
end

-- =============================================
-- LISTENER ROLE CHANGE
-- =============================================

_G.RoleUpdate:Connect(function()
    local newRole = _G.RoleData.IsLobby and "LOBBY" or string.upper(_G.RoleData.TeamName)

    -- Hanya proses jika role benar-benar berubah
    if newRole ~= roleOld then
        print("🔄 [MAIN] Role berubah → " .. newRole .. " (dari " .. roleOld .. ")")
        
        roleOld = newRole   -- Update role lama
        
        -- Panggil function sortir fitur
        _G.SortFeaturesByRole()
    end
end)

-- Jalankan sorting pertama kali saat main.lua di-load
_G.SortFeaturesByRole()

print("🎯 main.lua siap! Gunakan _G.Toggle('NamaFitur', true/false) dan _G.ResetAllFeatures()")
