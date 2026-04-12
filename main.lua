-- main.lua

if _G.__ULTRA_LOADED then return end
_G.__ULTRA_LOADED = true

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ================= LOAD MODULE =================
local Modules = {}

Modules.ESP = loadstring(game:HttpGet("https://yourdomain.com/modules/esp.lua"))()
Modules.Generator = loadstring(game:HttpGet("https://yourdomain.com/modules/generator.lua"))()
Modules.Aimbot = loadstring(game:HttpGet("https://yourdomain.com/modules/aimbot.lua"))()
Modules.AutoGene = loadstring(game:HttpGet("https://yourdomain.com/modules/autogene.lua"))()
Modules.Boost = loadstring(game:HttpGet("https://yourdomain.com/modules/boost.lua"))()
Modules.Crosshair = loadstring(game:HttpGet("https://yourdomain.com/modules/crosshair.lua"))()

-- ================= ROLE =================
local function getRole()
    if player.Team then
        local n = player.Team.Name:lower()
        if n:find("killer") then return "KILLER" end
        if n:find("survivor") then return "SURVIVOR" end
    end
    return "UNKNOWN"
end

-- ================= INIT =================
local function start()
    local role = getRole()

    Modules.Boost.Start()
    Modules.ESP.Start(role)
    Modules.Generator.Start()
    Modules.Crosshair.Start()

    if role == "SURVIVOR" then
        Modules.AutoGene.Start()
        Modules.Aimbot.Start(role)
    elseif role == "KILLER" then
        Modules.Aimbot.Start(role)
    end
end

-- ================= SPAWN DETECT =================
player.CharacterAdded:Connect(function()
    task.wait(0.5)
    start()
end)

start()
