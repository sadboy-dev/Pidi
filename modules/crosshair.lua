local module = {}

function module.Start()
    local player = game:GetService("Players").LocalPlayer

    local function create()
        local gui = player:WaitForChild("PlayerGui")

        if gui:FindFirstChild("CROSSHAIR") then return end

        local sg = Instance.new("ScreenGui")
        sg.Name = "CROSSHAIR"
        sg.ResetOnSpawn = false
        sg.Parent = gui

        local dot = Instance.new("Frame")
        dot.Size = UDim2.new(0,6,0,6)
        dot.Position = UDim2.new(0.5,-3,0.5,-3)
        dot.BackgroundColor3 = Color3.fromRGB(0,170,255)
        dot.BorderSizePixel = 0
        dot.Parent = sg
    end

    -- buat pertama kali
    create()

    -- auto recreate kalau hilang
    game:GetService("RunService").RenderStepped:Connect(function()
        local gui = player:FindFirstChild("PlayerGui")
        if gui and not gui:FindFirstChild("CROSSHAIR") then
            create()
        end
    end)
end

return module
