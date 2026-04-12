-- main.lua

if _G.__MAIN then return end
_G.__MAIN = true

-- VARIABEL PENGAMAN
local lastStatus = nil
local featuresLoaded = false

-- BASE URL (SAMA DENGAN DI LOADER)
local BASE_URL = "https://raw.githubusercontent.com/sadboy-dev/Pidi/main/modules"

-- FUNGSI MEMANGGIL FILE
local function loadScript(name)
    local link = BASE_URL .. "/" .. name .. ".lua"
    local code = game:HttpGet(link)
    local func = loadstring(code)
    if func then
        func()
        print("✅ LOADED: " .. name)
    else
        warn("❌ GAGAL LOAD: " .. name)
    end
end

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
        
        loadScript("boostFps.lua")
        loadScript("ipadView")
        loadScript("crosshair")
        loadScript("espPlayer")
    end
end

-- JALANKAN
repeat task.wait() until _G.RoleData and _G.RoleUpdate
_G.RoleUpdate:Connect(onUpdate)
task.wait(0.1)
onUpdate()
