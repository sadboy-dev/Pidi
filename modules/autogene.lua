local autogene = {}

function autogene.Start(getRole)
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local player = Players.LocalPlayer
    local isRunning = false -- Variabel buat cek status

    local function mainLoop()
        task.spawn(function()
            local gui = player:WaitForChild("PlayerGui")
            local remote = ReplicatedStorage:WaitForChild("Remotes")
                :WaitForChild("Generator")
                :WaitForChild("SkillCheckResultEvent")

            local lastFire = 0

            while true do
                task.wait(0.01) -- ⚡ SUPER CEPAT

                local currentRole = getRole and getRole() or "UNKNOWN"

                -- 🔔 TAMPILKAN STATUS DI CONSOLE
                if currentRole == "SURVIVOR" then
                    if not isRunning then
                        print("✅ AUTO GENE AKTIF - MODE SURVIVOR")
                        isRunning = true
                    end
                else
                    if isRunning then
                        print("⏸️ AUTO GENE NONAKTIF - BUKAN SURVIVOR")
                        isRunning = false
                    end
                    continue -- Skip kalau bukan survivor
                end

                -- 🔍 DETEKSI SKILL CHECK
                local g = gui:FindFirstChild("SkillCheckPromptGui")
                if g then
                    local check = g:FindFirstChild("Check") 
                               or g:FindFirstChild("Area") 
                               or g:FindFirstChild("Frame") 
                               or g:FindFirstChild("ImageLabel")

                    if check and check.Visible then
                        if tick() - lastFire < 0.05 then continue end
                        lastFire = tick()

                        remote:FireServer("success", 1)
                        check.Visible = false
                        print("🎯 PERFECT!")
                    end
                end
            end
        end)
    end

    -- Jalankan pertama kali
    mainLoop()

    -- Restart saat respawn
    player.CharacterAdded:Connect(function()
        task.wait(0.5)
        isRunning = false -- Reset status
        mainLoop()
    end)

end

return autogene
