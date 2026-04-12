local module = {}

function module.Start(role)
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    for _,p in pairs(Players:GetPlayers()) do
        if p ~= player then
            p.CharacterAdded:Connect(function(char)
                task.wait(0.3)

                local h = Instance.new("Highlight")
                h.FillTransparency = 0.5
                h.Parent = char
            end)
        end
    end

    game:GetService("RunService").RenderStepped:Connect(function()
        for _,p in pairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                local h = p.Character:FindFirstChildOfClass("Highlight")
                if h then
                    local r = "UNKNOWN"

                    if p.Team then
                        local n = p.Team.Name:lower()
                        if n:find("killer") then r = "KILLER"
                        elseif n:find("survivor") then r = "SURVIVOR" end
                    end

                    if r == "KILLER" then
                        h.FillColor = Color3.fromRGB(255,0,0)
                    elseif r == "SURVIVOR" then
                        h.FillColor = Color3.fromRGB(0,170,255)
                    else
                        h.FillColor = Color3.fromRGB(255,255,255)
                    end
                end
            end
        end
    end)
end

return module
