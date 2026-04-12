local autogene = {}

function autogene.Start(getRole)
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local player = Players.LocalPlayer

    task.spawn(function()
        local gui = player:WaitForChild("PlayerGui")

        local remote = ReplicatedStorage:WaitForChild("Remotes")
            :WaitForChild("Generator")
            :WaitForChild("SkillCheckResultEvent")

        while true do
            task.wait(0.1)

            -- ✅ CEK ROLE DULU
            if getRole and getRole() ~= "SURVIVOR" then continue end

            local g = gui:FindFirstChild("SkillCheckPromptGui")
            if g then
                local check = g:FindFirstChild("Check")
                if check and check.Visible then
                    remote:FireServer("success", 1)
                    check.Visible = false
                end
            end
        end
    end)
end

return autogene
