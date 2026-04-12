-- MAIN.LUA
if _G.__MAIN then return end
_G.__MAIN = true

-- VARIABEL PENGAMAN
local lastStatus = nil
local featuresLoaded = false

local LINK_BOOSTFPS = "https://raw.githubusercontent.com/sadboy-dev/Pidi/main/modules/boostFps"
local LINK_IPADVIEW = "https://raw.githubusercontent.com/sadboy-dev/Pidi/main/modules/ipadView"
local LINK_CROSSHAIR = "https://raw.githubusercontent.com/sadboy-dev/Pidi/main/modules/crosshair.lua"
local LINK_ESPPLAYER = "https://raw.githubusercontent.com/sadboy-dev/Pidi/main/modules/espPlayer.lua"

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
        
        -- KITA COBA DOWNLOAD, KALAU ERROR DILEWATI
        local function safeLoad(link, name)
            local success, err = pcall(function()
                loadstring(game:HttpGet(link))()
            end)
            if not success then
                print("⚠️  Gagal load: " .. name .. " (Link mati/404)")
            end
        end

        safeLoad(LINK_BOOSTFPS, "Boost FPS")
        safeLoad(LINK_IPADVIEW, "iPad View")
        safeLoad(LINK_CROSSHAIR, "Crosshair")
        safeLoad(LINK_ESPPLAYER, "ESP Player")
    end
end

-- JALANKAN
repeat task.wait() until _G.RoleData and _G.RoleUpdate
_G.RoleUpdate:Connect(onUpdate)
task.wait(0.1)
