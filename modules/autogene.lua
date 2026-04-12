local autogene = {}

function autogene.Start(getRole)
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    local remote = ReplicatedStorage:WaitForChild("Remotes")
        :WaitForChild("Generator")
        :WaitForChild("SkillCheckResultEvent")

    --------------------------------------------------
    -- 🔍 GET GENERATOR
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
    -- 📍 GET POINT TERDEKAT
    --------------------------------------------------
    local function getClosestPoint(root)
        local closestGen, closestPoint, distMin = nil, nil, 7

        for _,gen in ipairs(getGenerators()) do
            for i = 1,4 do
                local point = gen:FindFirstChild("GeneratorPoint"..i)
                if point then
                    local dist = (root.Position - point.Position).Magnitude
                    if dist < distMin then
                        distMin = dist
                        closestGen = gen
                        closestPoint = point
                    end
                end
            end
        end

        return closestGen, closestPoint
    end

    --------------------------------------------------
    -- ⚡ AUTO PERFECT
    --------------------------------------------------
    task.spawn(function()
        local lastFire = 0

        while true do
            task.wait(0.05)

            if not getRole or getRole() ~= "SURVIVOR" then continue end

            local char = player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not root then continue end

            local gui = playerGui:FindFirstChild("SkillCheckPromptGui")
            if not gui then continue end

            local check = gui:FindFirstChild("Check")
            if not (check and check.Visible) then continue end

            local genModel, genPoint = getClosestPoint(root)
            if not genModel or not genPoint then continue end

            -- anti spam
            if tick() - lastFire < 0.08 then continue end
            lastFire = tick()

            pcall(function()
                remote:FireServer("success", 1, genModel, genPoint)
            end)

            check.Visible = false
        end
    end)
end

return autogene
