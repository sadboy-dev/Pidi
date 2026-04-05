-- features.lua
local Features = {

    {
        Name = "Main",
        Items = {
            {
                Text = "Auto Farm",
                Func = function()
                    print("Auto Farm clicked")
                end
            },
            {
                Text = "Auto Quest",
                Func = function()
                    print("Auto Quest clicked")
                end
            }
        }
    },

    {
        Name = "Player",
        Items = {
            {
                Text = "Infinite Jump",
                Func = function()
                    print("Infinite Jump clicked")
                end
            },
            {
                Text = "No Clip",
                Func = function()
                    print("No Clip clicked")
                end
            }
        }
    },

    {
        Name = "Visual",
        Items = {
            {
                Text = "ESP Player",
                Func = function()
                    print("ESP Player clicked")
                end
            },
            {
                Text = "ESP Item",
                Func = function()
                    print("ESP Item clicked")
                end
            }
        }
    },

    {
        Name = "Teleport",
        Items = {
            {
                Text = "Teleport Spawn",
                Func = function()
                    print("Teleport Spawn clicked")
                end
            },
            {
                Text = "Teleport Island",
                Func = function()
                    print("Teleport Island clicked")
                end
            }
        }
    }

}

return Features
