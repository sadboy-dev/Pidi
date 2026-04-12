local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

--------------------------------------------------
-- 👀 FOV
--------------------------------------------------
local IPAD_FOV = 100

local function applyFOV()
    if workspace.CurrentCamera then
        workspace.CurrentCamera.FieldOfView = IPAD_FOV
    end
end

RunService.RenderStepped:Connect(function()
    if workspace.CurrentCamera and workspace.CurrentCamera.FieldOfView ~= IPAD_FOV then
        workspace.CurrentCamera.FieldOfView = IPAD_FOV
    end
end)
