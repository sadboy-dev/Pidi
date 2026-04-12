local GITHUB = "https://raw.githubusercontent.com/sadboy-dev/Pidi/main"

-- BUAT FOLDER
local modFolder = Instance.new("Folder")
modFolder.Name = "modules"
modFolder.Parent = script

-- DOWNLOAD GETROLE
local getRoleCode = game:HttpGet(GITHUB .. "/modules/getRole.lua")
local getRoleMod = Instance.new("ModuleScript")
getRoleMod.Name = "getRole"
getRoleMod.Source = getRoleCode
getRoleMod.Parent = modFolder

-- DOWNLOAD & JALANKAN MAIN
local mainCode = game:HttpGet(GITHUB .. "/main.lua")
local mainFunc = loadstring(mainCode)

if mainFunc then
    mainFunc()
    print("🚀 DONE!")
else
    error("❌ ERROR LOAD MAIN")
end
