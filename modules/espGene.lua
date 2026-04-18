local RunService = game:GetService("RunService")

-- ==============================================
-- CONFIG
-- ==============================================
local GENE_FOLDER = workspace:FindFirstChild("Generators") -- sesuaikan nama folder

local wasEnabled = false
local progressEnabled = false

-- ==============================================
-- CREATE ESP BOX
-- ==============================================
local function createESP(gen)
    if not gen then return end

    local old = gen:FindFirstChild("ESP_Generator")
    if old then old:Destroy() end

    local h = Instance.new("Highlight")
    h.Name = "ESP_Generator"
    h.FillTransparency = 0.5
    h.OutlineTransparency = 0
    h.FillColor = Color3.fromRGB(255, 215, 0) -- Gold color
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = gen
end

local function removeESP(gen)
    if gen then
        local h = gen:FindFirstChild("ESP_Generator")
        if h then h:Destroy() end
    end
end

-- ==============================================
-- CREATE PROGRESS TEXT
-- ==============================================
local function createProgress(gen)
    if not gen then return end

    local old = gen:FindFirstChild("ESP_Progress")
    if old then old:Destroy() end

    local bill = Instance.new("BillboardGui")
    bill.Name = "ESP_Progress"
    bill.Size = UDim2.new(0, 100, 0, 40)
    bill.AlwaysOnTop = true
    bill.StudsOffset = Vector3.new(0, 3, 0)

    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(1,0,1,0)
    txt.BackgroundTransparency = 1
    txt.TextColor3 = Color3.fromRGB(255,255,255)
    txt.TextStrokeTransparency = 0
    txt.TextScaled = true
    txt.Text = "0%"
    txt.Parent = bill

    bill.Parent = gen
end

local function removeProgress(gen)
    if gen then
        local t = gen:FindFirstChild("ESP_Progress")
        if t then t:Destroy() end
    end
end

local function updateProgress(gen)
    if not gen then return end

    local gui = gen:FindFirstChild("ESP_Progress")
    if not gui then return end

    local txt = gui:FindFirstChildOfClass("TextLabel")
    if not txt then return end

    -- 🔍 AMBIL PROGRESS (sesuaikan dengan game kamu)
    local progress = 0

    if gen:FindFirstChild("Progress") and gen.Progress:IsA("NumberValue") then
        progress = math.clamp(gen.Progress.Value, 0, 100)
    elseif gen:FindFirstChild("Percent") and gen.Percent:IsA("NumberValue") then
        progress = math.clamp(gen.Percent.Value, 0, 100)
    elseif gen:FindFirstChild("Progress") and gen.Progress:IsA("IntValue") then
        progress = math.clamp(gen.Progress.Value, 0, 100)
    end

    txt.Text = math.floor(progress) .. "%"
end

-- ==============================================
-- APPLY TO ALL GENERATORS
-- ==============================================
local function applyESPToGenerators()
    if not GENE_FOLDER then return end

    for _, gen in pairs(GENE_FOLDER:GetChildren()) do
        createESP(gen)
        if progressEnabled then
            createProgress(gen)
        end
    end
end

local function removeESPFromGenerators()
    if not GENE_FOLDER then return end

    for _, gen in pairs(GENE_FOLDER:GetChildren()) do
        removeESP(gen)
        removeProgress(gen)
    end
end

-- ==============================================
-- START / STOP FUNCTIONS
-- ==============================================
local function startESPGenerator()
    if not _G.FeatureState then
        _G.FeatureState = {}
    end
    if _G.FeatureState.espGenerator then
        return
    end

    _G.FeatureState.espGenerator = true
    applyESPToGenerators()
    print("[FEATURED]: ESP Generator -> ON")
end

local function stopESPGenerator()
    if not _G.FeatureState then
        _G.FeatureState = {}
    end
    if not _G.FeatureState.espGenerator then
        return
    end

    _G.FeatureState.espGenerator = false
    removeESPFromGenerators()
    print("[FEATURED]: ESP Generator -> OFF")
end

local function startProgressFeature()
    if not _G.FeatureState then
        _G.FeatureState = {}
    end
    if _G.FeatureState.generatorProgress then
        return
    end

    _G.FeatureState.generatorProgress = true
    progressEnabled = true

    if _G.FeatureState.espGenerator then
        applyESPToGenerators()
    end

    print("[FEATURED]: Generator Progress -> ON")
end

local function stopProgressFeature()
    if not _G.FeatureState then
        _G.FeatureState = {}
    end
    if not _G.FeatureState.generatorProgress then
        return
    end

    _G.FeatureState.generatorProgress = false
    progressEnabled = false

    if GENE_FOLDER then
        for _, gen in pairs(GENE_FOLDER:GetChildren()) do
            removeProgress(gen)
        end
    end

    print("[FEATURED]: Generator Progress -> OFF")
end

-- ==============================================
-- UPDATE LOOP
-- ==============================================
RunService.RenderStepped:Connect(function()
    local espEnabled = _G.FeatureState and _G.FeatureState.espGenerator
    local progressEnabledCheck = _G.FeatureState and _G.FeatureState.generatorProgress

    if espEnabled and not wasEnabled then
        wasEnabled = true
        applyESPToGenerators()
    elseif not espEnabled and wasEnabled then
        wasEnabled = false
        removeESPFromGenerators()
    end

    if progressEnabledCheck and not progressEnabled then
        progressEnabled = true
        if espEnabled then
            applyESPToGenerators()
        end
    elseif not progressEnabledCheck and progressEnabled then
        progressEnabled = false
        if GENE_FOLDER then
            for _, gen in pairs(GENE_FOLDER:GetChildren()) do
                removeProgress(gen)
            end
        end
    end

    -- Update progress values
    if espEnabled and progressEnabledCheck and GENE_FOLDER then
        for _, gen in pairs(GENE_FOLDER:GetChildren()) do
            updateProgress(gen)
        end
    end
end)

-- ==============================================
-- GLOBAL CONTROL
-- ==============================================
_G.espGenerator = {}
_G.espGenerator.Start = startESPGenerator
_G.espGenerator.Stop = stopESPGenerator

_G.generatorProgress = {}
_G.generatorProgress.Start = startProgressFeature
_G.generatorProgress.Stop = stopProgressFeature

return _G.espGenerator
