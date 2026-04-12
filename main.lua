-- main.lua

if _G.__MAIN then return end
_G.__MAIN = true

print("✅ [MAIN] SCRIPT START!")

--------------------------------------------------
-- VARIABEL PENGAMAN (PENTING!)
--------------------------------------------------
local lastShownStatus = nil -- Ini yang nyimpen status terakhir biar gak spam
local isSpecMode = false

--------------------------------------------------
-- 1. IPAD VIEW
--------------------------------------------------
local Camera = workspace.CurrentCamera
local defaultFOV = 70

local function IpadViewOn()
    pcall(function()
        defaultFOV = Camera.FieldOfView
        Camera.FieldOfView = 100
    end)
end

local function IpadViewOff()
    pcall(function()
        Camera.FieldOfView = defaultFOV
    end)
end

--------------------------------------------------
-- 2. CROSSHAIR
--------------------------------------------------
local CrossGui = nil

local function CrosshairOn()
    if CrossGui then return end
    CrossGui = Instance.new("ScreenGui")
    CrossGui.Name = "CrosshairUI"
    CrossGui.Parent = game:GetService("Players").LocalPlayer.PlayerGui

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0,4,0,4)
    dot.Position = UDim2.new(0.5,-2,0.5,-2)
    dot.BackgroundColor3 = Color3.new(1,1,1)
    dot.BorderSizePixel = 0
    dot.Parent = CrossGui
end

local function CrosshairOff()
    if CrossGui then
        CrossGui:Destroy()
        CrossGui = nil
    end
end

--------------------------------------------------
-- 3. ESP PLAYER + LEVEL
--------------------------------------------------
local Connections = {}
local espObjects = {}

local function CleanESP()
    for _, conn in pairs(Connections) do
        conn:Disconnect()
    end
    Connections = {}
    for _, obj in pairs(espObjects) do
        if obj then obj:Destroy() end
    end
    espObjects = {}
end

local function ESPOn()
    CleanESP()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer

    local function applyESP(char, plr)
        if not char then return end

        local h = Instance.new("Highlight")
        h.Name = "ESP_Highlight"
        h.FillTransparency = 0.5
        h.OutlineTransparency = 0
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Parent = char

        local bill = Instance.new("BillboardGui")
        bill.Name = "ESP_Text"
        bill.Size = UDim2.new(0, 200, 0, 40)
        bill.StudsOffset = Vector3.new(0, 3, 0)
        bill.AlwaysOnTop = true
        bill.Parent = char

        local txt = Instance.new("TextLabel")
        txt.Size = UDim2.new(1,0,1,0)
        txt.BackgroundTransparency = 1
        txt.TextScaled = true
        txt.Font = Enum.Font.SourceSansBold
        txt.TextColor3 = Color3.new(1,1,1)
        txt.Parent = bill

        local function update()
            local level = "?"
            local ls = plr:FindFirstChild("leaderstats")
            if ls then
                local lvl = ls:FindFirstChild("Level") or ls:FindFirstChild("level") or ls:FindFirstChild("LVL")
                if lvl then level = lvl.Value end
            end
            txt.Text = plr.Name .. " [" .. level .. "]"
        end

        update()
        local conn = RunService.Heartbeat:Connect(update)
        table.insert(Connections, conn)
        table.insert(espObjects, bill)
        table.insert(espObjects, h)
    end

    local function setup(plr)
        if plr == player then return end
        if plr.Character then applyESP(plr.Character, plr) end
        local conn = plr.CharacterAdded:Connect(function(char)
            task.wait(0.2)
            applyESP(char, plr)
        end)
        table.insert(Connections, conn)
    end

    for _, p in pairs(Players:GetPlayers()) do setup(p) end
    local conn2 = Players.PlayerAdded:Connect(setup)
    table.insert(Connections, conn2)

    local conn3 = RunService.RenderStepped:Connect(function()
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                local h = p.Character:FindFirstChild("ESP_Highlight")
                if h then
                    local role = "SPECTATOR"
                    if p.Team then
                        local n = p.Team.Name:lower()
                        if n:find("killer") then role = "KILLER"
                        elseif n:find("survivor") then role = "SURVIVOR" end
                    end
                    if role == "KILLER" then h.FillColor = Color3.fromRGB(255,0,0)
                    elseif role == "SURVIVOR" then h.FillColor = Color3.fromRGB(0,170,255)
                    else h.FillColor = Color3.new(1,1,1) end
                end
            end
        end
    end)
    table.insert(Connections, conn3)
end

local function ESPOff()
    CleanESP()
end

--------------------------------------------------
-- LOGIKA UTAMA
--------------------------------------------------
local function EnableSpec()
    if isSpecMode then return end
    isSpecMode = true
    print("🔌 FITUR: SPECTATOR MODE ON")
    IpadViewOn()
    CrosshairOn()
    ESPOn()
end

local function DisableSpec()
    if not isSpecMode then return end
    isSpecMode = false
    print("🔌 FITUR: SPECTATOR MODE OFF")
    IpadViewOff()
    CrosshairOff()
    ESPOff()
end

local function onUpdate()
    local data = _G.RoleData
    local team = data.TeamName
    local isLobby = data.IsLobby

    -- Bikin string unik buat bandingin
    local currentStatus = tostring(isLobby) .. "_" .. team

    -- 👇 KUNCINYA: HANYA JALAN KALO BERUBAH
    if currentStatus ~= lastShownStatus then
        lastShownStatus = currentStatus

        if isLobby or team == "spectator" or team == "" then
            print("📍 STATUS: LOBBY / SPECTATOR")
            EnableSpec()
        else
            print("📍 STATUS: INGAME | ROLE: " .. team)
            DisableSpec()
        end
    end
end

-- JALANKAN
repeat task.wait() until _G.RoleData and _G.RoleUpdate
_G.RoleUpdate:Connect(onUpdate)
task.wait(0.1)
onUpdate()

print("✅ [MAIN] SYSTEM READY!")
