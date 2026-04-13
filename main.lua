-- main.lua
if not _G.RoleData or not _G.RoleUpdate then
    error("❌ getRole.lua belum terdeteksi! Pastikan loader berjalan benar.")
end

-- Tabel global untuk menyimpan status ON/OFF semua fitur
_G.FeatureState = _G.FeatureState or {
    AutoFarm = false,
    ESP = false,
    KillAura = false,
    -- Tambah fitur baru di sini nanti
}
local roleOld = string.upper(_G.RoleData.TeamName))

print("✅ Posisi awal:", _G.RoleData.IsLobby and "LOBBY" or string.upper(_G.RoleData.TeamName))
print(string.upper(_G.RoleData.TeamName))

-- Fungsi global untuk toggle fitur (bisa dipanggil dari script lain)
function _G.Toggle(featureName, enabled)
    if _G.FeatureState[featureName] ~= nil then
        _G.FeatureState[featureName] = enabled
        print("🔄 [" .. featureName .. "] " .. (enabled and "ON" or "OFF"))
    else
        warn("❌ Fitur tidak ditemukan: " .. featureName)
    end
end

-- Listener role change dari getRole.lua
_G.RoleUpdate:Connect(function()
    local role = _G.RoleData.IsLobby and "LOBBY" or string.upper(_G.RoleData.TeamName)
    print("🔄 [MAIN] Role berubah → " .. role)
    local roleOld = role

    -- Contoh logic otomatis berdasarkan role
    if _G.RoleData.IsLobby then
        print("🏠 Di Lobby → Matikan fitur berbahaya")
        _G.Toggle("AutoFarm", false)
        _G.Toggle("KillAura", false)
    end
end)

