-- MAIN.LUA
if _G.__MAIN then return end
_G.__MAIN = true

-- TUNGGU SEMUA MODUL SIAP
repeat task.wait() until _G.getRole and _G.espPlayer and _G.boostFps and _G.ipadView
task.wait(0.5)

local getRole = _G.getRole
local espPlayer = _G.espPlayer
local boostFps = _G.boostFps
local ipadView = _G.ipadView

local isActive = false

local function updateFeatures()
    local myRole = getRole(game.Players.LocalPlayer)
    print("🎭 ROLE KAMU: " .. myRole)

    -- ==============================================
    -- ✅ ALL ROLE: NYALA TERUS GAK PEDULI ROLE APA
    -- ==============================================
    -- Boost FPS
    if boostFps then boostFps() end
    
    -- iPad View
    if ipadView then ipadView() end
    
    -- ESP (SEKARANG JADI ALL ROLE JUGA!)
    if not isActive then
        print("🚀 MENGAKTIFKAN SEMUA FITUR (ALL ROLE)...")
        espPlayer:Start()
        isActive = true
    end
    -- ==============================================

end

-- CEK TERUS MENERUS
while task.wait(0.5) do
    updateFeatures()
end
