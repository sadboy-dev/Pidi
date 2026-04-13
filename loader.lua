-- LOADER.LUA - VERSI FINAL & CEPAT
if _G.__LOADER then return end
_G.__LOADER = true

-- loader.lua
print("🚀 LOADER MULAI - Loading semua modules dari GitHub...")

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
        print("✅ Module loaded:", path)
    else
        warn("❌ Gagal load module:", path, "| Error:", err)
    end
    task.wait(0.4)  -- jeda agar stabil
end

print("✅ SEMUA MODULES DARI FOLDER modules/ TELAH DI-LOAD")

-- Setelah semua modules siap, baru load main.lua sebagai base
print("🔄 Memuat main.lua sebagai central base...")

local mainSuccess, mainErr = pcall(function()
    loadstring(game:HttpGet(baseUrl .. "main.lua"))()
end)

if mainSuccess then
    print("🎉 LOADER SELESAI! main.lua sekarang berjalan sebagai base.")
else
    warn("❌ Gagal memuat main.lua:", mainErr)
end
