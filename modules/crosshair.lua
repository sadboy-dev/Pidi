-- crosshair.lua - VERSI KUNING PASTI MUNCUL
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Hapus crosshair lama kalau ada
local OldGui = game:GetService("CoreGui"):FindFirstChild("Crosshair_Yellow")
if OldGui then OldGui:Destroy() end

-- ==============================================
-- BUAT CROSSHAIR BARU
-- ==============================================
local Gui = Instance.new("ScreenGui")
Gui.Name = "Crosshair_Yellow"
Gui.Parent = game:GetService("CoreGui")

local Dot = Instance.new("Frame")
Dot.Name = "Dot"
Dot.Size = UDim2.new(0, 6, 0, 6) -- UKURAN BESAR SEDIKIT
Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 0) -- 💛 KUNING
Dot.BorderSizePixel = 0
Dot.AnchorPoint = Vector2.new(0.5, 0.5)
Dot.Position = UDim2.new(0.5, 0, 0.5, 0)
Dot.Parent = Gui

-- ==============================================
-- LOOP POSISI (DADA / AGAK NAIK)
-- ==============================================
RunService.RenderStepped:Connect(function()
    local Closest = nil
    local Distance = 100 -- Jarak maksimal deteksi

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local Humanoid = v.Character:FindFirstChildOfClass("Humanoid")
            if Humanoid and Humanoid.Health > 0 then
                -- ✅ POSISI: DADA (+ Vector3.new(0, 1, 0))
                local Pos, OnScreen = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position + Vector3.new(0, 1, 0))
                
                if OnScreen then
                    local Dist = (Vector2.new(Pos.X, Pos.Y) - Vector2.new(0.5, 0.5)).Magnitude
                    if Dist < Distance then
                        Distance = Dist
                        Closest = Vector2.new(Pos.X, Pos.Y)
                    end
                end
            end
        end
    end

    -- Gerakin titik
    if Closest then
        Dot.Position = UDim2.new(0, Closest.X * Camera.ViewportSize.X, 0, Closest.Y * Camera.ViewportSize.Y)
    else
        -- Balik ke tengah layar kalau gak ada musuh
        Dot.Position = UDim2.new(0.5, 0, 0.5, 0)
    end
end)

-- ==============================================
-- SIMPAN KE GLOBAL
-- ==============================================
_G.crosshair = {}
function _G.crosshair.Start()
    Gui.Enabled = true
    print("💛 CROSSHAIR AKTIF (POSISI DADA)")
end
function _G.crosshair.Stop()
    Gui.Enabled = false
end

return _G.crosshair
