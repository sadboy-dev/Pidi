-- features.lua
local Features = {}

Features.List = {

    -- MAIN
    {
        Category = "Main",
        Type = "Button",
        Name = "Auto Farm",
        Description = "Farming otomatis"
    },
    {
        Category = "Main",
        Type = "Button",
        Name = "Auto Quest",
        Description = "Auto ambil quest"
    },

    -- PLAYER
    {
        Category = "Player",
        Type = "Toggle",
        Name = "Infinite Jump",
        Description = "Loncat tanpa batas"
    },
    {
        Category = "Player",
        Type = "Toggle",
        Name = "No Clip",
        Description = "Tembus tembok"
    },

    -- VISUAL
    {
        Category = "Visual",
        Type = "Toggle",
        Name = "ESP Player",
        Description = "Lihat player"
    },
    {
        Category = "Visual",
        Type = "Toggle",
        Name = "ESP Item",
        Description = "Lihat item"
    },

    -- TELEPORT
    {
        Category = "Teleport",
        Type = "Button",
        Name = "Teleport Spawn",
        Description = "Ke spawn"
    },
    {
        Category = "Teleport",
        Type = "Button",
        Name = "Teleport Island",
        Description = "Ke island"
    }
}

return Features
