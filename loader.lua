local LINK_GETROLE = "https://raw.githubusercontent.com/sadboy-dev/Pidi/main/modules/getRole.lua"
local LINK_MAIN = "https://raw.githubusercontent.com/sadboy-dev/Pidi/main/main.lua"

-- JALANKAN
print("🔄 DOWNLOADING...")
local modFunc = loadstring(game:HttpGet(LINK_GETROLE))()
local mainFunc = loadstring(game:HttpGet(LINK_MAIN))()

print("🚀 DONE!")
