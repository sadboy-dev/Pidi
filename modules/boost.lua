-- ==================== AIMBOT VEIL - AUTO AKTIF SAAT DEKAT ====================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- ==================== SETTINGS ====================
local AimbotEnabled = true          -- Ubah ke false jika ingin mati total
local MaxDistance = 30              -- Jarak maksimal agar aimbot aktif (ubah sesuai keinginan, misal 25 atau 40)
local AimPart = "Head"              -- "Head", "HumanoidRootPart", atau "UpperTorso"
local Smoothness = 0.22             -- 0.1 = sangat cepat (snap), 0.35 = lebih smooth/legit
local ToughWall = false             -- true = tembus tembok, false = cek wall
local TargetTeamOpposite = true     -- true = aim ke musuh (tim berbeda)

local Prediction = 0.12             -- Prediksi gerakan musuh (0.08 - 0.18 recommended)

-- Variabel internal
local LockedTarget = nil
local LastTargetPart = nil

-- ==================== FUNGSI UTAMA ====================
local function GetLocalRoot()
    local char = LocalPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function IsValidTarget(plr)
    if plr == LocalPlayer or not plr.Character then return false end
    
    local hum = plr.Character:FindFirstChild("Humanoid")
    if not hum or hum.Health <= 20 then return false end
    
    -- Cek tim (musuh)
    if TargetTeamOpposite and plr.Team == LocalPlayer.Team then return false end
    
    return true
end

local function GetClosestTarget(root)
    local closestPart = nil
    local closestDist = MaxDistance + 1

    for _, plr in ipairs(Players:GetPlayers()) do
        if IsValidTarget(plr) then
            local targetRoot = plr.Character:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                local dist = (root.Position - targetRoot.Position).Magnitude
                if dist < closestDist then
                    local part = plr.Character:FindFirstChild(AimPart) or targetRoot
                    if part then
                        closestDist = dist
                        closestPart = part
                        LockedTarget = plr.Character
                    end
                end
            end
        end
    end
    return closestPart
end

local function CanSeeTarget(targetPart, root)
    if ToughWall then return true end
    if not targetPart or not root then return false end
    
    local ray = Ray.new(root.Position, (targetPart.Position - root.Position).Unit * (targetPart.Position - root.Position).Magnitude)
    local hit, _ = Workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, LockedTarget})
    
    return hit == nil or hit:IsDescendantOf(LockedTarget)
end

local function AimAt(targetPart)
    if not targetPart then return end
    
    local root = GetLocalRoot()
    if not root then return end

    -- Prediction
    local predictedPos = targetPart.Position
    if targetPart.Velocity then
        predictedPos = predictedPos + (targetPart.Velocity * Prediction)
    end

    -- Pitch adjustment sederhana (mirip script asli)
    local distance = (root.Position - predictedPos).Magnitude
    local extraPitch = 0
    if distance > 25 then extraPitch = 8
    elseif distance > 15 then extraPitch = 5 end

    local targetCFrame = CFrame.new(Camera.CFrame.Position, predictedPos + Vector3.new(0, extraPitch, 0))

    -- Smooth aim
    Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, Smoothness)
end

-- ==================== MAIN LOOP ====================
RunService.RenderStepped:Connect(function()
    if not AimbotEnabled then 
        LockedTarget = nil
        return 
    end

    local root = GetLocalRoot()
    if not root then 
        LockedTarget = nil
        return 
    end

    -- Cek apakah masih ada target dekat
    local currentTargetPart = nil
    if LockedTarget and LockedTarget:FindFirstChild(AimPart) then
        local dist = (root.Position - LockedTarget.HumanoidRootPart.Position).Magnitude
        if dist <= MaxDistance and LockedTarget.Humanoid.Health > 20 then
            currentTargetPart = LockedTarget:FindFirstChild(AimPart)
        end
    end

    -- Jika tidak ada target valid, cari yang terdekat
    if not currentTargetPart then
        currentTargetPart = GetClosestTarget(root)
    end

    -- Aim hanya jika target valid dan tidak ada wall (jika ToughWall off)
    if currentTargetPart and CanSeeTarget(currentTargetPart, root) then
        AimAt(currentTargetPart)
        LastTargetPart = currentTargetPart
    else
        LockedTarget = nil
    end
end)

print("Aimbot Veil Auto-Dekat telah aktif! (Max Distance:", MaxDistance, "studs)")
