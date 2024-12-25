//
//  LoginViewController.swift
//  LearnConnect
//
//  Created by Alican TARIM on 19.12.2024.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    private lazy var logoImage = {
        let img = UIImageView()
        img.layer.cornerRadius = 8
        img.image = UIImage(named: "LearnConnect")
        img.contentMode = .scaleAspectFit
//        img.layer.borderColor = UIColor.black.cgColor
//        img.layer.borderWidth = 1
        return img
    }()
    
    private lazy var emailTextField = {
        let tf = UITextField()
        tf.placeholder = "Lütfen Email Adresinizi Giriniz."
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        //        tf.font = .systemFont(ofSize: 15)
        tf.layer.borderColor = UIColor.black.cgColor
        tf.textColor = .black
        tf.layer.cornerRadius = 20
        tf.delegate = self
        tf.addDoneButtonOnKeyboard()
        return tf
    }()
    
    private lazy var passwordTextField = {
        let tf = UITextField()
        tf.placeholder = "Lütfen Şifrenizi Giriniz."
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.layer.borderColor = UIColor.black.cgColor
        //        tf.font = .systemFont(ofSize: 15)
        tf.textColor = .black
        tf.layer.cornerRadius = 20
        tf.delegate = self
        tf.addDoneButtonOnKeyboard()
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var loginButton = {
        let btn = UIButton()
        btn.setTitle("Kayıt Ol", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 16
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.backgroundColor = .systemBlue
        btn.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    private var emailText = "" {
        didSet {
            print("Email:",emailText)
        }
    }
    
    private var passwordText = "" {
        didSet {
            print("password:", passwordText )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.imageSetup(imageNamed: "mail.stack")
        passwordTextField.imageSetup(imageNamed: "lock.fill")
        emailTextField.cornerRadius(radius: 16)
        passwordTextField.cornerRadius(radius: 16)
        setupUI()
        setupConstraints()

    }
    
    private func setupUI(){
        view.backgroundColor = UIColor(hex: "#F5D36B")
        view.addSubview(logoImage)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
    }
    
    private func setupConstraints(){
        
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(250)
            make.width.equalTo(250)
        }
        
        emailTextField.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(300)
            make.top.equalTo(logoImage.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(50)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(50)
        }
    }
    
    //    MARK: User Interactions
    @objc func loginButtonClicked() {
        UserDefaults.standard.set(emailText, forKey: "userEmail")
        saveLoginStatus(isLoggedIn: true)
        let vc = MainTabBarViewController()
        //navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen // Tam ekran yapmak için
        present(vc, animated: true, completion: nil)
    }
    
    //MARK: - UserDefault a Bool değerini kaydeder.
    func saveLoginStatus(isLoggedIn: Bool) {
        UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize() // Opsiyonel, ancak bazen hemen kaydetmek için kullanılır.
    }
    
}

//        MARK: TextField Delegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.emailText = self.emailTextField.text ?? ""
        self.passwordText = self.passwordTextField.text ?? ""
    }
}
