-- boostFps.lua
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local function boost()
    print("⚡ BOOST FPS DIAKTIFKAN")
    
    -- Setting Grafik
    settings().Rendering.QualityLevel = 1
    settings().Rendering.FramerateCap = 60

    -- HAPUS EFEK YANG BERAT (TAPI TETAP TERANG)
    for _, v in pairs(workspace:GetDescendants()) do
        -- Matikan efek berat
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
            v.Enabled = false
        end
        
        -- Light: Kita matikan cuma yang bukan bawaan map
        -- Supaya suasana tetap terang
        if v:IsA("Light") and v.Name ~= "DefaultLight" then
            v.Enabled = false
        end
    end

    -- ✅ PASTIKAN TETAP TERANG
    if Workspace:FindFirstChild("Terrain") then
        Workspace.Terrain.WaterWaveSize = 0 -- Biar air gak berat
    end
end

-- Jalankan langsung saat load
boost()

-- Simpan ke Global supaya bisa dipanggil lagi
_G.boostFps = boost

return boost
