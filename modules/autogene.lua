local autogene = {}

function autogene.Start(getRole)
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer

    local remote = ReplicatedStorage:WaitForChild("Remotes", 10)
        :WaitForChild("Generator", 5)
        :WaitForChild("SkillCheckResultEvent", 5)

    local isActive = false
    local lastFire = 0

    local function getClosestGenerator()
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then return false end

        for _, gen in ipairs(workspace:GetDescendants()) do
            if gen.Name:find("Generator") or gen.Name == "Gen" then
                local point = gen:FindFirstChild("GeneratorPoint1") or gen.PrimaryPart
                if point and (root.Position - point.Position).Magnitude < 8 then
                    return true
                end
            end
        end
        return false
    end

    local function skillCheckLoop()
        while isActive do
            task.wait(0.07)

            if not getClosestGenerator() then continue end

            local playerGui = player:WaitForChild("PlayerGui")
            local skillGui = playerGui:FindFirstChild("SkillCheckPromptGui")
                         or playerGui:FindFirstChild("SkillCheck")  -- tambahan nama alternatif

            if not skillGui then continue end

            -- Deteksi lebih akurat (sesuai script original kamu)
            local check = skillGui:FindFirstChild("Check") 
                       or skillGui:FindFirstChild("Prompt")
                       or skillGui:FindFirstChildWhichIsA("Frame")

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
        if not isActive then return end
        isActive = false
        print("AUTO GENE DIMATIKAN")
    end

    -- Monitor role (tetap jalan permanent)
    task.spawn(function()
        while true do
            task.wait(0.4)
            local role = getRole and getRole() or "UNKNOWN"
            if role == "SURVIVOR" then
                startAutoGene()
            else
                stopAutoGene()
            end
        end
    end)

    print("Module AutoGene v2 berhasil dimuat!")
end

return autogene
