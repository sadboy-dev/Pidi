-- LOADER SIMPLE

local LINK_GETROLE = "https://raw.githubusercontent.com/sadboy-dev/Pidi/main/modules/getRole.lua"
local LINK_MAIN = "https://raw.githubusercontent.com/sadboy-dev/Pidi/main/main.lua"

-- JALANKAN
print("🔄 DOWNLOADING MODULE...")
local moduleCode = game:HttpGet(LINK_GETROLE)
local moduleFunc = loadstring(moduleCode)

if moduleFunc then
    moduleFunc()
    local mainCode = game:HttpGet(LINK_MAIN)
    local mainFunc = loadstring(mainCode)
    if mainFunc then
        mainFunc()
    else
        error("❌ GAGAL LOAD MAIN.LUA")
    end
else
    error("❌ GAGAL LOAD GETROLE.LUA - CEK LINK!")
end
