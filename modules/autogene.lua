local autogene = {}

function autogene.Start(getRole)
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local player = Players.LocalPlayer
    local gui = player:WaitForChild("PlayerGui")

    local remote = ReplicatedStorage:WaitForChild("Remotes")
        :WaitForChild("Generator")
        :WaitForChild("SkillCheckResultEvent")

    task.spawn(function()
        local lastFire = 0

        while true do
            task.wait(0.05)

            if not getRole or getRole() ~= "SURVIVOR" then continue end

            local g = gui:FindFirstChild("SkillCheckPromptGui")
            if not g then continue end

            local check = g:FindFirstChild("Check")
            if not (check and check.Visible) then continue end

            -- anti spam biar tidak di ignore server
            if tick() - lastFire < 0.07 then continue end
            lastFire = tick()

            remote:FireServer("success",1)
            check.Visible = false
        end
    end)
end

return autogene
