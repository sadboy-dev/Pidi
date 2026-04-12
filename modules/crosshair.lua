local crosshair = {}

function crosshair.Start()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")

    local player = Players.LocalPlayer
    local PlayerGui = player:WaitForChild("PlayerGui")

    local function create()
        if PlayerGui:FindFirstChild("CROSSHAIR") then return end

        local sg = Instance.new("ScreenGui")
        sg.Name = "CROSSHAIR"
        sg.ResetOnSpawn = false -- ❗ PENTING: Biar gak ilang pas respawn
        sg.ZIndexBehavior = Enum.ZIndexBehavior.Global
        sg.Parent = PlayerGui

        local dot = Instance.new("Frame")
        dot.Size = UDim2.new(0, 6, 0, 6)
        dot.Position = UDim2.new(0.5, -3, 0.5, -3)
        dot.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        dot.BorderSizePixel = 0
        dot.Parent = sg
    end

    -- Buat pertama kali
    create()

    -- Auto recreate kalau hilang
    RunService.RenderStepped:Connect(function()
        if not PlayerGui:FindFirstChild("CROSSHAIR") then
            create()
        end
    end)
end

return crosshair
