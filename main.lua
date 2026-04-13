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
    elseif _G.RoleData.TeamName == "survivor" then
        print("🔪 Kamu adalah Survivor!")
    elseif _G.RoleData.TeamName == "killer" then
        print("🔫 Kamu adalah Killer!")
    else
        print("❓ Role tidak dikenali: " .. _G.RoleData.TeamName)
    end
end)


-- Kamu bisa memanggil getRole() kapan saja di script lain
