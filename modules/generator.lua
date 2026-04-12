local generator = {}

function generator.Start()
    local RunService = game:GetService("RunService")

    local genESP = {}

    --------------------------------------------------
    -- AMBIL GENERATOR
    --------------------------------------------------
    local function getGenerators()
        local map = workspace:FindFirstChild("Map")
        if not map then return {} end

        local gens = {}
        for _,v in pairs(map:GetDescendants()) do
            if v.Name == "Generator" then
                table.insert(gens, v)
            end
        end
        return gens
    end

    --------------------------------------------------
    -- AMBIL PROGRESS (ANTI ERROR)
    --------------------------------------------------
    local function getProgress(gen)
        local p = gen:GetAttribute("Progress")
            or gen:GetAttribute("RepairProgress")

        if not p then
            for _,v in pairs(gen:GetDescendants()) do
                if v:IsA("NumberValue") and v.Name:lower():find("progress") then
                    p = v.Value
                    break
                end
            end
        end

        p = p or 0

        if p > 1 then
            p = p / 100
        end

        return math.clamp(p, 0, 1)
    end

    --------------------------------------------------
    -- BUAT / UPDATE ESP
    --------------------------------------------------
    local function createESP(gen, percent)
        if genESP[gen] then
            local data = genESP[gen]

            local color = Color3.fromRGB(255,255,255):Lerp(
                Color3.fromRGB(0,255,0),
                percent / 100
            )

            data.label.Text = percent .. "%"
            data.label.TextColor3 = color
            data.highlight.FillColor = color

            return
        end

        -- HIGHLIGHT
        local h = Instance.new("Highlight")
        h.FillTransparency = 0.5
        h.OutlineTransparency = 0
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Parent = gen

        -- BILLBOARD
        local bill = Instance.new("BillboardGui")
        bill.Size = UDim2.new(0,60,0,18) -- KECIL
        bill.AlwaysOnTop = true
        bill.StudsOffset = Vector3.new(0,2,0)
        bill.Parent = gen

        -- TEXT
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1,0,1,0)
        label.BackgroundTransparency = 1
        label.TextScaled = false
        label.TextSize = 10 -- KECIL
        label.Font = Enum.Font.SourceSansBold
        label.TextStrokeTransparency = 0.4
        label.Parent = bill

        genESP[gen] = {
            highlight = h,
            label = label
        }
    end

    --------------------------------------------------
    -- LOOP UPDATE (RINGAN)
    --------------------------------------------------
    RunService.RenderStepped:Connect(function()
        for _,gen in pairs(getGenerators()) do
            local p = getProgress(gen)
            local percent = math.floor(p * 100)

            createESP(gen, percent)
        end
    end)
end

return generator
