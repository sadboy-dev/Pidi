if _G.__MAIN then return end
_G.__MAIN = true

-- PANGGIL MODUL
local getRole = require(script.Parent.modules.getRole)
local espPlayer = require(script.Parent.modules.espPlayer)

local lastState = nil -- Biar tidak spam on/off

local function updateFeatures()
    local myRole = getRole(game.Players.LocalPlayer) -- Cek role DIRI SENDIRI
    
    -- === ATURAN NYA ===
    -- Contoh: ESP hanya nyala kalau kamu KILLER atau SURVIVOR, mati kalau SPECTATOR
    local shouldEnable = (myRole == "KILLER" or myRole == "SURVIVOR")

    if shouldEnable and lastState ~= true then
        espPlayer.Start()
        lastState = true
    elseif not shouldEnable and lastState ~= false then
        espPlayer.Stop()
        lastState = false
    end
end

-- JALANKAN TERUS MENERUS
while task.wait(0.5) do
    updateFeatures()
end
