return esp
_G.espPlayer = esp -- TAMBAH INI JUGA!
print("🔥 VERSI BARU ESP PLAYER - 10:07")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local getRole = _G.getRole

local esp = {}
local connection = nil -- Untuk nyalakan/matikan loop

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

function esp.Start()
    print("✅ ESP AKTIF")
    
    -- Terapkan ke player yang sudah ada
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            applyESP(plr.Character)
        end
        plr.CharacterAdded:Connect(function(c)
            task.wait(0.1)
            applyESP(c)
        end)
    end

    -- Loop update warna
    connection = RunService.RenderStepped:Connect(function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                local h = plr.Character:FindFirstChild("ESP")
                if h then
                    local role = getRole(plr)
                    if role == "KILLER" then
                        h.FillColor = Color3.fromRGB(255,0,0)
                    else
                        h.FillColor = Color3.fromRGB(0,170,255)
                    end
                end
            end
        end
    end)
end

function esp.Stop()
    print("❌ ESP MATI")
    if connection then
        connection:Disconnect() -- Matikan loop
        connection = nil
    end
    -- Hapus semua highlight
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character then
            local h = plr.Character:FindFirstChild("ESP")
            if h then h:Destroy() end
        end
    end
end

return esp
