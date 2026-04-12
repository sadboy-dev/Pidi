local GITHUB = "https://raw.githubusercontent.com/sadboy-dev/Pidi/main"

-- FUNGSI DOWNLOAD & BUAT FILE
local function loadFile(path, name, parent)
    local code = game:HttpGet(GITHUB .. path)
    local mod = Instance.new("ModuleScript")
    mod.Name = name
    mod.Source = code
    mod.Parent = parent
    return mod
end

-- 1. BUAT FOLDER MODULES
local folderMod = Instance.new("Folder")
folderMod.Name = "modules"
folderMod.Parent = script
print("📂 Folder modules dibuat")

-- 2. DOWNLOAD SEMUA FILE MODULES
loadFile("/modules/getRole.lua", "getRole", folderMod)
loadFile("/modules/ipadView.lua", "ipadView", folderMod)
loadFile("/modules/crosshair.lua", "crosshair", folderMod)
loadFile("/modules/espPlayer.lua", "espPlayer", folderMod)
print("✅ Semua module terdownload")

-- 3. DOWNLOAD & JALANKAN MAIN.LUA
local mainCode = game:HttpGet(GITHUB .. "/main.lua")
local mainFunc = loadstring(mainCode)

if mainFunc then
    mainFunc()
    print("🚀 SCRIPT BERHASIL Dijalankan!")
else
    error("❌ GAGAL LOAD MAIN.LUA")
end
