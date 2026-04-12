-- boostFps.lua

print("⚡ BOOST FPS: ACTIVATED")
setfpscap(60)

local Lighting = game:GetService("Lighting")
Lighting.GlobalShadows = false
Lighting.FogEnd = 10000
Lighting.FogStart = 0

-- Matikan efek berat
for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
        v.Enabled = false
    end
end
