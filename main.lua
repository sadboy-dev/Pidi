-- =============================================
-- LOAD FEATURES (GLOBAL)
-- =============================================
getgenv().Features = loadstring(game:HttpGet("https://raw.githubusercontent.com/sadboy-dev/Pidi/refs/heads/main/features.lua"))()

-- =============================================
-- VALIDASI FEATURES
-- =============================================
if type(Features) ~= "table" then
    warn("Features gagal diload atau bukan table!")
    return
end

print("Features berhasil diload!")

-- =============================================
-- LOAD UI
-- =============================================
loadstring(game:HttpGet("https://raw.githubusercontent.com/sadboy-dev/UI/refs/heads/main/Jriik/UI.lua"))()

-- =============================================
-- INFO
-- =============================================
print("UI berhasil dijalankan!")
