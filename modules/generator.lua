-- espGene.lUA - VERSI DENGAN TOGGLE ON OFF
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local espGenObjects = {}
local ESP_ENABLED = true -- DEFAULT NYALA

-- ==============================================
-- 🎛️ BUAT TOMBOL ON OFF
-- ==============================================
local Gui = Instance.new("ScreenGui")
Gui.Name = "ToggleESP_GUI"
Gui.Parent = player.PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0,200,0,50)
Frame.Position = UDim2.new(0.05,0,0.1,0)
Frame.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
Frame.BorderColor3 = Color3.new(0,1,0)
Frame.BorderSizePixel = 2
Frame.Parent = Gui

local Text = Instance.new("TextLabel")
Text.Size = UDim2.new(0.6,0,1,0)
Text.Position = UDim2.new(0.05,0,0,0)
Text.BackgroundTransparency = 1
Text.Text = "ESP GENERATOR"
Text.TextColor3 = Color3.new(1,1,1)
Text.Font = Enum.Font.SourceSansBold
Text.TextSize = 16
Text.Parent = Frame

local Btn = Instance.new("TextButton")
Btn.Size = UDim2.new(0.3,0,0.8,0)
Btn.Position = UDim2.new(0.68,0,0.1,0)
Btn.BackgroundColor3 = Color3.new(0,1,0)
Btn.Text = "ON"
Btn.TextColor3 = Color3.new(0,0,0)
Btn.Font = Enum.Font.SourceSansBold
Btn.TextSize = 14
Btn.Parent = Frame

-- ==============================================
-- FUNGSI GET ROLE
-- ==============================================
local function getRole(plr)
    if plr.Team then
        local n = plr.Team.Name:lower()
        if n:find("killer") then return "KILLER" end
        if n:find("survivor") then return "SURVIVOR" end
    end
    return "UNKNOWN"
end

-- ==============================================
-- FUNGSI HAPUS ESP
-- ==============================================
local function removeGenESP(obj)
    if espGenObjects[obj] then
        local data = espGenObjects[obj]
        if data.highlight then data.highlight:Destroy() end
        if data.billboard then data.billboard:Destroy() end
        espGenObjects[obj] = nil
    end
end

-- ==============================================
-- FUNGSI BUAT / UPDATE ESP
-- ==============================================
local function createGenESP(obj, color, percent)
    local data = espGenObjects[obj]

    if data then
        data.highlight.FillColor = color
        data.highlight.OutlineColor = color
        data.label.Text = percent .. "%"
        data.label.TextColor3 = color
        return
    end

    local h = Instance.new("Highlight")
    h.Name = "GenESP"
    h.FillColor = color
    h.FillTransparency = 0.5
    h.OutlineColor = color
    h.OutlineTransparency = 0
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = obj

    local bill = Instance.new("BillboardGui")
    bill.Name = "GenGUI"
    bill.Size = UDim2.new(0,100,0,40)
    bill.AlwaysOnTop = true
    bill.Parent = obj

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.TextScaled = false
    label.TextSize = 14
    label.Font = Enum.Font.SourceSansBold
    label.TextStrokeTransparency = 0
    label.Text = percent .. "%"
    label.TextColor3 = color
    label.Parent = bill

    espGenObjects[obj] = {
        highlight = h,
        billboard = bill,
        label = label
    }
end

-- ==============================================
-- CEK PROGRESS GENERATOR
-- ==============================================
local function getGeneratorProgress(gen)
    local progress = 0

    if gen:GetAttribute("Progress") then
        progress = gen:GetAttribute("Progress")
    elseif gen:GetAttribute("RepairProgress") then
        progress = gen:GetAttribute("RepairProgress")
    else
        for _, v in pairs(gen:GetDescendants()) do
            if v:IsA("NumberValue") or v:IsA("IntValue") then
                local name = v.Name:lower()
                if name:find("progress") or name:find("repair") or name:find("percent") then
                    progress = v.Value
                    break
                end
            end
        end
    end

    progress = (progress > 1) and progress / 100 or progress
    return math.clamp(progress, 0, 1)
end

-- ==============================================
-- CARI SEMUA GENERATOR
-- ==============================================
local function getGenerators()
    local gens = {}
    local map = workspace:FindFirstChild("Map")
    if not map then return gens end

    for _, v in pairs(map:GetDescendants()) do
        if v.Name == "Generator" then
            table.insert(gens, v)
        end
    end

    return gens
end

-- ==============================================
-- LOOP UTAMA
-- ==============================================
RunService.RenderStepped:Connect(function()
    -- 🔴 JIKA OFF, HAPUS SEMUA
    if not ESP_ENABLED then
        for obj,_ in pairs(espGenObjects) do
            removeGenESP(obj)
        end
        return
    end

    -- 🟢 JIKA ON, TAMPILKAN
    for _, gen in pairs(getGenerators()) do
        local progress = getGeneratorProgress(gen)
        local percent = math.floor(progress * 100)
        local color = Color3.fromRGB(255,255,255):Lerp(Color3.fromRGB(0,255,0), progress)

        createGenESP(gen, color, percent)
    end
end)

-- ==============================================
-- EVENT KLIK TOMBOL
-- ==============================================
Btn.MouseButton1Click:Connect(function()
    ESP_ENABLED = not ESP_ENABLED
    if ESP_ENABLED then
        Btn.BackgroundColor3 = Color3.new(0,1,0)
        Btn.Text = "ON"
    else
        Btn.BackgroundColor3 = Color3.new(1,0,0)
        Btn.Text = "OFF"
        -- Hapus langsung saat klik off
        for obj,_ in pairs(espGenObjects) do
            removeGenESP(obj)
        end
    end
end)

print("✅ ESP GENE LOADED!")
