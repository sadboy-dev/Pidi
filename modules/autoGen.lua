-- autoGen.lua - AUTO PERFECT GENERATOR
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local getRole = _G.getRole

--------------------------------------------------
-- ⚡ AUTO PERFECT GENERATOR (SURVIVOR ONLY)
--------------------------------------------------
task.spawn(function()
    local playerGui = player:WaitForChild("PlayerGui")

    local skillRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Generator"):WaitForChild("SkillCheckResultEvent")

    local lastGenPoint = nil
    local lastGenModel = nil

    -- FUNGSI CARI GENERATOR
    local function getGenerators()
        local gens = {}
        local map = workspace:FindFirstChild("Map")
        if not map then return gens end
        for _, v in pairs(map:GetDescendants()) do
            if v.Name == "Generator" or v.Name:lower() == "generator" then
                table.insert(gens, v)
            end
        end
        return gens
    end

    local function getClosestGeneratorPoint(root)
        local gens = getGenerators()
        local closestGen, closestPoint, closestDist = nil, nil, 10

        for _, gen in ipairs(gens) do
            for i = 1, 4 do
                local point = gen:FindFirstChild("GeneratorPoint" .. i)
                if point then
                    local dist = (root.Position - point.Position).Magnitude
                    if dist < closestDist then
                        closestDist = dist -- ✅ DIPERBAIKI: dist BUKAN distance
                        closestGen = gen
                        closestPoint = point
                    end
                end
            end
        end
        return closestGen, closestPoint, closestDist
    end

    while true do
        task.wait(0.1)

        -- hanya jalan kalau survivor
        if getRole(player) ~= "SURVIVOR" then continue end

        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")

        if root then
            local genModel, genPoint, dist = getClosestGeneratorPoint(root)

            if genPoint and dist < 6 then
                lastGenModel = genModel
                lastGenPoint = genPoint
            end

            local gui = playerGui:FindFirstChild("SkillCheckPromptGui")
            if gui then
                local check = gui:FindFirstChild("Check")
                if check and check.Visible then
                    if lastGenPoint and (root.Position - lastGenPoint.Position).Magnitude < 6 then
                        skillRemote:FireServer("success", 1, lastGenModel, lastGenPoint)
                        check.Visible = false
                    end
                end
            end
        end
    end
end)

-- SIMPAN KE GLOBAL
_G.autoGen = {
    Start = function()
        print("🤖 AUTO GEN AKTIF (SURVIVOR ONLY)")
    end,
    Stop = function()
        print("🤖 AUTO GEN MATI")
    end
}

return _G.autoGen
