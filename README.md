//
//  README.md
//  LearnConnect
//
//  Created by Alican TARIM on 26.12.2024.
//
## Learn Connect

**LearnConnect**, kullanıcıların kurslara kaydolabileceği, videoları izleyebileceği ve çevrimdışı olarak da içeriklere erişim sağlayabileceği modern bir eğitim platformudur.

---

## 🎯 İçindekiler
- [📱 Uygulama Özellikleri](#-uygulama-özellikleri)
- [🛠️ Kullanılan Teknolojiler ve Mimari](#️-kullanılan-teknolojiler-ve-mimari)
- [📦 Kurulum Adımları](#-kurulum-adımları)

## 🛠️ Uygulama Özellikleri
## 📱 Kullanıcı İşlemleri
- ✉️ **Kullanıcı Kayıt ve Giriş:** Kullanıcılar e-posta ve şifre ile kayıt olabilir ve giriş yapabilir.

## 📚 Kurs Yönetimi
- 📋 **Kurs Listeleme:** Tüm kurslar bir liste halinde gösterilir.
- 📌 **Kurslara Kayıt:** Kullanıcılar istediği kurslara kolayca kayıt olabilir.

## 🎥 Video Oynatıcı
- ▶️ **Ders Videolarını İzleme:** Kullanıcılar kaydolduğu kursların ders videolarını izleyebilir.
- ⏩ **Video Hız Kontrolü - Ekstra Özellik:** Kullanıcılar kaydolduğu kursların videolarını 1x, 1.5x, 2x şeklinde izleyebilir.
- 📥 **Offline Video İzleme - Ekstra Özellik:** Kullanıcılar videoları indirip internetsiz ortamda izleyebilir.

## 🌑 Dark Mode Desteği
- 🌙 **Karanlık Mod:** Kullanıcılar uygulamanın karanlık modunu aktif edebilir.

## 🛠️ Kullanılan Teknolojiler ve Mimari
### Teknolojiler:
 - Dil: Swift UIKit
 - Mimari: MVVM
- Veritabanı: UserDefaults
- Video Oynatıcı: AVPlayer

### Kullanılan Kütüphaneler:
- SnapKit

## 📦 Kurulum Adımları
### 1. Gereksinimler
- **Xcode 14+**
- **Swift 5.0+**
- **CocoaPods** veya **Swift Package Manager**

### 2. Projeyi Klonlayın
```bash
git clone https://github.com/alicantarim/LearnConnect-.git
cd LearnConnect
```

## 3. Bağımlılıkları Yükleyin

### Swift Package Manager (SPM)

1. Xcode üzerinden:
   - `File > Swift Packages > Add Package Dependency` menüsüne gidin.
2. Aşağıdaki kütüphaneleri ekleyin:
   - Snapkit SDK Yükleyin.

## 4. Projeyi Çalıştırın

1. `LearnConnect.xcworkspace` dosyasını Xcode'da açın.
2. Gerçek cihaz veya simülatörde projeyi başlatın.
