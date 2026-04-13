-- espGene.lua - VERSI FINAL & AMAN
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local espGenObjects = {}

-- ==============================================
-- FUNGSI GET ROLE (SAMA PERSIS DI SCRIPT KAMU)
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
-- LOOP UTAMA + SORTIR ROLE AMAN
-- ==============================================
RunService.RenderStepped:Connect(function()
    -- ✅ AMBIL ROLE
    local myRole = getRole(player)

    -- ✅ SYARAT: HANYA SURVIVOR & SPECTATOR
    if myRole ~= "SURVIVOR" and myRole ~= "SPECTATOR" then
        -- Hapus semua ESP kalau role bukan yang diizinkan
        for obj,_ in pairs(espGenObjects) do
            removeGenESP(obj)
        end
        return
    end

    -- ✅ JALANKAN ESP
    for _, gen in pairs(getGenerators()) do
        local progress = getGeneratorProgress(gen)
        local percent = math.floor(progress * 100)
        local color = Color3.fromRGB(255,255,255):Lerp(Color3.fromRGB(0,255,0), progress)

        createGenESP(gen, color, percent)
    end
end)

-- ==============================================
-- SIMPAN KE GLOBAL (UNTUK MAIN.LUA)
-- ==============================================
_G.espGene = {
    Start = function()
        print("⚡ ESP GENERATOR AKTIF (SURV & SPEC ONLY)")
    end,
    Stop = function()
        print("❌ ESP GENERATOR MATI")
        for obj, _ in pairs(espGenObjects) do
            removeGenESP(obj)
        end
    end
}

return _G.espGene
