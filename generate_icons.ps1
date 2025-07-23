# Script PowerShell untuk Generate Ikon Aplikasi BNN Surabaya
# Pastikan ImageMagick sudah terinstall: https://imagemagick.org/script/download.php#windows

$logoPath = "assets/images/logo_bnn.png"
$tempDir = "temp_icons"

Write-Host "=== GENERATOR IKON APLIKASI BNN SURABAYA ===" -ForegroundColor Green

# Cek apakah logo ada
if (!(Test-Path $logoPath)) {
    Write-Host "❌ File logo tidak ditemukan: $logoPath" -ForegroundColor Red
    exit 1
}

# Buat folder temporary
if (!(Test-Path $tempDir)) {
    New-Item -ItemType Directory -Path $tempDir | Out-Null
}

Write-Host "📱 Generating Android Icons..." -ForegroundColor Yellow

# Android Icons
$androidSizes = @{
    "mipmap-mdpi" = 48
    "mipmap-hdpi" = 72
    "mipmap-xhdpi" = 96
    "mipmap-xxhdpi" = 144
    "mipmap-xxxhdpi" = 192
}

foreach ($density in $androidSizes.Keys) {
    $size = $androidSizes[$density]
    $outputPath = "android/app/src/main/res/$density/ic_launcher.png"
    
    try {
        magick convert $logoPath -resize "${size}x${size}" $outputPath
        Write-Host "✅ Generated: $outputPath (${size}x${size})" -ForegroundColor Green
    }
    catch {
        Write-Host "❌ Failed to generate: $outputPath" -ForegroundColor Red
        Write-Host "    Install ImageMagick first: https://imagemagick.org/script/download.php#windows" -ForegroundColor Red
    }
}

Write-Host "🖥️ Generating Windows Icon..." -ForegroundColor Yellow

# Windows Icon (ICO format dengan multiple sizes)
try {
    $icoSizes = "16,32,48,64,128,256"
    magick convert $logoPath -define icon:auto-resize=$icoSizes "windows/runner/resources/app_icon.ico"
    Write-Host "✅ Generated: windows/runner/resources/app_icon.ico" -ForegroundColor Green
}
catch {
    Write-Host "❌ Failed to generate Windows icon" -ForegroundColor Red
    Write-Host "    Install ImageMagick first: https://imagemagick.org/script/download.php#windows" -ForegroundColor Red
}

Write-Host "🍎 For iOS Icons..." -ForegroundColor Yellow
Write-Host "   Please use online generator like AppIcon.co or Icon.kitchen" -ForegroundColor Cyan
Write-Host "   Upload $logoPath and replace files in ios/Runner/Assets.xcassets/AppIcon.appiconset/" -ForegroundColor Cyan

Write-Host ""
Write-Host "🔧 Next Steps:" -ForegroundColor Magenta
Write-Host "   1. flutter clean" -ForegroundColor White
Write-Host "   2. flutter build windows" -ForegroundColor White  
Write-Host "   3. flutter build apk" -ForegroundColor White
Write-Host ""
Write-Host "✨ Done! Your BNN Surabaya app icons are ready!" -ForegroundColor Green

# Cleanup
if (Test-Path $tempDir) {
    Remove-Item -Recurse -Force $tempDir
}
