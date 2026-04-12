-- modules/ipadView.lua

local Camera = nil
local defaultFOV = 100

local function On()
    if workspace.CurrentCamera then
        workspace.CurrentCamera.FieldOfView = IPAD_FOV
    end
end

RunService.RenderStepped:Connect(function()
    if workspace.CurrentCamera and workspace.CurrentCamera.FieldOfView ~= IPAD_FOV then
        workspace.CurrentCamera.FieldOfView = IPAD_FOV
    end
end)
