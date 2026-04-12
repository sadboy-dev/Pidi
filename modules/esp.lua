local module = {}

function module.Start()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer

--------------------------------------------------
-- ✨ ESP PLAYER (FIX DARI SCRIPT KAMU)
--------------------------------------------------
local function applyESP(char)
    if not char then return end

    -- hapus lama biar tidak numpuk
    local old = char:FindFirstChild("ESP")
    if old then old:Destroy() end

    local h = Instance.new("Highlight")
    h.Name = "ESP"
    h.FillTransparency = 0.5
    h.OutlineTransparency = 0
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = char
end

local function setupESP(plr)
    if plr == player then return end

    -- kalau character sudah ada (INI YANG SEBELUMNYA KURANG)
    if plr.Character then
        applyESP(plr.Character)
    end

    -- saat respawn
    plr.CharacterAdded:Connect(function(char)
        task.wait(0.2)
        applyESP(char)
    end)
end

-- apply ke semua player
for _,p in pairs(Players:GetPlayers()) do
    setupESP(p)
end
Players.PlayerAdded:Connect(setupESP)

--------------------------------------------------
-- 🎨 UPDATE WARNA ESP
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
                    h.FillColor = Color3.fromRGB(255,0,0) -- merah
                elseif role == "SURVIVOR" then
                    h.FillColor = Color3.fromRGB(0,170,255) -- biru
                else
                    h.FillColor = Color3.fromRGB(255,255,255) -- putih
                end
            end
        end
    end
end)
