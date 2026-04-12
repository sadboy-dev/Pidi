-- MAIN.LUA - VERSI FINAL 100% AMAN
if _G.__MAIN then return end
_G.__MAIN = true

-- ==============================================
-- TUNGGU SEMUA MODUL SIAP
-- ==============================================
repeat
    task.wait(0.1)
until _G.getRole 
and _G.espPlayer 
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
local getRole = _G.getRole
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
    -- ✅ PANGGIL TANPA PARAMETER (getRole())
    local myRole = getRole()

    -- 🔄 JALANKAN ULANG KETIKA ROLE BERUBAH
    if myRole ~= lastRole then
        print("🎭 ROLE BERUBAH: " .. tostring(myRole))
        
        if boostFps then boostFps() end
        if ipadView then ipadView() end
        if crosshair then crosshair.Start() end
        
        lastRole = myRole
    end
end

-- ==============================================
-- JALANKAN FITUR LAIN
-- ==============================================
if espPlayer then espPlayer.Start() end
if espGene then espGene.Start() end
if autoGen then autoGen.Start() end
