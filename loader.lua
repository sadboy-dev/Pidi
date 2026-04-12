local getRoleCode = game:HttpGet("https://raw.githubusercontent.com/sadboy-dev/Pidi/refs/heads/main/modules/getRole.lua")
local getRoleModule = loadstring(getRoleCode)()
local mainCode = game:HttpGet("https://raw.githubusercontent.com/sadboy-dev/Pidi/refs/heads/main/main.lua")
loadstring(mainCode)(getRoleModule)
