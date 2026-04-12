local crosshair = {}

function crosshair.Start()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")

    local player = Players.LocalPlayer
    local PlayerGui = player:WaitForChild("PlayerGui")

    local sgName = "CROSSHAIR"

    local function createCrosshair()
        if PlayerGui:FindFirstChild(sgName) then return end

        local sg = Instance.new("ScreenGui")
        sg.Name = sgName
        sg.ResetOnSpawn = false
        sg.ZIndexBehavior = Enum.ZIndexBehavior.Global
        sg.Parent = PlayerGui

        local dot = Instance.new("Frame")
        dot.Name = "Dot"
        dot.Size = UDim2.new(0, 8, 0, 8)
        dot.Position = UDim2.new(0.5, -4, 0.5, -4)
        dot.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        dot.BorderSizePixel = 0
        dot.Parent = sg

        local outline = Instance.new("UIStroke")
        outline.Thickness = 1
        outline.Color = Color3.new(0,0,0)
        outline.Parent = dot

        print("Crosshair dibuat ulang")
    end

    -- Buat pertama kali
    createCrosshair()

    -- Hanya 1 koneksi RenderStepped (lebih bersih)
    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not PlayerGui:FindFirstChild(sgName) then
            createCrosshair()
        end
    end)

    -- Cleanup kalau module di-restart
    player.CharacterAdded:Connect(function()
        task.wait(0.3)
        createCrosshair()
    end)
end

return crosshair
