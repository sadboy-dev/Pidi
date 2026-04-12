local autogene = {}

function autogene.Start()
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local player = Players.LocalPlayer
    local gui = player:WaitForChild("PlayerGui")

    -- 🔐 CARI REMOTE DENGAN AMAN
    local remote = nil
    while not remote do
        pcall(function()
            remote = ReplicatedStorage:WaitForChild("Remotes", 1)
                :WaitForChild("Generator", 1)
                :WaitForChild("SkillCheckResultEvent", 1)
        end)
        task.wait(0.1)
    end
    print("✅ Remote Connected!")

    local lastFire = 0

    task.spawn(function()
        while true do
            task.wait(0.05) -- Dipercepat

            local g = gui:FindFirstChild("SkillCheckPromptGui")
            if g then
                local check = g:FindFirstChild("Check")
                if check and check.Visible then
                    
                    -- Anti Spam
                    if tick() - lastFire < 0.1 then continue end
                    lastFire = tick()

                    -- ✅ PAKAI 2 PARAMETER
                    remote:FireServer("success", 1)
                    
                    check.Visible = false
                    print("🎯 AUTO PERFECT!")
                end
            end
        end
    end)
end

return autogene
