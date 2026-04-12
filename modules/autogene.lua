local autogene = {}

function autogene.Start(getRoleCallback)
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local player = Players.LocalPlayer
    local gui = player:WaitForChild("PlayerGui")

    -- Sesuaikan path Remote sesuai game kamu
    local remote = ReplicatedStorage:WaitForChild("Remotes")
        :WaitForChild("Generator")
        :WaitForChild("SkillCheckResultEvent")

    local lastFire = 0

    task.spawn(function()
        while true do
            task.wait(0.05)

            -- Cek role dulu
            if not getRoleCallback or getRoleCallback() ~= "SURVIVOR" then 
                continue 
            end

            -- Cek apakah Skill Check muncul
            local g = gui:FindFirstChild("SkillCheckPromptGui")
            if not g then continue end

            local check = g:FindFirstChild("Check")
            if not (check and check.Visible) then continue end

            -- Anti spam biar tidak di-ignore server
            if tick() - lastFire < 0.07 then continue end
            lastFire = tick()

            -- Kirim success ke server
            remote:FireServer("success", 1)
            check.Visible = false
        end
    end)
end

return autogene
