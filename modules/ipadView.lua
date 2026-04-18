local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local IPAD_FOV = 100

local function applyFOV()
    if workspace.CurrentCamera then
        workspace.CurrentCamera.FieldOfView = IPAD_FOV
        print("📱 IPAD VIEW: FOV = " .. IPAD_FOV)
    end
end

-- LOOP DENGAN CEK TOGGLE
RunService.RenderStepped:Connect(function()
    if _G.FeatureState and _G.FeatureState.ipadView then
        if workspace.CurrentCamera and workspace.CurrentCamera.FieldOfView ~= IPAD_FOV then
            workspace.CurrentCamera.FieldOfView = IPAD_FOV
        end
    end
end)

-- APPLY SAAT SPAWN (HANYA JIKA ON)
player.CharacterAdded:Connect(function()
    task.wait(0.5)
    if _G.FeatureState and _G.FeatureState.ipadView then
        applyFOV()
    end
end)

-- FUNCTION GLOBAL
local function startBoost()
    _G.FeatureState.ipadView = true
    applyFOV()
end

local function stopBoost()
    _G.FeatureState.ipadView = false
    print("📱 IPAD VIEW: OFF")
end

_G.ipadView = startBoost
_G.stopIpadView = stopBoost

return startBoost
