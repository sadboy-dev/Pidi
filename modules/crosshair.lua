-- crosshair.lua - VERSI KUNING & POSISI DADA
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

local crosshair = nil
local connection = nil

local function createCrosshair()
    -- Hapus lama kalau ada
    if crosshair then crosshair:Destroy() end
    
    -- Buat Baru
    crosshair = Instance.new("Frame")
    crosshair.Name = "MyCrosshair"
    crosshair.Size = UDim2.new(0, 4, 0, 4) -- Ukuran titik
    crosshair.BackgroundColor3 = Color3.fromRGB(255, 255, 0) -- 💛 KUNING
    crosshair.BorderSizePixel = 0
    crosshair.Position = UDim2.new(0.5, -2, 0.5, -2) -- Tengah layar
    crosshair.AnchorPoint = Vector2.new(0.5, 0.5)
    crosshair.Parent = game:GetService("CoreGui")
end

local function updatePosition()
    local camera = Workspace.CurrentCamera
    if not camera then return end

    local closestDistance = math.huge
    local targetPos = nil

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local humanoidRootPart = plr.Character:FindFirstChild("HumanoidRootPart")
            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
            
            if humanoidRootPart and humanoid and humanoid.Health > 0 then
                -- ✅ POSISI: DADA / AGAK NAIK DARI TENGAH
                local pos, onScreen = camera:WorldToViewportPoint(humanoidRootPart.Position + Vector3.new(0, 0.5, 0))
                
                if onScreen then
                    local distance = (Vector2.new(pos.X, pos.Y) - Vector2.new(0.5, 0.5)).Magnitude
                    
                    if distance < closestDistance then
                        closestDistance = distance
                        targetPos = Vector2.new(pos.X, pos.Y)
                    end
                end
            end
        end
    end

    -- Gerakin crosshair
    if targetPos and crosshair then
        crosshair.Position = UDim2.new(0, targetPos.X * camera.ViewportSize.X - 2, 0, targetPos.Y * camera.ViewportSize.Y - 2)
    end
end

-- ==============================================
-- FUNGSI START & STOP
-- ==============================================
local function Start()
    print("💛 CROSSHAIR AKTIF - WARNA KUNING")
    createCrosshair()
    
    if connection then connection:Disconnect() end
    connection = RunService.RenderStepped:Connect(updatePosition)
end

local function Stop()
    if crosshair then crosshair:Destroy() end
    if connection then connection:Disconnect() end
end

-- Simpan ke Global
_G.crosshair = {
    Start = Start,
    Stop = Stop
}

return _G.crosshair
