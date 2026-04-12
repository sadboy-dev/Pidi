local module = {}
local genESP = {}

function module.Start()

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

    local function getProgress(gen)
        local p = gen:GetAttribute("Progress") or 0
        if p > 1 then p = p/100 end
        return p
    end

    game:GetService("RunService").RenderStepped:Connect(function()
        for _,gen in pairs(getGenerators()) do
            local percent = math.floor(getProgress(gen)*100)

            if genESP[gen] then
                genESP[gen].Text = percent.."%"
            else
                local bill = Instance.new("BillboardGui", gen)
                bill.Size = UDim2.new(0,70,0,20)
                bill.AlwaysOnTop = true

                local txt = Instance.new("TextLabel", bill)
                txt.Size = UDim2.new(1,0,1,0)
                txt.BackgroundTransparency = 1
                txt.TextSize = 11

                genESP[gen] = txt
            end
        end
    end)
end

return module
