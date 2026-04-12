-- main.lua
if _G.__MAIN then return end
_G.__MAIN = true

print("✅ [MAIN] SCRIPT START!")

-- LOAD SEMUA MODULE FITUR
local IpadView = require(script.modules.ipadView)
local Crosshair = require(script.modules.crosshair)
local EspPlayer = require(script.modules.espPlayer)

local isSpectatorMode = false

local function enableSpectatorFeatures()
    if isSpectatorMode then return end
    isSpectatorMode = true
    player.CharacterAdded:Connect(function()
        task.wait(0.5)
        IpadView.applyFOV()
    end)

    print("🔌 ACTIVATING: SPECTATOR FEATURES")
    IpadView.On()
    Crosshair.On()
    EspPlayer.On()
end

-- DETEKSI ROLE
local function onUpdate()
    local data = _G.RoleData
    local team = data.TeamName
    local isLobby = data.IsLobby

    local isSpec = isLobby or team == "spectator" or team == ""

    if isSpec then
        print("📍 STATUS: LOBBY / SPECTATOR")
        enableSpectatorFeatures()
    else
        print("📍 STATUS: INGAME | ROLE: " .. team)
        disableSpectatorFeatures()
    end
end

-- JALANKAN
repeat task.wait() until _G.RoleData and _G.RoleUpdate
_G.RoleUpdate:Connect(onUpdate)
task.wait(0.1)
onUpdate()

print("✅ [MAIN] SYSTEM READY!")
