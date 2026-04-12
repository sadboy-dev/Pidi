local esp = {}

function esp.Start()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer

    --------------------------------------------------
    -- APPLY ESP
    --------------------------------------------------
    local function applyESP(char)
        if not char then return end

        local old = char:FindFirstChild("ESP")
        if old then old:Destroy() end

        local h = Instance.new("Highlight")
        h.Name = "ESP"
        h.FillTransparency = 0.5
        h.OutlineTransparency = 0
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Parent = char
    end

    local function setup(plr)
        if plr == player then return end

        if plr.Character then
            applyESP(plr.Character)
        end

        plr.CharacterAdded:Connect(function(char)
            task.wait(0.2)
            applyESP(char)
        end)
    end

    for _,p in pairs(Players:GetPlayers()) do
        setup(p)
    end
    Players.PlayerAdded:Connect(setup)

    --------------------------------------------------
    -- UPDATE WARNA
    --------------------------------------------------
    RunService.RenderStepped:Connect(function()
        for _,p in pairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                local h = p.Character:FindFirstChild("ESP")
                if h then
                    local role = "UNKNOWN"

                    if p.Team then
                        local n = p.Team.Name:lower()
                        if n:find("killer") then
                            role = "KILLER"
                        elseif n:find("survivor") then
                            role = "SURVIVOR"
                        end
                    end

                    if role == "KILLER" then
                        h.FillColor = Color3.fromRGB(255,0,0)
                    elseif role == "SURVIVOR" then
                        h.FillColor = Color3.fromRGB(0,170,255)
                    else
                        h.FillColor = Color3.fromRGB(255,255,255)
                    end
                end
            end
        end
    end)
end

return esp
