local autogene = {}

function autogene.Start(getRole)
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local player = Players.LocalPlayer

    local remote = ReplicatedStorage:WaitForChild("Remotes")
        :WaitForChild("Generator")
        :WaitForChild("SkillCheckResultEvent")

    local isActive = false
    local lastFire = 0
    local connection = nil

    local function isNearGenerator()
        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return false end
        -- Bisa ditambah logic cek jarak ke generator terdekat jika mau lebih akurat
        return true
    end

    local function skillCheckLoop()
        while isActive do
            task.wait(0.08)  -- lebih stabil (sekitar 12-13 kali per detik)

            if not isNearGenerator() then continue end

            local gui = player:FindFirstChild("PlayerGui")
            if not gui then continue end

            local skillGui = gui:FindFirstChild("SkillCheckPromptGui")
            if not skillGui then continue end

            -- Deteksi yang lebih baik (sesuaikan dengan GUI terbaru game)
            local checkFrame = skillGui:FindFirstChild("Check") 
                            or skillGui:FindFirstChildWhichIsA("ImageLabel")
                            or skillGui:FindFirstChild("Area")

            if checkFrame and checkFrame.Visible then
                if tick() - lastFire > 0.12 then  -- debounce lebih aman
                    lastFire = tick()
                    remote:FireServer("success", 1)
                    -- Jangan langsung Visible = false, biarkan game yang handle (lebih aman)
                    print("✅ Auto Gene Perfect!")
                end
            end
        end
    end

    -- Fungsi utama start/stop
    local function startAutoGene()
        if isActive then return end
        isActive = true
        print("AUTO GENE AKTIF - MODE SURVIVOR")
        task.spawn(skillCheckLoop)
    end

    local function stopAutoGene()
        if not isActive then return end
        isActive = false
        print("AUTO GENE DINONAKTIFKAN")
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

    -- Restart saat respawn
    player.CharacterAdded:Connect(function()
        task.wait(1)
        -- Thread lama akan otomatis berhenti karena isActive = false di stopAutoGene
    end)

    print("Module AutoGene berhasil dimuat!")
end

return autogene
