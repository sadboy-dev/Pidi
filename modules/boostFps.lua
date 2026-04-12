-- boostFps.lua
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

--------------------------------------------------
-- ⚡ BOOST FPS
--------------------------------------------------
local function startBoost()
    print("⚡ BOOST FPS DIAKTIFKAN")
    
    -- Setting Grafik
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    end)

    -- Matikan Bayangan
    Lighting.GlobalShadows = false

    -- Hapus Efek & Ubah Material
    for _, v in pairs(workspace:GetDescendants()) do
        -- Matikan efek berat
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
            v.Enabled = false
        end
        
        -- Ubah semua jadi material Plastic
        if v:IsA("BasePart") then
            v.Material = Enum.Material.Plastic
        end
    end
end

-- Jalankan langsung saat load
startBoost()

-- Simpan ke Global supaya bisa dipanggil ulang
_G.boostFps = startBoost

return startBoost
