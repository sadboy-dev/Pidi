-- MAIN.LUA
if _G.__MAIN then return end
_G.__MAIN = true

-- TUNGGU SEMUA MODUL SIAP
repeat task.wait() until _G.getRole and _G.espPlayer and _G.boostFps and _G.ipadView
task.wait(0.5)

print("====================================")
print("✅ SEMUA FITUR DIAKTIFKAN")
print("====================================")

-- ==============================================
-- ✅ NYALAKAN SEMUA FITUR (ALL ROLE)
-- ==============================================
-- Boost FPS & iPad View
_G.boostFps()
_G.ipadView()

-- ESP (SEKARANG NYALA TERUS, GAK PEDULI ROLE)
_G.espPlayer:Start()

-- ==============================================
-- SELESAI, TIDAK PERLU LOOP LAGI
-- ==============================================
print("🚀 SCRIPT BERJALAN PENUH!")
