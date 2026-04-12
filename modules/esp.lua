local module = {}

function module.Start()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer

    --------------------------------------------------
    -- 🎭 ROLE DETECTION
    --------------------------------------------------
    local function getRole(plr)
        if plr.Team then
            local name = plr.Team.Name:lower()

            if name:find("killer") then
                return "KILLER"
            elseif name:find("survivor") then
                return "SURVIVOR"
            end
        end
        return "UNKNOWN"
    end

    --------------------------------------------------
    -- 🔍 GET VALID CHARACTER MODEL
    --------------------------------------------------
    local function getCharacterModel(char)
        -- pastikan ada humanoid (biar bukan fake model)
        if char and char:FindFirstChildOfClass("Humanoid") then
            return char
        end
        return nil
    end

    --------------------------------------------------
    -- ✨ APPLY ESP (SUPER SAFE)
    --------------------------------------------------
    local function applyESP(plr)
        if plr == player then return end

        local char = plr.Character
        local model = getCharacterModel(char)
        if not model then return end

        -- cek apakah sudah ada
        local h = model:FindFirstChild("ESP")
        if not h then
            h = Instance.new("Highlight")
            h.Name = "ESP"
            h.FillTransparency = 0.5
            h.OutlineTransparency = 0
            h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            h.Parent = model
        end

        -- update warna langsung
        local role = getRole(plr)

        if role == "KILLER" then
            h.FillColor = Color3.fromRGB(255,0,0)
        elseif role == "SURVIVOR" then
            h.FillColor = Color3.fromRGB(0,170,255)
        else
            h.FillColor = Color3.fromRGB(255,255,255)
        end
    end

    --------------------------------------------------
    -- 🔁 LOOP RINGAN (TANPA BUG)
    --------------------------------------------------
    RunService.Heartbeat:Connect(function()
        for _,plr in ipairs(Players:GetPlayers()) do
            applyESP(plr)
        end
    end)
end

return module
