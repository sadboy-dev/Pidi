local autogene = {}

function autogene.Start()
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
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

        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name:match("Generator") or obj.Name:lower():find("gen") then
                local point = obj:FindFirstChild("GeneratorPoint1") or obj.PrimaryPart
                if point and (root.Position - point.Position).Magnitude < 8 then
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
        if not isActive then return end
        isActive = false
        print("AUTO GENE DIMATIKAN")
    end

    -- ==================== DETEKSI ROLE DARI PESAN ====================
    local function onMessageAdded(msg)
        if typeof(msg) ~= "string" then return end

        local lowerMsg = msg:lower()

        if lowerMsg:find("survivors") or lowerMsg:find("survivor") then
            startAutoGene()
        elseif lowerMsg:find("killer") then
            stopAutoGene()
        elseif lowerMsg:find("spectator") then
            stopAutoGene()
        end
    end

    -- Hook ke pesan sistem (TextChatService atau legacy Chat)
    task.spawn(function()
        -- TextChatService (Roblox baru)
        local success, TextChatService = pcall(function()
            return game:GetService("TextChatService")
        end)

        if success and TextChatService then
            if TextChatService:FindFirstChild("MessageReceived") then
                TextChatService.MessageReceived:Connect(function(message)
                    onMessageAdded(message.Text or "")
                end)
            end
        end

        -- Fallback ke PlayerGui.Chat (legacy)
        player:WaitForChild("PlayerGui"):WaitForChild("Chat", 5).ChildAdded:Connect(function(child)
            if child:IsA("TextLabel") or child:IsA("TextButton") then
                onMessageAdded(child.Text)
            end
        end)
    end)

    -- Fallback awal (kalau pesan tidak muncul)
    task.delay(3, function()
        if not isActive then
            print("AutoGene fallback: menunggu pesan role...")
        end
    end)

    print("AutoGene v5 loaded - Deteksi role via pesan chat (ringan)")
end

return autogene
