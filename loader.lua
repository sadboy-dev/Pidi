-- LOADER.LUA
if _G.__LOADER then return end
_G.__LOADER = true

local BASE_URL = "https://raw.githubusercontent.com/sadboy-dev/Pidi/main/modules/"
local cacheBuster = "?v="..os.time()

local files = {
    "getRole.lua",
    "boostFps.lua",
    "ipadView.lua",
    "crosshair.lua",
    "esp.lua"
}

print("📂 LOADING MODULES...")

local function loadModule(filename)
    local link = BASE_URL .. filename .. cacheBuster
    local success, err = pcall(function()
        local code = game:HttpGet(link)
        loadstring(code)()
    end)
    if success then
        print("✅ " .. filename)
    else
        warn("❌ " .. filename)
    end
end

for _, file in pairs(files) do
    loadModule(file)
    task.wait(0.1)
end

print("✅ LOADER SELESAI!")
