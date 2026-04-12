-- LOADER.LUA
-- LINK YANG BENAR SESUAI GITHUB

if _G.__LOADER then return end
_G.__LOADER = true

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
    local link = BASE_URL .. filename
    local success, err = pcall(function()
        local code = game:HttpGet(link)
        loadstring(code)()
    end)

    if success then
        print("✅ BERHASIL: " .. filename)
    else
        warn("❌ GAGAL: " .. filename .. " | " .. link)
    end
end

for _, file in pairs(files) do
    loadModule(file)
    task.wait(0.05)
end

print("====================================")
print("✅ PROSES SELESAI!")
print("====================================")
