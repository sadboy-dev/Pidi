-- modules/ipadView.lua

local Camera = workspace.CurrentCamera
local defaultFOV = 70 -- Nilai standar kalau gagal baca

-- Coba ambil FOV asli kalau bisa
pcall(function()
    defaultFOV = Camera.FieldOfView
end)

local function On()
    pcall(function()
        Camera.FieldOfView = 100
        print("📱 iPad View: ON")
    end)
end

local function Off()
    pcall(function()
        Camera.FieldOfView = defaultFOV
        print("📱 iPad View: OFF")
    end)
end

return {
    On = On,
    Off = Off
}
