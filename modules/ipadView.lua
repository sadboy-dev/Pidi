-- ipadView.lua - FOV 100 STABIL
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local IPAD_FOV = 100 -- ✅ Nilai FOV yang kamu mau

local function applyFOV()
    if workspace.CurrentCamera then
        workspace.CurrentCamera.FieldOfView = IPAD_FOV
        print("📱 IPAD VIEW: FOV = " .. IPAD_FOV)
    end
end

-- ==============================================
-- LOOP PASTIKAN FOV TETAP
-- ==============================================
RunService.RenderStepped:Connect(function()
    if workspace.CurrentCamera and workspace.CurrentCamera.FieldOfView ~= IPAD_FOV then
        workspace.CurrentCamera.FieldOfView = IPAD_FOV
    end
end)

-- ==============================================
-- APPLY KETIKA SPAWN
-- ==============================================
player.CharacterAdded:Connect(function()
    task.wait(0.5)
    applyFOV()
end)

-- ==============================================
-- SIMPAN KE GLOBAL (BISA DIPANGGIL ULANG)
-- ==============================================
local function startBoost()
    applyFOV()
end

_G.ipadView = startBoost
return startBoost
