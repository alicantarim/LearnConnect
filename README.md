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
- 🔑 **Kullanıcı Şifre Sıfırlama:** Kullanıcılar e-posta ile şifre sıfırlama bağlantısı gönderebilir.

## 📚 Kurs Yönetimi
- 📋 **Kurs Listeleme:** Tüm kurslar bir liste halinde gösterilir.
- 📌 **Kurslara Kayıt:** Kullanıcılar istediği kurslara kolayca kayıt olabilir.

## 🎥 Video Oynatıcı
- ▶️ **Ders Videolarını İzleme:** Kullanıcılar kaydolduğu kursların ders videolarını izleyebilir.
- ⏩ **Video Hız Kontrolü - Ekstra Özellik:** Kullanıcılar kaydolduğu kursların videolarını 1x, 1.5x, 2x şeklinde izleyebilir.
- 💾 **İlerleme Kaydı:** Video izleme ilerlemesi local olarak kaydedilir ve kaldığı yerden devam edilebilir.
- 📥 **Offline Video İzleme - Ekstra Özellik:** Kullanıcılar videoları indirip internetsiz ortamda izleyebilir.

## 🌑 Dark Mode Desteği
- 🌙 **Karanlık Mod:** Kullanıcılar uygulamanın karanlık modunu aktif edebilir.

## 🛠️ Kullanılan Teknolojiler ve Mimari
### Teknolojiler:
 - Dil: Swift UIKit
 - Mimari: MVVM
- Veritabanı: CoreData
- Video Oynatıcı: AVPlayer

### Kullanılan Kütüphaneler:
- Firebase: Kullanıcı Login ve Register işlemleri için.

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

## 3. Firebase Kurulumu

### Firebase Console'da Proje Oluşturma

1. [Firebase Console](https://console.firebase.google.com/) üzerinden yeni bir proje oluşturun.
2. iOS uygulaması ekleyin ve gerekli bilgileri doldurun (Bundle ID vb.).
3. `GoogleService-Info.plist` dosyasını indirin.

### Firebase Servislerini Aktif Etme

1. **Authentication** sekmesinden "Email/Password" seçeneğini etkinleştirin.

## 4. Bağımlılıkları Yükleyin

### CocoaPods

```bash
pod install
```

### Swift Package Manager (SPM)

1. Xcode üzerinden:
   - `File > Swift Packages > Add Package Dependency` menüsüne gidin.
2. Aşağıdaki kütüphaneleri ekleyin:
   - [Firebase](https://github.com/firebase/firebase-ios-sdk): https://github.com/firebase/firebase-ios-sdk

## 5. Projeyi Çalıştırın

1. `LearnConnect.xcworkspace` dosyasını Xcode'da açın.
2. Gerçek cihaz veya simülatörde projeyi başlatın.
