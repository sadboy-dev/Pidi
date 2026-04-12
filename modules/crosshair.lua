local crosshair = {}

function crosshair.Start()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")

    local player = Players.LocalPlayer

    local function create()
        local gui = player:WaitForChild("PlayerGui")
        if gui:FindFirstChild("CROSSHAIR") then return end

        local sg = Instance.new("ScreenGui")
        sg.Name = "CROSSHAIR"
        sg.ResetOnSpawn = false -- Biar gak ilang pas respawn
        sg.Parent = gui

        local dot = Instance.new("Frame")
        dot.Size = UDim2.new(0, 6, 0, 6)
        dot.Position = UDim2.new(0.5, -3, 0.5, -3) -- Tepat di tengah
        dot.BackgroundColor3 = Color3.fromRGB(0, 170, 255) -- Warna biru
        dot.BorderSizePixel = 0
        dot.Parent = sg
    end

    -- Buat pertama kali jalan
    create()

    -- Auto bikin ulang kalau hilang
    RunService.RenderStepped:Connect(function()
        local gui = player:FindFirstChild("PlayerGui")
        if gui and not gui:FindFirstChild("CROSSHAIR") then
            create()
        end
    end)
end

return crosshair
