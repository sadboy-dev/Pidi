-- MAIN.LUA
if _G.__MAIN then return end
_G.__MAIN = true

-- PANGGIL MODUL
local getRole = require(script.Parent.modules.getRole)
local espPlayer = require(script.Parent.modules.espPlayer)
-- Tambahin yang lain kalau ada: local aimbot = ... dst

local lastState = nil

local function updateFeatures()
    local myRole = getRole(game.Players.LocalPlayer)
    print("🎭 ROLE KAMU: " .. myRole) -- Cek di console
    
    -- ATURAN: HANYA NYALA KALAU BUKAN SPECTATOR
    local shouldEnable = (myRole ~= "SPECTATOR")

    if shouldEnable and lastState ~= true then
        print("🚀 MENGAKTIFKAN FITUR...")
        espPlayer.Start()
        -- aimbot.Start() dst
        lastState = true
    elseif not shouldEnable and lastState ~= false then
        print("🔌 MENONAKTIFKAN FITUR (SPECTATOR)...")
        espPlayer.Stop()
        -- aimbot.Stop() dst
        lastState = false
    end
end

-- CEK TERUS MENERUS
while task.wait(0.5) do
    updateFeatures()
end
