local boost = {}

function boost.Start()
    local Lighting = game:GetService("Lighting")

    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    end)

    Lighting.GlobalShadows = false
    Lighting.FogEnd = 100000

    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        end

        if v:IsA("BasePart") then
            v.Material = Enum.Material.Plastic
        end
    end
end

return boost
