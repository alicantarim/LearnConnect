//
//  ProfileViewController.swift
//  LearnConnect
//
//  Created by Alican TARIM on 19.12.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var loginButton = {
        let btn = UIButton()
        btn.setTitle("Çıkış Yap", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.backgroundColor = .systemBlue
        btn.addTarget(self, action: #selector(logOutButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    private lazy var darkModeSwitch = UISwitch()
    private lazy var darkModeLabel: UILabel = {
        let label = UILabel()
        label.text = "Dark Mode"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        configureDarkMode()
    }
    
    private func setupUI(){
        view.backgroundColor = .systemBackground
        view.addSubview(loginButton)
        view.addSubview(darkModeSwitch)
        view.addSubview(darkModeLabel)
        
        darkModeSwitch.addTarget(self, action: #selector(darkModeSwitchToggled(_:)), for: .valueChanged)
    }
    
    private func setupConstraints(){
        loginButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(600)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(60)
        }
        
        darkModeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().inset(24)
        }
                
        darkModeSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(darkModeLabel.snp.centerY)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(30)
        }
    }
    
    private func configureDarkMode() {
        // Kullanıcının önceki ayarını kontrol et ve uygula
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        darkModeSwitch.isOn = isDarkMode
        updateInterfaceStyle(isDarkMode: isDarkMode)
    }
        
    private func saveDarkModePreference(isDarkMode: Bool) {
        UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        UserDefaults.standard.synchronize()
    }
        
    private func updateInterfaceStyle(isDarkMode: Bool) {
        overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        view.backgroundColor = isDarkMode ? .black : .white
        darkModeLabel.textColor = isDarkMode ? .white : .black
    }
        
    @objc private func darkModeSwitchToggled(_ sender: UISwitch) {
        let isDarkMode = sender.isOn
        saveDarkModePreference(isDarkMode: isDarkMode)
        updateInterfaceStyle(isDarkMode: isDarkMode)
        AppThemeManager.shared.isDarkMode = sender.isOn //
    }
    
    func saveLoginStatus(isLoggedIn: Bool) {
        UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize() // Opsiyonel, ancak bazen hemen kaydetmek için kullanılır.
    }
    
    func logoutUser() {
        print("logOut a basıldı.")
        saveLoginStatus(isLoggedIn: false)
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen // Tam ekran yapmak için
        present(vc, animated: true, completion: nil)

    }
    
    @objc func logOutButtonClicked() {
        logoutUser()
    }
}
