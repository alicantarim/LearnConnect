//
//  MainTabBarViewController.swift
//  LearnConnect
//
//  Created by Alican TARIM on 19.12.2024.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.hidesBackButton = true
        
        // Tabbar da kullanılacak ViewControllerin tanımlanması
        let vc1 = UINavigationController(rootViewController: FeedViewController())
        let vc2 = UINavigationController(rootViewController: FavoriteViewController())
        let vc3 = UINavigationController(rootViewController: ProfileViewController())
        let vc4 = UINavigationController(rootViewController: RegisterCourseViewController())
        
        // View controllerın image'lerinin verilmesi
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "star")
        vc3.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        vc4.tabBarItem.image = UIImage(systemName: "plus.rectangle.on.folder")
        
        // View controllerın Title'larının verilmesi
        vc1.title = "Anasayfa"
        vc2.title = "Favoriler"
        vc3.title = "Profil"
        vc4.title = "Kayıtlı Dersler"
        
        // Tabbar daki VC image'lerinin tintColor'larının verilmesi.
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc4, vc2, vc3], animated: true)
    }
    
}
