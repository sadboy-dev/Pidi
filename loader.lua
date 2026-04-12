-- LOADER.LUA - VERSI ORI FIX
if _G.__LOADER then return end
_G.__LOADER = true

local BASE_URL = "https://raw.githubusercontent.com/sadboy-dev/Pidi/main/modules/"
local cacheBuster = "?v="..os.time() -- Paksa download baru biar gak cache

local files = {
    "getRole.lua",
    "boostFps.lua",
    "ipadView.lua",
    "crosshair.lua",
    "esp.lua"
}

print("====================================")
print("📂 LOADER: MEMUAT SEMUA MODULES...")
print("====================================")

local function loadModule(filename)
    local link = BASE_URL .. filename .. cacheBuster
    local success, err = pcall(function()
        local code = game:HttpGet(link)
        loadstring(code)() -- JALANKAN LANGSUNG
    end)

    if success then
        print("✅ BERHASIL: " .. filename)
    else
        warn("❌ GAGAL: " .. filename)
    end
end

for _, file in pairs(files) do
    loadModule(file)
    task.wait(0.1)
end
print("File esp.lua")
print("====================================")
print("✅ PROSES SELESAI!")
print("====================================")
