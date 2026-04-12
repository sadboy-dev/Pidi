-- main.lua

if _G.__MAIN then return end
_G.__MAIN = true

print("✅ [MAIN] SCRIPT START!")

local function onUpdate()
    if _G.RoleData.IsLobby then
        print("📍 STATUS: LOBBY")
    else
        print("📍 STATUS: INGAME | ROLE: " .. _G.RoleData.TeamName)
    end
end

-- Tunggu siap
repeat task.wait() until _G.RoleData and _G.RoleUpdate

-- Dengerin perubahan
_G.RoleUpdate:Connect(onUpdate)

-- Cek awal
task.wait(0.1)
onUpdate()

print("✅ [MAIN] READY!")
