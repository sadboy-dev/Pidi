-- modules/ipadView.lua

local Camera = workspace.CurrentCamera
local defaultFOV = Camera.FieldOfView

local function on()
    Camera.FieldOfView = 100
    print("📱 iPad View: ON")
end

local function off()
    Camera.FieldOfView = defaultFOV
    print("📱 iPad View: OFF")
end

return {
    On = on,
    Off = off
}
