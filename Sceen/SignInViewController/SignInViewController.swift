//
//  SignInViewController.swift
//  LearnConnect
//
//  Created by Alican TARIM on 25.11.2024.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.layer.cornerRadius = 10
        signInButton.layer.masksToBounds = true

        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.masksToBounds = true
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.masksToBounds = true
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            signInUser(email: email, password: password)
        }
    }
    
    func signInUser(email: String, password: String) {
        // Email Validation
        if email == "" && password == "" {
            UtilityFunction().simpleAlert(vc: self, title: "UYARI!", message: "Lütfen e-mail ve şifre giriniz.")
        } else {
            if !email.isValidEmail(email: email) {
                UtilityFunction().simpleAlert(vc: self, title: "UYARI!", message: "Lütfen geçerli bir e-mail giriniz.")
            } else if !password.isValidPassword(password: password) {
                UtilityFunction().simpleAlert(vc: self, title: "UYARI!", message: "Lütfen geçerli bir şifre giriniz")
            } else {
                // Navigation
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        print("Bilgi: \(error.localizedDescription)")
                        UtilityFunction().simpleAlert(vc: self, title: "UYARI!", message: error.localizedDescription)
                    } else {
                        print("Kullanıcı Oluşturuldu.")
                        let homePageVC = MainTabBarViewController()
                        self.present(homePageVC, animated: true)
                    }
                }
            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
