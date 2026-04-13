-- MAIN.LUA - VERSI FINAL 100% AMAN
if _G.__MAIN then return end
_G.__MAIN = true

-- ==============================================
-- DEFINISI FUNGSI GET ROLE SAMA PERSIS
-- ==============================================
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function getRole(plr)
    if plr.Team then
        local n = plr.Team.Name:lower()
        if n:find("killer") then return "KILLER" end
        if n:find("survivor") then return "SURVIVOR" end
    end
    return "UNKNOWN"
end

-- ==============================================
-- TUNGGU SEMUA MODUL SIAP
-- ==============================================
repeat
    task.wait(0.1)
until _G.espPlayer 
and _G.boostFps 
and _G.ipadView 
and _G.crosshair 
and _G.espGene 
and _G.autoGen

task.wait(0.5)

print("====================================")
print("✅ SCRIPT LOAD SELESAI")
print("====================================")

-- ==============================================
-- AMBIL SEMUA FUNGSI
-- ==============================================
local espPlayer = _G.espPlayer
local boostFps = _G.boostFps
local ipadView = _G.ipadView
local crosshair = _G.crosshair
local espGene = _G.espGene
local autoGen = _G.autoGen

local lastRole = nil

-- ==============================================
-- LOOP UPDATE
-- ==============================================
while task.wait(0.5) do
    -- ✅ PANGGIL FUNGSI YANG SUDAH ADA DI SINI
    local myRole = getRole(player)

    -- 🔄 JALANKAN ULANG KETIKA ROLE BERUBAH
    if myRole ~= lastRole then
        print("🎭 ROLE BERUBAH: " .. tostring(myRole))
        
        -- ✅ TAMBAH PROTEKSI IF DULU
        if boostFps then startBoost() end
        if ipadView then applyFOV() end
        if crosshair then crosshair.Start() end
        
        lastRole = myRole
        if myRole ~= "SURVIVOR" and myRole ~= "SPECTATOR" then
            print("Masuk di Fitur Khusus Survi dan Spect")
        else
            print("Role Yang Ditahan")
        end 
    end
end

-- ==============================================
-- JALANKAN FITUR LAIN
-- ==============================================
if espPlayer then espPlayer.Start() end
if espGene then espGene.Start() end
if autoGen then autoGen.Start() end
