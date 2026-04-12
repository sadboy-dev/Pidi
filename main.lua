-- MAIN.LUA
if _G.__MAIN then return end
_G.__MAIN = true

-- TUNGGU SEBENTAR BIAR LOADER SELESAI DOWNLOAD
repeat task.wait() until _G.getRole and _G.espPlayer
task.wait(0.5)

-- AMBIL FUNGSINYA DARI GLOBAL
local getRole = _G.getRole
local espPlayer = _G.espPlayer
local boostFps = _G.boostFps
local ipadView = _G.ipadView

local lastState = nil

local function updateFeatures()
    local myRole = getRole(game.Players.LocalPlayer)
    print("🎭 ROLE KAMU: " .. myRole)

    -- ==============================================
    -- ⚡ BOOST FPS & 📱 IPAD VIEW: ALL ROLE
    -- ==============================================
    if boostFps then boostFps() end
    if ipadView then ipadView() end

    -- ==============================================
    -- 🎯 ESP: HANYA BUKAN SPECTATOR
    -- ==============================================
    local shouldEnable = true -- Paksa nyala semua role

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
