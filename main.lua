-- MAIN.LUA
if _G.__MAIN then return end
_G.__MAIN = true

-- TUNGGU SEMUA SIAP
repeat task.wait() until _G.getRole and _G.espPlayer and _G.boostFps and _G.ipadView and _G.crosshair and _G.espGene and _G.autoGen
task.wait(0.5)


print("====================================")
print("✅ SCRIPT LOAD SELESAI")
print("====================================")

local getRole = _G.getRole
local espPlayer = _G.espPlayer
local boostFps = _G.boostFps
local ipadView = _G.ipadView
local crosshair = _G.crosshair
local espGene = _G.espGene
local autoGen = _G.autoGen

local lastRole = nil

local function updateAll()
    local myRole = getRole()

    -- ==============================================
    -- 🔄 JALANKAN ULANG KETIKA ROLE BERUBAH
    -- ==============================================
    if myRole ~= lastRole then
        print("🎭 ROLE BERUBAH: " .. myRole)
        
        boostFps()    -- Jalan ulang
        ipadView()    -- Jalan ulang
        crosshair.Start() -- Jalan ulang
        
        lastRole = myRole
    end
end

-- CEK TERUS MENERUS
while task.wait(0.5) do
    updateAll()
end

-- ESP JALAN SENDIRI
_G.espPlayer.Start()
_G.espPlayer.Start()
_G.espGene.Start()
_G.espPlayer.Start()
_G.espGene.Start()
_G.autoGen.Start()
