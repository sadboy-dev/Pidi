-- espPlayer.lua
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- ✅ YANG INI SUDAH DIPERBAIKI, GAK PAKE REQUIRE LAGI
local getRole = _G.getRole

local esp = {}
local connection = nil

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
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            applyESP(plr.Character)
        end
        plr.CharacterAdded:Connect(function(c)
            task.wait(0.1)
            applyESP(c)
        end)
    end

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
        connection:Disconnect()
        connection = nil
    end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character then
            local h = plr.Character:FindFirstChild("ESP")
            if h then h:Destroy() end
        end
    end
end

-- Simpan ke Global biar main.lua bisa ambil
_G.espPlayer = esp
return esp
