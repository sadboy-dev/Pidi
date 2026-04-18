local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local getRole = _G.getRole

-- ==============================================
-- SETUP ESP
-- ==============================================
local function setupESP(char)
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

local function removeESP(char)
    if char then
        local h = char:FindFirstChild("ESP")
        if h then h:Destroy() end
    end
end

-- ==============================================
-- APPLY KE PLAYER
-- ==============================================
local function handlePlayer(plr)
    if plr == player then return end

    if plr.Character then
        setupESP(plr.Character)
    end

    plr.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        if _G.FeatureState.espPlayer then
            setupESP(char)
        end
    end)
end

-- ==============================================
-- LOOP UPDATE WARNA (PAKAI TOGGLE)
-- ==============================================
RunService.RenderStepped:Connect(function()
    if not (_G.FeatureState and _G.FeatureState.espPlayer) then return end

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local h = plr.Character:FindFirstChild("ESP")
            if h then
                local role = getRole(plr)

                if role == "KILLER" then
                    h.FillColor = Color3.fromRGB(255, 0, 0)
                elseif role == "SURVIVOR" then
                    h.FillColor = Color3.fromRGB(0, 170, 255)
                else
                    h.FillColor = Color3.fromRGB(255, 255, 255)
                end
            end
        end
    end
end)

-- ==============================================
-- START / STOP
-- ==============================================
local function startESP()
    _G.FeatureState.espPlayer = true

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            if plr.Character then
                setupESP(plr.Character)
            end
        end
    end

    print("✅ ESP ON")
end

local function stopESP()
    _G.FeatureState.espPlayer = false

    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character then
            removeESP(plr.Character)
        end
    end

    print("❌ ESP OFF")
end

-- ==============================================
-- INIT PLAYER LISTENER
-- ==============================================
for _, p in pairs(Players:GetPlayers()) do
    handlePlayer(p)
end

Players.PlayerAdded:Connect(handlePlayer)

-- ==============================================
-- GLOBAL
-- ==============================================
_G.espPlayer = {}
_G.espPlayer.Start = startESP
_G.espPlayer.Stop = stopESP

return _G.espPlayer
