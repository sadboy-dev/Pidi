-- LOADER.LUA - VERSI FINAL & CEPAT
if _G.__LOADER then return end
_G.__LOADER = true

-- LINK GITHUB KAMU
local BASE_URL = "https://raw.githubusercontent.com/sadboy-dev/Pidi/main/modules/"

-- DAFTAR FILE YANG AKAN DI-DOWNLOAD
local FILES = {
    "getRole.lua"
    --"espPlayer.lua",
    --"boostFps.lua",
    --"ipadView.lua",
    --"crosshair.lua",
    -- "espGene.lua",
    -- "autoGen.lua"
}

print("====================================")
print("🔄 MEMUAT SCRIPT...")
print("====================================")

local function loadModule(name)
    local link = BASE_URL .. name .. "?t=" .. os.time() -- ⚡ ANTI CACHE
    
    local success, err = pcall(function()
        local code = game:HttpGet(link)
        loadstring(code)()
    end)

    if success then
        print("✅ " .. name)
    else
        warn("❌ " .. name .. " - GAGAL")
    end
end

-- DOWNLOAD & JALANKAN SEMUA
for _, file in pairs(FILES) do
    loadModule(file)
    task.wait(0.05) -- Sedikit jeda biar urut
end

print("====================================")
print("✅ LOADER SELESAI!")
print("====================================")

-- KITA PANGGIL MAIN.LUA LANGSUNG DISINI
loadModule("main.lua")
