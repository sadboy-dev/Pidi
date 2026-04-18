-- main.lua
if not _G.RoleData or not _G.RoleUpdate then
    error("❌ getRole.lua belum terdeteksi! Pastikan loader berjalan benar.")
end

-- Tabel global untuk menyimpan status ON/OFF semua fitur
_G.FeatureState = _G.FeatureState or {
    ipadView = false,
    boostFps = false,
    crosshair = false,
    -- Tambahkan fitur baru di sini
}

-- Simpan role sebelumnya
local roleOld = _G.RoleData.IsLobby and "LOBBY" or string.upper(_G.RoleData.TeamName)

print("✅Awal:", roleOld)

-- =============================================
-- FUNCTION KHUSUS
-- =============================================

-- Reset / matikan SEMUA fitur sekaligus
function _G.ResetAllFeatures()
    for featureName, _ in pairs(_G.FeatureState) do
        _G.FeatureState[featureName] = false
    end
    print("🔄 Resetting (dimatikan)")
end

-- Fungsi utama untuk sortir fitur berdasarkan role
function _G.SortFeaturesByRole()
    local currentRole = _G.RoleData.IsLobby and "LOBBY" or string.upper(_G.RoleData.TeamName)
    if currentRole == "LOBBY" then
        local currentRole = "SPECTATOR"
    end
    
    _G.ResetAllFeatures()  -- Matikan semua fitur dulu setiap role berubah

    if currentRole == "SURVIVOR" then
        print("🌐 Team: SURVIVOR")
        -- Contoh: Fitur yang boleh aktif di lobby/spectator/survivor
        -- _G.Toggle("ESP", true)           -- contoh
        -- _G.Toggle("AutoFarm", false)     -- matikan yang berbahaya

    elseif currentRole == "KILLER" then
        print("🔪 Team: KILLER")
        -- Fitur khusus Killer
        -- _G.Toggle("KillAura", true)
        -- _G.Toggle("AutoFarm", true)

    elseif currentRole == "SPECTATOR" then
        print("🏠 Team: SPECTATOR")
        _G.Toggle("ipadView", true)

    else
        print("🌐 Mode: All Role / Role Lainnya")
        print(currentRole)
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
        print("🔄 [MAIN] Role berubah: " .. roleOld .. " → " .. newRole .. "")
        
        roleOld = newRole   -- Update role lama
        
        -- Panggil function sortir fitur
        _G.SortFeaturesByRole()
    end
end)

-- Jalankan sorting pertama kali saat main.lua di-load
_G.SortFeaturesByRole()
