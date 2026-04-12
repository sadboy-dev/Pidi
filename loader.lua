-- LOADER.LUA - VERSI FIX GLOBAL
if _G.__LOADER then return end
_G.__LOADER = true

local BASE_URL = "https://raw.githubusercontent.com/sadboy-dev/Pidi/main/modules/"
local cacheBuster = "?v="..os.time() -- Paksa download baru

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

_G.Modules = {} -- Tempat nyimpen semua script

local function loadModule(filename)
    local link = BASE_URL .. filename .. cacheBuster
    local success, err = pcall(function()
        local code = game:HttpGet(link)
        -- Jalankan dan simpan hasilnya ke _G.Modules
        _G.Modules[filename] = loadstring(code)()
    end)

    if success and _G.Modules[filename] then
        print("✅ BERHASIL: " .. filename)
    else
        warn("❌ GAGAL: " .. filename)
        print("⚠️ Error: " .. tostring(err))
    end
end

for _, file in pairs(files) do
    loadModule(file)
    task.wait(0.1)
end

print("====================================")
print("✅ PROSES SELESAI!")
print("====================================")
