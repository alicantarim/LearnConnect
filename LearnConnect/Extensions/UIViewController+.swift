//
//  UIViewController+.swift
//  LearnConnect
//
//  Created by Alican TARIM on 19.12.2024.
//

import UIKit
import SnapKit

extension UIViewController {
    
    var userEmail: String {
        get {
            return UserDefaults.standard.string(forKey: "userEmail") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userEmail")
        }
    }
    

}
