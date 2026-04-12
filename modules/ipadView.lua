-- ipadView.lua

local Camera = workspace.CurrentCamera
print("📱 IPAD VIEW: ACTIVATED")

pcall(function()
    Camera.FieldOfView = 100
end)
