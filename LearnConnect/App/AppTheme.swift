//
//  ViewController.swift
//  LearnConnect
//
//  Created by Alican TARIM on 19.12.2024.
//

import UIKit

class AppThemeManager {
    static let shared = AppThemeManager()
    
    private init() {}
    
    var isDarkMode: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isDarkMode")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isDarkMode")
            NotificationCenter.default.post(name: .darkModeChanged, object: nil)
        }
    }
}

extension Notification.Name {
    static let darkModeChanged = Notification.Name("darkModeChanged")
}

