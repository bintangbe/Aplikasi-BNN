@echo off
echo ========================================
echo   BNN SURABAYA - IKON GENERATOR MANUAL
echo ========================================
echo.

echo 📋 PANDUAN LENGKAP MENGGANTI IKON APLIKASI:
echo.

echo 🔧 OPTION 1 - AUTOMATIC (Jika punya ImageMagick):
echo    Run: powershell -ExecutionPolicy Bypass -File generate_icons.ps1
echo.

echo 🛠️  OPTION 2 - MANUAL:
echo.

echo 📱 ANDROID ICONS:
echo    Buat 5 file PNG dari assets/images/logo_bnn.png dengan ukuran:
echo    - android/app/src/main/res/mipmap-mdpi/ic_launcher.png    (48x48)
echo    - android/app/src/main/res/mipmap-hdpi/ic_launcher.png    (72x72)
echo    - android/app/src/main/res/mipmap-xhdpi/ic_launcher.png   (96x96)
echo    - android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png  (144x144)
echo    - android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png (192x192)
echo.

echo 🖥️  WINDOWS ICON:
echo    Konversi logo_bnn.png ke ICO format online:
echo    - Kunjungi: https://convertio.co/png-ico/
echo    - Upload: assets/images/logo_bnn.png
echo    - Download dan ganti: windows/runner/resources/app_icon.ico
echo.

echo 🍎 iOS ICONS:
echo    Gunakan AppIcon Generator online:
echo    - Kunjungi: https://appicon.co/
echo    - Upload: assets/images/logo_bnn.png
echo    - Download dan extract ke: ios/Runner/Assets.xcassets/AppIcon.appiconset/
echo.

echo ✅ YANG SUDAH DIKONFIGURASI:
echo    - Windows: Window title "BNN Surabaya - Aplikasi Anti Narkoba"
echo    - Android: App name "BNN Surabaya"
echo    - iOS: App name "BNN Surabaya"
echo.

echo 🚀 SETELAH SELESAI, REBUILD APLIKASI:
echo    flutter clean
echo    flutter build windows
echo    flutter build apk
echo.

echo 📞 Jika ada masalah, hubungi developer!
echo.
pause
