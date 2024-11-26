//
//  LoginViewController.swift
//  LearnConnect
//
//  Created by Alican TARIM on 22.11.2024.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // view.backgroundColor = #colorLiteral(red: 0.9875870347, green: 0.8211963177, blue: 0.3359964192, alpha: 1)
        self.emailTextField.imageSetup(imageNamed: "mail.stack")
        self.passwordTextField.imageSetup(imageNamed: "lock.fill")
        
        loginButton.layer.cornerRadius = 10
        loginButton.layer.masksToBounds = true
        signInButton.layer.cornerRadius = 10
        signInButton.layer.masksToBounds = true
        
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.masksToBounds = true
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.masksToBounds = true
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            registerUser(email: email, password: password)
        }
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        let signInPageVC = SignInViewController()
        signInPageVC.modalPresentationStyle = .fullScreen
        self.present(signInPageVC, animated: true)
    }
    
    
    func registerUser(email: String, password: String) {
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
                Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authdata, error in
                    if let error = error {
                        print("Bilgi: \(error.localizedDescription)")
                        UtilityFunction().simpleAlert(vc: self, title: "UYARI!", message: error.localizedDescription)
                    } else {
                        print("Kullanıcı Oluşturuldu.")
                        let homePageVC = MainTabBarViewController()
                        homePageVC.modalPresentationStyle = .fullScreen
                        self.present(homePageVC, animated: true)
                    }
                }
            }
        }
    }
}

// TextField Icon
extension UITextField {
    // TextField Image Setup
    func imageSetup(imageNamed: String) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageView.image = UIImage(systemName: imageNamed)
        let imageContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageContainerView.addSubview(imageView)
        leftView = imageContainerView
        leftViewMode = .always
        self.tintColor = .black
    }
    
    func cornerRadius(radius: CGFloat) {
        let radius = layer.cornerRadius = radius
        let bounds = layer.masksToBounds = true
        
    }
}

// Valid Email and Password
extension String {
    
    // abc@gmail.com, hello@yahoo.com
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0,-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }
    
    // - Password length 6 to 16.
    // One Alphabet in Password.
    // One Special Character in Password.
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,16}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        let result = passwordTest.evaluate(with: password)
        return result
    }
}
