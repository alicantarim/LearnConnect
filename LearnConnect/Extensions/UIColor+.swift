//
//  UIColor+.swift
//  LearnConnect
//
//  Created by Alican TARIM on 25.12.2024.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        // 1. Girdiyi temizle (boşluklar ve yeni satır karakterlerini sil)
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // 2. Eğer hex değeri "#" ile başlıyorsa, "#" işaretini kaldır
        hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized
        
        // 3. Hex string'i UInt64'e dönüştürmek için bir değişken tanımla
        var rgb: UInt64 = 0
        
        // 4. Hex string'ini tarayıp `rgb` değişkenine dönüştür
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        // 5. Renk bileşenlerini (kırmızı, yeşil, mavi) hesapla
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        // 6. UIColor'ı oluştur
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
