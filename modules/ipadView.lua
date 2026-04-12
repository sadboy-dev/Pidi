-- ipadView.lua
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera

local function setIpad()
    print("📱 IPAD VIEW DIAKTIFKAN")
    Camera.FieldOfView = 70 -- Atau 80 kalau mau lebih luas
    Camera.MaxZoomDistance = 100
end

-- Jalankan langsung saat load
setIpad()

-- Simpan ke Global
_G.ipadView = setIpad

return setIpad
