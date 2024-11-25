//
//  HomeViewController.swift
//  LearnConnect
//
//  Created by Alican TARIM on 25.11.2024.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tabbar da kullanılacak ViewControllerin tanımlanması
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: FavoriteViewController())
        let vc3 = UINavigationController(rootViewController: ProfileViewController())

        // View controllerın image'lerinin verilmesi
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "star")
        vc3.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        
        // View controllerın Title'larının verilmesi
        vc1.title = "Anasayfa"
        vc2.title = "Favoriler"
        vc3.title = "Profil"
        
        // Tabbar daki VC image'lerinin tintColor'larının verilmesi.
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2, vc3], animated: true)
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
