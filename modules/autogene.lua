--------------------------------------------------
-- ⚡ AUTO PERFECT GENERATOR (FIX 2 PARAMETER + DEBUG)
--------------------------------------------------
task.spawn(function()
    local gui = player:WaitForChild("PlayerGui")
    
    -- Tunggu remote load dengan aman
    local remote = nil
    while not remote do
        pcall(function()
            remote = ReplicatedStorage:WaitForChild("Remotes", 1)
                :WaitForChild("Generator", 1)
                :WaitForChild("SkillCheckResultEvent", 1)
        end)
        task.wait()
    end
    print("✅ Remote Found!")

    local lastFire = 0

    while true do
        task.wait(0.05) -- ⬅️ Dipercepat dari 0.1 jadi 0.05

        if ROLE ~= "SURVIVOR" then continue end

        local g = gui:FindFirstChild("SkillCheckPromptGui")
        if g then
            local check = g:FindFirstChild("Check")
            if check and check.Visible then
                
                -- Anti Spam
                if tick() - lastFire < 0.1 then continue end
                lastFire = tick()

                -- 🔧 COBA 2 PARAMETER (Versi Paling Aman)
                remote:FireServer("success", 1) 
                -- Alternatif kalau tidak work: remote:FireServer("great", 1)
                
                check.Visible = false
                print("🎯 Auto Perfect Triggered!")
            end
        end
    end
end)
