-- LOADER.LUA - VERSI FIX & FORCE UPDATE
if _G.__LOADER then return end
_G.__LOADER = true

-- TAMBAH INI BIAR SELALU DOWNLOAD VERSI BARU (BYPASS CACHE DELTA)
local cacheBuster = "?t=" .. os.time()

-- LINK YANG BENAR (PASTI BISA)
local BASE_URL = "https://raw.githubusercontent.com/sadboy-dev/Pidi/main/modules/"

local files = {
    "getRole.lua",
    "boostFps.lua",
    "ipadView.lua",
    "crosshair.lua",
    "espPlayer.lua"
}

print("====================================")
print("📂 LOADER: MEMUAT SEMUA MODULES...")
print("====================================")

local function loadModule(filename)
    local link = BASE_URL .. filename .. cacheBuster -- Tambah pembeda waktu
    local success, err = pcall(function()
        local code = game:HttpGet(link)
        loadstring(code)()
    end)

    if success then
        print("✅ BERHASIL: " .. filename)
    else
        warn("❌ GAGAL: " .. filename)
        print("🔗 Link: " .. link) -- Cek link ini di browser kalau error
    end
end

for _, file in pairs(files) do
    loadModule(file)
    task.wait(0.1)
end

print("====================================")
print("✅ PROSES SELESAI!")
print("====================================")
