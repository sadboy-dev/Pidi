local crosshair = {}

function crosshair.Start()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local sgName = "CROSSHAIR"

    local function createCrosshair()
        local PlayerGui = player:WaitForChild("PlayerGui", 5)
        if not PlayerGui or PlayerGui:FindFirstChild(sgName) then return end

        local sg = Instance.new("ScreenGui")
        sg.Name = sgName
        sg.ResetOnSpawn = false
        sg.ZIndexBehavior = Enum.ZIndexBehavior.Global
        sg.Parent = PlayerGui

        local dot = Instance.new("Frame")
        dot.Name = "Dot"
        dot.Size = UDim2.new(0, 7, 0, 7)
        dot.Position = UDim2.new(0.5, -3.5, 0.5, -18)   -- -18 agar lebih ke atas (dada player)
        dot.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
        dot.BorderSizePixel = 0
        dot.Parent = sg

        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.new(0,0,0)
        stroke.Thickness = 1.8
        stroke.Parent = dot

        print("Crosshair dibuat - posisi sudah disesuaikan")
    end

    createCrosshair()

    -- Recreate otomatis
    player:WaitForChild("PlayerGui").ChildRemoved:Connect(function(child)
        if child.Name == sgName then
            task.wait(0.2)
            createCrosshair()
        end
    end)

    task.spawn(function()
        while true do
            task.wait(1.5)
            createCrosshair()
        end
    end)

    player.CharacterAdded:Connect(function()
        task.wait(0.6)
        createCrosshair()
    end)
end

return crosshair
