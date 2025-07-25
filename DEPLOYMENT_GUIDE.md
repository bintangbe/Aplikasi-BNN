# 📱 Aplikasi BNN Surabaya - Store Deployment Guide

## 🎯 **Informasi Aplikasi**
- **Nama**: BNN Surabaya
- **Package ID**: com.semanggi.bnnk_surabaya
- **Versi**: 1.0.0+1
- **Platform**: Android (Play Store) & iOS (App Store)

## 📋 **Struktur Project Clean**

### ✅ **Folder Penting (JANGAN DIHAPUS):**
- `android/` - Konfigurasi Play Store
- `ios/` - Konfigurasi App Store  
- `lib/` - Source code aplikasi
- `assets/` - Gambar dan resource
- `pubspec.yaml` - Dependencies

### ❌ **Folder yang Sudah Dibersihkan:**
- Documentation files (*.md)
- Platform folders (linux, macos, windows, web)
- Build cache (.dart_tool, build)
- Test files dan backup files
- Setup scripts (generate_icons.ps1, setup_icons.bat)

## 🚀 **Build Commands untuk Store**

### **1. Clean Build:**
```bash
flutter clean
flutter pub get
```

### **2. Play Store (Android):**
```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

### **3. App Store (iOS):**
```bash
flutter build ios --release
```
Kemudian buka Xcode untuk upload ke App Store Connect

## 📝 **Store Listing Info**

### **Deskripsi Singkat:**
"Aplikasi resmi BNN Surabaya untuk layanan rehabilitasi dan pencegahan narkoba"

### **Deskripsi Panjang:**
```
Aplikasi resmi Badan Narkotika Nasional Kota Surabaya yang menyediakan:

🎯 FITUR UTAMA:
• Peta persebaran lokasi rehabilitasi
• Pengajuan rehabilitasi online  
• E-book edukasi anti narkoba
• Informasi lembaga rehabilitasi
• Tracking status rehabilitasi

🏥 LAYANAN:
• Rehabilitasi rawat inap & rawat jalan
• Konsultasi profesional
• Pendampingan pemulihan
• Edukasi masyarakat

Mendukung program Surabaya bebas narkoba melalui teknologi digital yang mudah diakses.
```

### **Keywords:**
BNN Surabaya, rehabilitasi narkoba, pencegahan narkoba, kesehatan, layanan publik

### **Kategori:**
- Play Store: Medical
- App Store: Medical

## 🔑 **Requirements untuk Upload**

### **Play Store:**
1. Google Play Console account
2. App signing key
3. App icons (512x512 PNG)
4. Screenshots (phone & tablet)
5. Feature graphic (1024x500 PNG)
6. Privacy policy URL

### **App Store:**
1. Apple Developer account  
2. App Store Connect access
3. App icons (1024x1024 PNG)
4. Screenshots (all device sizes)
5. App preview video (optional)
6. Privacy policy URL

## 📊 **App Store Assets Needed**

### **Icons:**
- Android: 512x512 PNG (adaptive icon)
- iOS: 1024x1024 PNG (all sizes in Assets.xcassets)

### **Screenshots:**
- Android: Phone (1080x1920), Tablet (1200x1920)  
- iOS: iPhone (1290x2796), iPad (2048x2732)

### **Graphics:**
- Play Store: Feature graphic 1024x500 PNG
- App Store: App preview screenshots

## ⚡ **Quick Deploy Checklist**

- [ ] Clean project: `flutter clean && flutter pub get`
- [ ] Test app: `flutter run --release`
- [ ] Build Android: `flutter build appbundle --release`
- [ ] Build iOS: `flutter build ios --release`
- [ ] Prepare store assets (icons, screenshots)
- [ ] Create store listings
- [ ] Upload to stores
- [ ] Submit for review

## 🆘 **Troubleshooting**

### **Build Errors:**
```bash
# Clear all cache
flutter clean
flutter pub cache repair
flutter pub get

# Rebuild
flutter build appbundle --release
```

### **NDK Errors (Android):**
Check `android/app/build.gradle.kts` - NDK should not be explicitly set

### **iOS Build Issues:**
- Open iOS project in Xcode
- Check signing certificates
- Verify bundle identifier

---
**Ready for deployment! 🚀**
