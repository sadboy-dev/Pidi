-- modules/espPlayer.lua

local esp = {}
local Connections = {} -- Untuk simpan event biar bisa dimatikan

function esp.On()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer

    --------------------------------------------------
    -- HAPUS ESP LAMA (ANTI DOBEL)
    --------------------------------------------------
    local function cleanOld(char)
        if char:FindFirstChild("ESP_Highlight") then char.ESP_Highlight:Destroy() end
        if char:FindFirstChild("ESP_Text") then char.ESP_Text:Destroy() end
    end

    --------------------------------------------------
    -- BUAT ESP
    --------------------------------------------------
    local function applyESP(char, plr)
        if not char then return end
        cleanOld(char)

        -- 1. HIGHGLIGHT (BADAN BERWARNA)
        local h = Instance.new("Highlight")
        h.Name = "ESP_Highlight"
        h.FillTransparency = 0.5
        h.OutlineTransparency = 0
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Parent = char

        -- 2. TEXT LABEL (NAMA + LEVEL)
        local bill = Instance.new("BillboardGui")
        bill.Name = "ESP_Text"
        bill.Size = UDim2.new(0, 200, 0, 40)
        bill.StudsOffset = Vector3.new(0, 3, 0) -- Naikin dikit posisinya
        bill.AlwaysOnTop = true
        bill.Parent = char

        local txt = Instance.new("TextLabel")
        txt.Size = UDim2.new(1,0,1,0)
        txt.BackgroundTransparency = 1
        txt.TextScaled = true
        txt.Font = Enum.Font.SourceSansBold
        txt.TextColor3 = Color3.new(1,1,1)
        txt.Parent = bill

        -- Fungsi update nama & level
        local function updateInfo()
            local level = "?"
            local ls = plr:FindFirstChild("leaderstats")
            if ls then
                local lvl = ls:FindFirstChild("Level") or ls:FindFirstChild("level") or ls:FindFirstChild("LVL")
                if lvl then level = lvl.Value end
            end
            txt.Text = plr.Name .. " [" .. level .. "]"
        end

        updateInfo()

        -- Pantau kalau level berubah
        local ls = plr:FindFirstChild("leaderstats")
        if ls then
            local lvlObj = ls:FindFirstChild("Level") or ls:FindFirstChild("level") or ls:FindFirstChild("LVL")
            if lvlObj then
                local conn = lvlObj.Changed:Connect(updateInfo)
                table.insert(Connections, conn)
            end
        end
    end

    --------------------------------------------------
    -- SETUP PLAYER
    --------------------------------------------------
    local function setup(plr)
        if plr == player then return end

        if plr.Character then
            applyESP(plr.Character, plr)
        end

        local connChar = plr.CharacterAdded:Connect(function(char)
            task.wait(0.2)
            applyESP(char, plr)
        end)
        table.insert(Connections, connChar)
    end

    -- Apply ke semua player
    for _,p in pairs(Players:GetPlayers()) do
        setup(p)
    end
    local connAdded = Players.PlayerAdded:Connect(setup)
    table.insert(Connections, connAdded)

    --------------------------------------------------
    -- UPDATE WARNA ROLE
    --------------------------------------------------
    local connRender = RunService.RenderStepped:Connect(function()
        for _,p in pairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                local h = p.Character:FindFirstChild("ESP_Highlight")
                if h then
                    local role = "SPECTATOR"

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
    table.insert(Connections, connRender)

    print("👀 ESP Player: ON")
end

--------------------------------------------------
-- MATIKAN ESP
--------------------------------------------------
function esp.Off()
    -- Putus semua koneksi event
    for _, conn in pairs(Connections) do
        conn:Disconnect()
    end
    Connections = {}

    -- Hapus semua objek ESP di dunia
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "ESP_Highlight" or v.Name == "ESP_Text" then
            v:Destroy()
        end
    end

    print("👀 ESP Player: OFF")
end

return esp
