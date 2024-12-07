//
//  SignInViewController.swift
//  LearnConnect
//
//  Created by Alican TARIM on 25.11.2024.
//

import UIKit
import FirebaseAuth
import CoreData

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Core Data Kullanılacak.
        
        self.emailTextField.imageSetup(imageNamed: "mail.stack")
        self.passwordTextField.imageSetup(imageNamed: "lock.fill")
        
//        signInButton.layer.cornerRadius = 10
//        signInButton.layer.masksToBounds = true
//
//        emailTextField.layer.cornerRadius = 10
//        emailTextField.layer.masksToBounds = true
//        passwordTextField.layer.cornerRadius = 10
//        passwordTextField.layer.masksToBounds = true
        
        signInButton.cornerRadius(radius: 10)
        emailTextField.cornerRadius(radius: 20)
        passwordTextField.cornerRadius(radius: 20)
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
                // Navigation Create User.
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        print("ℹ️ Bilgi: \(error.localizedDescription)")
                        UtilityFunction().simpleAlert(vc: self, title: "UYARI!", message: error.localizedDescription)
                    } else {
                        print("✅ Kullanıcı Oluşturuldu.")
                        
                        let currentUser = Auth.auth().currentUser
                        
                        if let userEmail = currentUser?.email {
                            
                            // MARK: Core Data Ayarlarının Yapılandırılması
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            let context = appDelegate.persistentContainer.viewContext
                            let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
                            let newUser = NSManagedObject(entity: entity!, insertInto: context)
                            
                            // MARK: CoreData'ya veri aktarımı.
                            //newUser.setValue(userUID, forKey: "useruid")
                            newUser.setValue(userEmail, forKey: "useremail")
                            
                            do {
                                try context.save()
                                print("✅ Kullanıcı bilgileri CoreData'ya aktarıldı.")
                            } catch {
                                print("🚨 Posting to database failed.")
                            }
                            
                            // MARK: CoreData'dan verilerin okunması.
                            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
                            request.returnsObjectsAsFaults = false
                            
                            do {
                                let result = try context.fetch(request)
                                print("🔋 CORE DATA KAYITLI KULLANICI BİLGİLERİ")
                                for data in result as! [NSManagedObject] {
                                    if let userEmail = data.value(forKey: "useremail") as? String {
                                        print("👨🏼‍💻 Kullanıcı Email: \(userEmail)")
                                        //print("🆔 Kullanıcı UID  : \(userUid)")
                                        print("")
                                    } else {
                                        print("⚠️ 'useremail' alanı boş.")
                                    }
                                }
                            } catch {
                                print("‼️ Fetch Failed!!")
                            }
                            
                            // MARK: Core Data Tüm verilerin silinmesi
            //                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            //                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            //
            //                do {
            //                    try context.execute(batchDeleteRequest)
            //                    try context.save()
            //                    print("✅ Tüm kayıtlar başarıyla silindi.")
            //                } catch {
            //                    print("🚨 Kayıtları silerken hata oluştu: \(error.localizedDescription)")
            //                }
                        }

                        // If the login is successful, the MainTabbarViewController opens.
                        let homePageVC = MainTabBarViewController()
                        homePageVC.modalPresentationStyle = .fullScreen
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
