local autogene = {}

function autogene.Start(getRole)
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer

    local remote = ReplicatedStorage:WaitForChild("Remotes", 8)
        :WaitForChild("Generator", 5)
        :WaitForChild("SkillCheckResultEvent", 5)

    local isActive = false
    local lastFire = 0

    local function isNearGenerator()
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then return false end
        -- Cek jarak ke generator (lebih akurat)
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name:match("Generator") or obj.Name == "Gen" then
                local point = obj:FindFirstChild("GeneratorPoint1") or obj.PrimaryPart
                if point and (root.Position - point.Position).Magnitude < 7 then
                    return true
                end
            end
        end
        return false
    end

    local function skillCheckLoop()
        while isActive do
            task.wait(0.08)

            if not isNearGenerator() then continue end

            local playerGui = player:WaitForChild("PlayerGui", 2)
            if not playerGui then continue end

            local skillGui = playerGui:FindFirstChild("SkillCheckPromptGui") 
                          or playerGui:FindFirstChild("SkillCheck")

            if not skillGui then continue end

            -- Deteksi yang aman (tidak pakai FindFirstChildWhichIsA sembarangan)
            local check = skillGui:FindFirstChild("Check") 
                       or skillGui:FindFirstChild("Prompt") 
                       or skillGui:FindFirstChild("Area")

            if check and check.Visible then
                if tick() - lastFire > 0.1 then
                    lastFire = tick()
                    remote:FireServer("success", 1)
                    print("✅ AUTO GENE PERFECT!")
                end
            end
        end
    end

    local function startAutoGene()
        if isActive then return end
        isActive = true
        print("AUTO GENE AKTIF - MODE SURVIVOR")
        task.spawn(skillCheckLoop)
    end

    local function stopAutoGene()
        isActive = false
        print("AUTO GENE DIMATIKAN")
    end

    -- Monitor role
    task.spawn(function()
        while true do
            task.wait(0.5)
            local role = getRole and getRole() or "UNKNOWN"
            if role == "SURVIVOR" then
                startAutoGene()
            else
                stopAutoGene()
            end
        end
    end)

    print("AutoGene v3 loaded (error ImageLabel sudah diperbaiki)")
end

return autogene
