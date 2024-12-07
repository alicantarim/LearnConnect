//
//  SceneDelegate.swift
//  LearnConnect
//
//  Created by Alican TARIM on 22.11.2024.
//

import UIKit
import Firebase
import FirebaseAuth
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // let _ yerine sceen olarak veriyoruz.
        guard let sceen = (scene as? UIWindowScene) else { return }
        window = .init(windowScene: sceen)
        window?.makeKeyAndVisible()
        
        // currentUser: Güncel kullanıcı bilgisini alıyoruz.
        let currentUser = Auth.auth().currentUser
            
        if currentUser != nil {
            let tabController = MainTabBarViewController()
            print("👉🏼 TabBar Açılıyor.")
            if let userUID = currentUser?.uid, let userEmail = currentUser?.email {
                print("👨🏼‍💻 Kullanıcı Email: \(userEmail)")
                print("🆔 Kullanıcı UID  : \(userUID)")
                window?.rootViewController = tabController
            }
        } else {
            print("LoginView Açılıyor.")
            window?.rootViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
//            let vc = MockViewController(nibName: "MockViewController", bundle: nil)
//            vc.view.backgroundColor = .blue
//            self.window?.rootViewController = vc
//        })
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

