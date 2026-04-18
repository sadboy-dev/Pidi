-- ANTI DOUBLE RUN
if _G.__ULTRA_FIX_SELECTED_FEATURES then return end
_G.__ULTRA_FIX_SELECTED_FEATURES = true

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

--------------------------------------------------
-- 👀 FOV
--------------------------------------------------
local IPAD_FOV = 100

local function applyFOV()
    if workspace.CurrentCamera then
        workspace.CurrentCamera.FieldOfView = IPAD_FOV
    end
end

RunService.RenderStepped:Connect(function()
    if workspace.CurrentCamera and workspace.CurrentCamera.FieldOfView ~= IPAD_FOV then
        workspace.CurrentCamera.FieldOfView = IPAD_FOV
    end
end)

--------------------------------------------------
-- ⚡ BOOST
--------------------------------------------------
local function startBoost()
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    end)

    Lighting.GlobalShadows = false

    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
            v.Enabled = false
        end

        if v:IsA("BasePart") then
            v.Material = Enum.Material.Plastic
        end
    end
end

--------------------------------------------------
-- 🎭 ROLE
--------------------------------------------------
local function getRole(plr)
    if plr.Team then
        local n = plr.Team.Name:lower()
        if n:find("killer") then return "KILLER" end
        if n:find("survivor") then return "SURVIVOR" end
    end
    return "UNKNOWN"
end

--------------------------------------------------
-- ✨ ESP PLAYER
--------------------------------------------------
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

RunService.RenderStepped:Connect(function()
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

for _, p in pairs(Players:GetPlayers()) do
    applyESP(p)
end
Players.PlayerAdded:Connect(applyESP)

--------------------------------------------------
-- 🖥️ CONSOLE
--------------------------------------------------
local lastRole = ""

RunService.RenderStepped:Connect(function()
    local role = getRole(player)

    if role ~= lastRole then
        if role == "UNKNOWN" then
            print("📍 STATUS: LOBBY")
        else
            print("📍 STATUS: INGAME")
            print("🎭 ROLE KAMU:", role)
        end
        lastRole = role
    end
end)

--------------------------------------------------
-- 🔧 ESP GENERATOR
--------------------------------------------------
local espGenObjects = {}

local function removeGenESP(obj)
    if espGenObjects[obj] then
        local data = espGenObjects[obj]
        if data.highlight then data.highlight:Destroy() end
        if data.billboard then data.billboard:Destroy() end
        espGenObjects[obj] = nil
    end
end

local function createGenESP(obj, color, percent)
    local data = espGenObjects[obj]

    if data then
        data.highlight.FillColor = color
        data.label.Text = percent .. "%"
        data.label.TextColor3 = color
        return
    end

    local h = Instance.new("Highlight")
    h.FillColor = color
    h.FillTransparency = 0.5
    h.Parent = obj

    local bill = Instance.new("BillboardGui")
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

RunService.RenderStepped:Connect(function()
    if getRole(player) == "UNKNOWN" then
        for obj,_ in pairs(espGenObjects) do
            removeGenESP(obj)
        end
        return
    end

    for _, gen in pairs(getGenerators()) do
        local progress = getGeneratorProgress(gen)
        local percent = math.floor(progress * 100)
        local color = Color3.fromRGB(255,255,255):Lerp(Color3.fromRGB(0,255,0), progress)

        createGenESP(gen, color, percent)
    end
end)

--------------------------------------------------
-- ⚡ AUTO PERFECT GENERATOR (SURVIVOR ONLY)
--------------------------------------------------
task.spawn(function()
    local playerGui = player:WaitForChild("PlayerGui")

    local skillRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Generator"):WaitForChild("SkillCheckResultEvent")

    local lastGenPoint = nil
    local lastGenModel = nil

    local function getClosestGeneratorPoint(root)
        local gens = getGenerators()
        local closestGen, closestPoint, closestDist = nil, nil, 10

        for _, gen in ipairs(gens) do
            for i = 1, 4 do
                local point = gen:FindFirstChild("GeneratorPoint" .. i)
                if point then
                    local dist = (root.Position - point.Position).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        closestGen = gen
                        closestPoint = point
                    end
                end
            end
        end
        return closestGen, closestPoint, closestDist
    end

    while true do
        task.wait(0.1)

        -- hanya jalan kalau survivor
        if getRole(player) ~= "SURVIVOR" then continue end

        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")

        if root then
            local genModel, genPoint, dist = getClosestGeneratorPoint(root)

            if genPoint and dist < 6 then
                lastGenModel = genModel
                lastGenPoint = genPoint
            end

            local gui = playerGui:FindFirstChild("SkillCheckPromptGui")
            if gui then
                local check = gui:FindFirstChild("Check")
                if check and check.Visible then
                    if lastGenPoint and (root.Position - lastGenPoint.Position).Magnitude < 6 then
                        skillRemote:FireServer("success", 1, lastGenModel, lastGenPoint)
                        check.Visible = false
                    end
                end
            end
        end
    end
end)

--------------------------------------------------
-- RESPAWN
--------------------------------------------------
player.CharacterAdded:Connect(function()
    task.wait(0.5)
    applyFOV()
end)

--------------------------------------------------
-- START
--------------------------------------------------
startBoost()
applyFOV()

print("🔥 SCRIPT FINAL + AUTO SKILLCHECK 🔥")
