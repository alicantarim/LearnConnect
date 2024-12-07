//
//  ProfileViewController.swift
//  LearnConnect
//
//  Created by Alican TARIM on 25.11.2024.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logOutButton.layer.cornerRadius = 10
        logOutButton.layer.masksToBounds = true
        
        let currentUser = Auth.auth().currentUser
        
        userNameLabel.text = currentUser?.email

        // Do any additional setup after loading the view.
    }
    
    func createTabbar() {
        
    }

    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            let loginPageVC = LoginViewController()
            loginPageVC.modalPresentationStyle = .fullScreen
            self.present(loginPageVC, animated: true)
        } catch {
            print(error.localizedDescription)
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
