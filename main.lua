-- Load UI kamu
local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/sadboy-dev/UI/refs/heads/main/Jriik/UI.lua"))()

-- Load fitur list
local Features = loadstring(game:HttpGet("https://raw.githubusercontent.com/sadboy-dev/Pidi/refs/heads/main/features.lua"))()

-- Simpan tab biar gak dobel
local Tabs = {}

-- Function buat / ambil tab
local function getTab(category)
    if not Tabs[category] then
        Tabs[category] = UI:CreateTab(category)
    end
    return Tabs[category]
end

-- Loop semua fitur
for _, feature in pairs(Features.List) do
    local tab = getTab(feature.Category)

    if feature.Type == "Button" then
        tab:AddButton({
            Title = feature.Name,
            Description = feature.Description,
            Callback = function()
                print(feature.Name .. " clicked")
            end
        })

    elseif feature.Type == "Toggle" then
        tab:AddToggle({
            Title = feature.Name,
            Description = feature.Description,
            Default = false,
            Callback = function(state)
                print(feature.Name .. ": " .. tostring(state))
            end
        })
    end
end
