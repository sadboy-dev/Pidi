-- LOADER.LUA - VERSI FINAL & CEPAT
if _G.__LOADER then return end
_G.__LOADER = true

-- loader.lua
local baseUrl = "https://raw.githubusercontent.com/sadboy-dev/Pidi/main/"   -- GANTI DENGAN REPO KAMU

-- Daftar modules yang ingin di-load (bisa tambah banyak)
local modulesToLoad = {
    "modules/getRole.lua",   -- fitur role
    -- "modules/esp.lua",
    -- "modules/autofarm.lua",
    -- tambahkan fitur lain di sini
}

-- Load semua modules terlebih dahulu
for _, path in ipairs(modulesToLoad) do
    local success, err = pcall(function()
        loadstring(game:HttpGet(baseUrl .. path))()
    end)
    
    if success then
        print("✅ Loaded:", path)
    else
        warn("❌ Loaded:", path, "| Error:", err)
    end
    task.wait(0.4)  -- jeda agar stabil
end


local mainSuccess, mainErr = pcall(function()
    loadstring(game:HttpGet(baseUrl .. "main.lua"))()
end)

if mainSuccess then
    print("🎉 Loader Success!")
else
    warn("❌ Gagal memuat main.lua:", mainErr)
end
