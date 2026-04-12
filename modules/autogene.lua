local module = {}

function module.Start()
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    local remote = ReplicatedStorage:WaitForChild("Remotes")
        :WaitForChild("Generator")
        :WaitForChild("SkillCheckResultEvent")

    task.spawn(function()
        while true do
            task.wait(0.1)

            local gui = playerGui:FindFirstChild("SkillCheckPromptGui")
            if gui then
                local check = gui:FindFirstChild("Check")
                if check and check.Visible then
                    pcall(function()
                        remote:FireServer("success", 1)
                    end)
                    check.Visible = false
                end
            end
        end
    end)
end

return module
