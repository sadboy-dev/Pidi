-- espPlayer.lua - VERSI DETECT SENDIRI
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- ==============================================
-- FUNGSI BUAT BOX
-- ==============================================
local function applyESP(plr)
    if plr == player then return end

    local function setup(char)
        if not char then return end

        local old = char:FindFirstChild("ESP")
        if old then old:Destroy() end

        local h = Instance.new("Highlight")
        h.Name = "ESP"
        h.FillTransparency = 0.5
        h.OutlineTransparency = 0
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.FillColor = Color3.fromRGB(255,255,255) -- Default Putih
        h.Parent = char
    end

    if plr.Character then
        setup(plr.Character)
    end

    plr.CharacterAdded:Connect(function(c)
        task.wait(0.5)
        setup(c)
    end)
end

-- ==============================================
-- LOOP UPDATE WARNA
-- ==============================================
RunService.RenderStepped:Connect(function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local h = plr.Character:FindFirstChild("ESP")
            if h then
                
                -- ✅ LOGIKA DETECT ROLE LANGSUNG DISINI
                local role = "SPECTATOR" -- Default
                
                if plr.Team then
                    local teamName = plr.Team.Name:lower()
                    
                    if teamName:find("killer") then
                        role = "KILLER"
                    elseif teamName:find("survivor") then
                        role = "SURVIVOR"
                    end
                end

                -- ✅ SET WARNA
                if role == "KILLER" then
                    h.FillColor = Color3.fromRGB(255, 0, 0)   -- 🔴 MERAH
                elseif role == "SURVIVOR" then
                    h.FillColor = Color3.fromRGB(0, 170, 255) -- 🔵 BIRU
                else
                    h.FillColor = Color3.fromRGB(255, 255, 255) -- ⚪ PUTIH
                end
            end
        end
    end
end)

-- ==============================================
-- JALANKAN OTOMATIS
-- ==============================================
for _, p in pairs(Players:GetPlayers()) do
    applyESP(p)
end
Players.PlayerAdded:Connect(applyESP)

-- ==============================================
-- SIMPAN KE GLOBAL
-- ==============================================
_G.espPlayer = {
    Start = function()
        print("✅ ESP AKTIF")
    end,
    Stop = function()
        print("❌ ESP MATI")
    end
}

return _G.espPlayer
