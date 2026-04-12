-- MAIN.LUA
if _G.__MAIN then return end
_G.__MAIN = true

-- PANGGIL MODUL
local getRole = require(script.Parent.modules.getRole)
local espPlayer = require(script.Parent.modules.espPlayer)
local boostFps = require(script.Parent.modules.boostFps)
local ipadView = require(script.Parent.modules.ipadView) -- Panggil ipadView

local lastState = nil

local function updateFeatures()
    local myRole = getRole(game.Players.LocalPlayer)
    print("🎭 ROLE KAMU: " .. myRole)

    -- ==============================================
    -- ⚡ BOOST FPS & 📱 IPAD VIEW: ALL ROLE
    -- JALAN SETIAP KALI ROLE GANTI / TERDETEKSI
    -- ==============================================
    print("⚡ BOOST FPS: DIAKTIFKAN ULANG...")
    boostFps()
    
    print("📱 IPAD VIEW: DIAKTIFKAN ULANG...")
    ipadView()
    -- ==============================================


    -- ATURAN FITUR LAIN (ESP, DLL)
    local shouldEnable = (myRole ~= "SPECTATOR")

    if shouldEnable and lastState ~= true then
        print("🚀 MENGAKTIFKAN FITUR GAME...")
        espPlayer.Start()
        lastState = true
    elseif not shouldEnable and lastState ~= false then
        print("🔌 MENONAKTIFKAN FITUR GAME (SPECTATOR)...")
        espPlayer.Stop()
        lastState = false
    end
end

-- CEK ROLE TERUS MENERUS
while task.wait(0.5) do
    updateFeatures()
end
