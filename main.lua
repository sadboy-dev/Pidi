-- main.lua

-- Load getRole.lua terlebih dahulu
loadstring(game:HttpGet("https://raw.githubusercontent.com/.../getRole.lua"))() 
-- Ganti link di atas dengan link getRole.lua kamu (atau pakai require jika di module)

print("✅ getRole.lua telah di-load")

-- Tunggu sampai _G.RoleData tersedia
repeat
    task.wait(0.1)
until _G.RoleData and _G.RoleUpdate

print("📡 Role system siap! Team saat ini:", _G.RoleData.TeamName)

-- =============================================
-- CONTOH PENGGUNAAN DI MAIN.LUA
-- =============================================

-- 1. Mendapatkan data role saat ini
local function printCurrentRole()
    print("🔹 Role Saat Ini:")
    print("   Team Name :", _G.RoleData.TeamName)
    print("   Is Lobby  :", _G.RoleData.IsLobby)
end

-- Cetak role pertama kali
printCurrentRole()

-- 2. Mendengarkan perubahan role secara real-time
_G.RoleUpdate:Connect(function()
    print("🔄 Role telah berubah!")
    printCurrentRole()
    
    -- Contoh aksi berdasarkan role
    if _G.RoleData.IsLobby then
        print("🏠 Kamu sedang di Lobby (Spectator)")
        -- Masukkan kode untuk lobby di sini
    elseif _G.RoleData.TeamName == "murderer" then
        print("🔪 Kamu adalah Murderer!")
    elseif _G.RoleData.TeamName == "sheriff" then
        print("🔫 Kamu adalah Sheriff!")
    elseif _G.RoleData.TeamName == "innocent" then
        print("👤 Kamu adalah Innocent!")
    else
        print("❓ Role tidak dikenali: " .. _G.RoleData.TeamName)
    end
end)

-- =============================================
-- CONTOH FUNGSI TAMBAHAN (Opsional)
-- =============================================

-- Fungsi untuk mendapatkan role dalam format yang lebih bersih
local function getRole()
    if _G.RoleData.IsLobby then
        return "Lobby"
    else
        return _G.RoleData.TeamName:upper()
    end
end

-- Contoh penggunaan fungsi
print("Role fungsi:", getRole())

-- Kamu bisa memanggil getRole() kapan saja di script lain
