-- MAIN.LUA
if _G.__MAIN then return end
_G.__MAIN = true

-- TUNGGU SIAP
repeat task.wait() until _G.getRole and _G.espPlayer and _G.boostFps and _G.ipadView
task.wait(0.5)

print("====================================")
print("✅ SEMUA FITUR DIAKTIFKAN")
print("====================================")

-- JALANKAN SEMUA
_G.boostFps()
_G.ipadView()
_G.espPlayer.Start() -- PAKAI TITIK SATU (.)
