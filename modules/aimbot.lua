local module = {}

function module.Start(role)
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Camera = workspace.CurrentCamera
    local player = Players.LocalPlayer

    local MaxDist = 30
    local LockDist = 5

    local function validTarget(plr)
        if plr == player or not plr.Character then return false end

        local hum = plr.Character:FindFirstChild("Humanoid")
        if not hum then return false end

        -- ❌ mati / knock
        if hum.Health <= 20 then return false end

        -- ❌ digantung / disable
        if hum.Sit or hum.PlatformStand then return false end

        -- ❌ satu tim
        if plr.Team == player.Team then return false end

        return true
    end

    RunService.RenderStepped:Connect(function()
        if role ~= "KILLER" and role ~= "SURVIVOR" then return end

        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then return end

        local closest, distMin

        for _,p in pairs(Players:GetPlayers()) do
            if validTarget(p) then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local dist = (root.Position - hrp.Position).Magnitude

                    if dist <= MaxDist and (not distMin or dist < distMin) then
                        distMin = dist
                        closest = hrp
                    end
                end
            end
        end

        if closest then
            local cf = CFrame.new(Camera.CFrame.Position, closest.Position)

            if distMin <= LockDist then
                Camera.CFrame = cf
            else
                Camera.CFrame = Camera.CFrame:Lerp(cf, 0.2)
            end
        end
    end)
end

return module
