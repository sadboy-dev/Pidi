-- ANTI DOUBLE RUN
if _G.__LOADER_FINAL then return end
_G.__LOADER_FINAL = true

--------------------------------------------------
-- SERVICES
--------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--------------------------------------------------
-- SAFE LOADSTRING
--------------------------------------------------
local function loadModule(url, name)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)

    if success and result then
        print("✅ Loaded:", name)
        return result
    else
        warn("❌ Failed load:", name)
        return nil
    end
end

--------------------------------------------------
-- LOAD MODULES
--------------------------------------------------
local Modules = {}

Modules.ESP = loadModule(
    "https://raw.githubusercontent.com/sadboy-dev/Pidi/refs/heads/main/modules/esp.lua",
    "ESP"
)

Modules.Generator = loadModule(
    "https://raw.githubusercontent.com/sadboy-dev/Pidi/refs/heads/main/modules/generator.lua",
    "Generator ESP"
)

Modules.Aimbot = loadModule(
    "https://raw.githubusercontent.com/sadboy-dev/Pidi/refs/heads/main/modules/aimbot.lua",
    "Aimbot"
)

Modules.AutoGene = loadModule(
    "https://raw.githubusercontent.com/sadboy-dev/Pidi/refs/heads/main/modules/autogene.lua",
    "Auto Generator"
)

Modules.Boost = loadModule(
    "https://raw.githubusercontent.com/sadboy-dev/Pidi/refs/heads/main/modules/boost.lua",
    "Boost FPS"
)

Modules.Crosshair = loadModule(
    "https://raw.githubusercontent.com/sadboy-dev/Pidi/refs/heads/main/modules/crosshair.lua",
    "Crosshair"
)

--------------------------------------------------
-- ROLE SYSTEM (RINGAN - SESUAI REQUEST)
--------------------------------------------------
local ROLE = "UNKNOWN"

local function getRole()
    if player.Team then
        local n = player.Team.Name:lower()
        if n:find("killer") then return "KILLER" end
        if n:find("survivor") then return "SURVIVOR" end
    end
    return "UNKNOWN"
end

local function updateRole()
    ROLE = getRole()
    print("🎭 ROLE:", ROLE)
end

--------------------------------------------------
-- FOV
--------------------------------------------------
local function applyFOV()
    if Camera then
        Camera.FieldOfView = 100
    end
end

--------------------------------------------------
-- START FEATURES
--------------------------------------------------
local function startAll()
    updateRole()
    applyFOV()

    if Modules.Boost and Modules.Boost.Start then
        Modules.Boost.Start()
    end

    if Modules.ESP and Modules.ESP.Start then
        Modules.ESP.Start()
    end

    if Modules.Generator and Modules.Generator.Start then
        Modules.Generator.Start()
    end

    if Modules.Crosshair and Modules.Crosshair.Start then
        Modules.Crosshair.Start()
    end

    if Modules.AutoGene and Modules.AutoGene.Start then
        Modules.AutoGene.Start(function()
            return ROLE
        end)
    end

    if Modules.Aimbot and Modules.Aimbot.Start then
        Modules.Aimbot.Start(function()
            return ROLE
        end)
    end
end

--------------------------------------------------
-- RESPAWN / ROLE CHANGE
--------------------------------------------------
player.CharacterAdded:Connect(function()
    task.wait(0.5)

    updateRole()
    applyFOV()

    if Modules.Boost and Modules.Boost.Start then
        Modules.Boost.Start()
    end

    if Modules.Aimbot and Modules.Aimbot.Start then
        Modules.Aimbot.Start(function()
            return ROLE
        end)
    end

    if Modules.Crosshair and Modules.Crosshair.Start then
        Modules.Crosshair.Start()
    end
end)

--------------------------------------------------
-- START
--------------------------------------------------
startAll()

print("🔥 LOADER FINAL FIX ACTIVE 🔥")
