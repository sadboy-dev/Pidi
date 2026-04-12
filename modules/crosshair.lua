-- crosshair.lua

print("🎯 CROSSHAIR: ACTIVATED")

local Gui = Instance.new("ScreenGui")
Gui.Name = "CrosshairUI"
Gui.Parent = game:GetService("Players").LocalPlayer.PlayerGui

local dot = Instance.new("Frame")
dot.Size = UDim2.new(0,4,0,4)
dot.Position = UDim2.new(0.5,-2,0.5,-2)
dot.BackgroundColor3 = Color3.new(1,1,1)
dot.BorderSizePixel = 0
dot.Parent = Gui
