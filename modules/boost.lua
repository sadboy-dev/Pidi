-- ==================== AIMBOT VEIL - MOBILE VERSION ====================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Settings
local AimbotEnabled = false
local ToughWall = false          -- Aim through wall
local Smoothness = 0.25          -- Semakin kecil = semakin cepat snap (0.1 - 0.4 recommended)
local AuraRange = 400            -- Jarak maksimal
local TargetType = "Killer"      -- "Killer" atau "Survivor"
local AimPart = "Head"           -- "Head", "Torso", "HumanoidRootPart"

local LockedTarget = nil

-- Fungsi dapatkan target terdekat
local function GetClosestTarget()
    local closest = nil
    local shortestDist = AuraRange

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local hum = plr.Character:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 then
                local isKiller = plr.Team ~= LocalPlayer.Team  -- Sesuaikan logic team jika game punya team berbeda
                if (TargetType == "Killer" and isKiller) or (TargetType == "Survivor" and not isKiller) then
                    local part = plr.Character:FindFirstChild(AimPart) or plr.Character:FindFirstChild("HumanoidRootPart")
                    if part then
                        local dist = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and 
                                     (LocalPlayer.Character.HumanoidRootPart.Position - part.Position).Magnitude) or math.huge

                        if dist < shortestDist then
                            -- Cek wall (jika ToughWall off)
                            if ToughWall or true then  -- Ganti dengan raycast jika ingin akurat
                                shortestDist = dist
                                closest = part
                            end
                        end
                    end
                end
            end
        end
    end
    return closest
end

-- Fungsi utama aiming (Camera CFrame)
local function AimAt(targetPart)
    if not targetPart then return end

    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    -- Prediction sederhana (bisa ditambah velocity jika mau lebih akurat)
    local predictedPos = targetPart.Position -- + (targetPart.Velocity * 0.1)

    -- Pitch adjustment berdasarkan jarak (seperti di script asli)
    local distance = (root.Position - predictedPos).Magnitude
    local extraPitch = 0
    if distance >= 190 then extraPitch = 15
    elseif distance >= 150 then extraPitch = 10
    elseif distance >= 90 then extraPitch = 5 end

    local targetCFrame = CFrame.new(Camera.CFrame.Position, predictedPos + Vector3.new(0, extraPitch, 0))

    -- Smooth aiming
    Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, Smoothness)
end

-- Main Loop (RenderStepped = smooth di semua platform termasuk mobile)
RunService.RenderStepped:Connect(function()
    if not AimbotEnabled then 
        LockedTarget = nil
        return 
    end

    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    -- Auto lock target terdekat
    if not LockedTarget or not LockedTarget.Parent or LockedTarget.Parent:FindFirstChild("Humanoid").Health <= 0 then
        LockedTarget = GetClosestTarget()
    end

    if LockedTarget then
        AimAt(LockedTarget)
    end
end)

-- ==================== MOBILE TOGGLE BUTTON ====================
local gui = Instance.new("ScreenGui")
gui.Name = "MobileAimbotGUI"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 100, 0, 100)
btn.Position = UDim2.new(1, -120, 1, -120)
btn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
btn.Text = "Aimbot\nOFF"
btn.TextColor3 = Color3.new(1,1,1)
btn.TextScaled = true
btn.Font = Enum.Font.GothamBold
btn.ZIndex = 999
btn.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 20)
corner.Parent = btn

btn.MouseButton1Click:Connect(function()
    AimbotEnabled = not AimbotEnabled
    btn.Text = "Aimbot\n" .. (AimbotEnabled and "ON" or "OFF")
    btn.BackgroundColor3 = AimbotEnabled and Color3.fromRGB(60, 255, 60) or Color3.fromRGB(255, 60, 60)
    
    if not AimbotEnabled then
        LockedTarget = nil
    end
end)

-- Drag support untuk tombol (mobile friendly)
local dragging = false
btn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
    end
end)

btn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

RunService.RenderStepped:Connect(function()
    if dragging then
        local mouse = game.Players.LocalPlayer:GetMouse()
        btn.Position = UDim2.new(0, mouse.X - btn.AbsoluteSize.X/2, 0, mouse.Y - btn.AbsoluteSize.Y/2)
    end
end)
