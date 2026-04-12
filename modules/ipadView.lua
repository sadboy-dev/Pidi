-- modules/ipadView.lua

local Camera = nil
local defaultFOV = 70

local function On()
    -- Ambil kamera pas dijalankan
    Camera = workspace.CurrentCamera
    if not Camera then return end

    -- Simpan FOV asli
    pcall(function()
        defaultFOV = Camera.FieldOfView
    end)

    -- Set ke iPad View
    pcall(function()
        Camera.FieldOfView = 100
        print("📱 iPad View: ON")
    end)
end

local function Off()
    if not Camera then return end

    pcall(function()
        Camera.FieldOfView = defaultFOV
        print("📱 iPad View: OFF")
    end)
end

return {
    On = On,
    Off = Off
}
