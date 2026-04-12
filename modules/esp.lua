local module = {}

function module.Start()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer

    --------------------------------------------------
    -- 🎭 DETECT ROLE PLAYER LAIN
    --------------------------------------------------
    local function getRole(plr)
        if plr.Team then
            local name = plr.Team.Name:lower()

            if name:find("killer") then
                return "KILLER"
            elseif name:find("survivor") then
                return "SURVIVOR"
            end
        end

        return "UNKNOWN" -- spectator / lobby
    end

    --------------------------------------------------
    -- ✨ APPLY ESP KE CHARACTER
    --------------------------------------------------
    local function applyESP(char)
        if not char then return end

        -- hapus lama biar gak numpuk
        local old = char:FindFirstChild("ESP")
        if old then old:Destroy() end

        local h = Instance.new("Highlight")
        h.Name = "ESP"
        h.FillTransparency = 0.5
        h.OutlineTransparency = 0
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Parent = char
    end

    --------------------------------------------------
    -- 🔁 SETUP PLAYER
    --------------------------------------------------
    local function setupPlayer(plr)
        if plr == player then return end

        -- kalau sudah ada character
        if plr.Character then
            applyESP(plr.Character)
        end

        -- kalau respawn
        plr.CharacterAdded:Connect(function(char)
            task.wait(0.2)
            applyESP(char)
        end)
    end

    -- apply ke semua player yang sudah ada
    for _,plr in pairs(Players:GetPlayers()) do
        setupPlayer(plr)
    end

    -- player baru join
    Players.PlayerAdded:Connect(setupPlayer)

    --------------------------------------------------
    -- 🎨 UPDATE WARNA REALTIME (RINGAN)
    --------------------------------------------------
    RunService.RenderStepped:Connect(function()
        for _,plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                local h = plr.Character:FindFirstChild("ESP")
                if h then
                    local role = getRole(plr)

                    if role == "KILLER" then
                        h.FillColor = Color3.fromRGB(255, 0, 0) -- 🔴 merah
                    elseif role == "SURVIVOR" then
                        h.FillColor = Color3.fromRGB(0, 170, 255) -- 🔵 biru
                    else
                        h.FillColor = Color3.fromRGB(255, 255, 255) -- ⚪ putih (spectator/lobby)
                    end
                end
            end
        end
    end)
end

return module
