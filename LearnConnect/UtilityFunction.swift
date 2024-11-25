//
//  UtilityFunction.swift
//  LearnConnect
//
//  Created by Alican TARIM on 25.11.2024.
//

import UIKit

class UtilityFunction: NSObject {
    
    func simpleAlert(vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        vc.present(alert, animated: true, completion: nil)
    }
    
    
}
