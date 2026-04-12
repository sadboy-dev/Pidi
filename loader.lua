-- LOADER GITHUB
-- GANTI LINK INI DENGAN LINK RAW KAMU

local BaseURL = "https://raw.githubusercontent.com/sadboy-dev/Pidi/refs/heads/main"

-- Fungsi bantu
local function getLink(path)
    return BaseURL .. path
end

-- Buat struktur folder
local modules = Instance.new("Folder")
modules.Name = "modules"
modules.Parent = script

-- Load & Masukkan getRole.lua ke Folder
local getRoleSrc = game:HttpGet(getLink("/modules/getRole.lua"))
local getRoleMod = Instance.new("ModuleScript")
getRoleMod.Name = "getRole"
getRoleMod.Source = getRoleSrc
getRoleMod.Parent = modules

-- Load & Jalankan main.lua
local mainSrc = game:HttpGet(getLink("/main.lua"))
local mainFunc = loadstring(mainSrc)

if mainFunc then
    mainFunc()
else
    warn("❌ GAGAL LOAD MAIN.LUA - CEK LINK ATAU ISI CODE")
end
