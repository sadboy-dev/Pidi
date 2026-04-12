-- MAIN.LUA
if _G.__MAIN then return end
_G.__MAIN = true

-- TUNGGU LOADER SELESAI
repeat task.wait() until _G.Modules ~= nil
task.wait(0.5)

-- AMBIL DARI GLOBAL (BUKAN REQUIRE)
local getRole = _G.Modules["getRole.lua"]
local espPlayer = _G.Modules["espPlayer.lua"]
local boostFps = _G.Modules["boostFps.lua"]
local ipadView = _G.Modules["ipadView.lua"]

-- CEK APAKAH ESP PLAYER KETEMU
if not espPlayer then
    error("❌ ESP PLAYER TIDAK TERBACA! Cek kembali link & file GitHub.")
end

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
    -- 🎯 ESP & CROSSHAIR: HANYA BUKAN SPECTATOR
    -- ==============================================
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
