local crosshair = {}

function crosshair.Start()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer

    local sgName = "CROSSHAIR"

    local function createCrosshair()
        local PlayerGui = player:WaitForChild("PlayerGui", 5)
        if not PlayerGui then return end

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
        dot.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
        dot.BorderSizePixel = 0
        dot.Parent = sg

        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.new(0,0,0)
        stroke.Thickness = 1.5
        stroke.Parent = dot

        print("Crosshair berhasil dibuat ulang")
    end

    -- Buat pertama kali
    createCrosshair()

    -- Recreate lebih efisien (pakai Heartbeat + ChildRemoved)
    player:WaitForChild("PlayerGui").ChildRemoved:Connect(function(child)
        if child.Name == sgName then
            task.wait(0.1)
            createCrosshair()
        end
    end)

    -- Fallback setiap 2 detik (aman untuk in-game transition)
    task.spawn(function()
        while true do
            task.wait(2)
            createCrosshair()
        end
    end)

    -- Saat respawn
    player.CharacterAdded:Connect(function()
        task.wait(0.8)
        createCrosshair()
    end)
end

return crosshair
