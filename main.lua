-- main.lua

if _G.__MAIN then return end
_G.__MAIN = true

-- VARIABEL PENGAMAN
local lastStatus = nil
local featuresLoaded = false

local LINK_BOOSTFPS = "https://raw.githubusercontent.com/sadboy-dev/Pidi/main/modules/boostFps"
local LINK_IPADVIEW = "https://raw.githubusercontent.com/sadboy-dev/Pidi/main/modules/ipadView"
local LINK_CROSSHAIR = "https://raw.githubusercontent.com/sadboy-dev/Pidi/main/modules/crosshair.lua"
local LINK_ESPPLAYER = "https://raw.githubusercontent.com/sadboy-dev/Pidi/main/modules/espPlayer.lua"

local boostFps = loadstring(game:HttpGet(LINK_BOOSTFPS))
local ipadView = loadstring(game:HttpGet(LINK_IPADVIEW))
local crosshair = loadstring(game:HttpGet(LINK_CROSSHAIR))
local espPlayer = loadstring(game:HttpGet(LINK_espPlayer))

--------------------------------------------------
-- LOGIKA UTAMA
--------------------------------------------------
local function onUpdate()
    local data = _G.RoleData
    local isLobby = data.IsLobby
    local team = data.TeamName

    -- PRINT STATUS HANYA KALAU BERUBAH
    if lastStatus ~= isLobby then
        lastStatus = isLobby
        if isLobby then
            print("📍 STATUS: LOBBY / SPECTATOR")
        else
            print("📍 STATUS: INGAME | ROLE: " .. team)
        end
    end

    -- LOAD SEMUA FITUR SEKALI SAJA
    if not featuresLoaded then
        featuresLoaded = true
        print("🚀 MEMUAT FITUR ALL ROLE...")
        
        loadstring(game:HttpGet(LINK_BOOSTFPS))
        loadstring(game:HttpGet(LINK_IPADVIEW))
        loadstring(game:HttpGet(LINK_CROSSHAIR))
        loadstring(game:HttpGet(LINK_espPlayer))
    end
end

-- JALANKAN
repeat task.wait() until _G.RoleData and _G.RoleUpdate
_G.RoleUpdate:Connect(onUpdate)
task.wait(0.1)
onUpdate()
