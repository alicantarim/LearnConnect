//
//  HomeViewViewController.swift
//  LearnConnect
//
//  Created by Alican TARIM on 25.11.2024.
//

import UIKit
import AVKit
import AVFoundation
import FirebaseAuth
import CoreData


struct MockData: Codable {
    let lessonId: Int
    let title: String
    let description: String
    let urlString: String
}

class HomeViewController: UIViewController {
    
    let currentUser = Auth.auth().currentUser
    var context: NSManagedObjectContext?
    
    var mockDatas: [MockData] = [
        .init(lessonId: 0,
              title: "Big Buck Bunny",
              description: "Big Buck Bunny tells the story of a giant rabbit with a heart bigger than himself. Licensed under the Creative Commons Attribution license www.bigbuckbunny.",
              urlString: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"),
        .init(lessonId: 1,
              title: "Elephant Dream",
              description: "The first Blender Open Movie from 2006. For when you want to settle into your Iron Throne to watch the latest episodes.",
              urlString: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"),
        .init(lessonId: 2,
              title: "For Bigger Blazes",
              description: "HBO GO now works with Chromecast. The easiest way to enjoy online video and music on your TV—for when Batman's escapes aren't quite big enough. For $35.",
              urlString: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"),
        .init(lessonId: 3,
              title: "For Bigger Escape",
              description: "Introducing Chromecast. The easiest way to enjoy online video and music on your TV. For $35. Find out more at google.com/chromecast.",
              urlString: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")
    ]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var playerViewController = AVPlayerViewController()
    var playerView = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if context == nil {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            context = appDelegate.persistentContainer.viewContext
        }
        

        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        
        // Create NIB
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        // videoCell -> cell identifier
        tableView.register(nib, forCellReuseIdentifier: "videoCell")
    }
    
    // Dark Mode Activate.
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            // Temaya özel güncellemeleri burada yap.
            updateUIForCurrentTheme()
        }
    }

    func updateUIForCurrentTheme() {
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = UIColor.black
        } else {
            view.backgroundColor = UIColor.white
        }
    }


}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockDatas.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = mockDatas[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as? TableViewCell
        cell?.configure(with: data)
        
        
        // Play Button Tapped.
        cell?.playButton.tag = indexPath.row
        cell?.playButton.addTarget(self, action: #selector(playVideoButtonTapped(_:)), for: .touchUpInside)
        
        // Register Button Tapped.
        cell?.registerButton.tag = indexPath.row
        cell?.registerButton.addTarget(self, action: #selector(registerButtonTapped(_:)), for: .touchUpInside)
        
        //Favorite Button Tapped.
        cell?.favoriteButton.tag = indexPath.row
        cell?.favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped(_:)), for: .touchUpInside)
        
        cell?.selectionStyle = .none
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //playVideo(videoUrl: videoUrl[indexPath.row])
    }
    
    //MARK: Play Video Button
    // Play Video Function for #selector. Because It can't use parameter to selector.
    @objc func playVideoButtonTapped(_ sender: UIButton) {
        let videoUrlString = mockDatas[sender.tag].urlString
        // rowIndex kontrol amaçlı yazdım.
        let rowIndex = sender.tag
        print("\(rowIndex). Video açıldı")
        playVideo(videoUrl: videoUrlString)
    }
    
    // Create Play Video
    func playVideo(videoUrl: String) {
        let url: URL = URL(string: videoUrl)!
        playerView = AVPlayer(url: url)
        playerViewController.player = playerView
        self.present(playerViewController, animated: true) {
            self.playerView.play()
        }
    }
    
    //MARK: Register Button
    @objc func registerButtonTapped(_ sender: UIButton) {
        let rowIndex = sender.tag
        
        let mockData = mockDatas[rowIndex]
        if sender.isSelected {
            sender.isSelected = false
            sender.buttonStyle(backgroundColor: "5856D6", title: "Derse Kayıt Ol", titleColor: .white)
            print("\(rowIndex). Derse kayıt silindi.")
        } else {
            sender.isSelected = true
            sender.buttonStyle(backgroundColor: "323031", title: "Kayıtlı Ders", titleColor: .black)
            guard let context = context else { fatalError("Context is not initialized") }
            registerLessons(context: context, mockData: [mockData])
            print("\(rowIndex). Derse kayıt yapıldı.")
        }
    }
        
    func registerLessons(context: NSManagedObjectContext, mockData: [MockData]) {
        let currentUser = Auth.auth().currentUser
        
        do {
            // MockData dizisini JSON olarak kodlayın
            let jsonData = try JSONEncoder().encode(mockData) // Dizinin tamamını kodluyoruz
            
            // Fetch Request ile mevcut kullanıcıyı kontrol et
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Users")
            let results = try context.fetch(fetchRequest)
            
            let userEntity: NSManagedObject
            if let existingUser = results.first {
                // Mevcut kullanıcıyı güncelle
                userEntity = existingUser
            } else {
                // Yeni kullanıcı oluştur
                userEntity = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
            }
            
            // Veriyi kaydet
            userEntity.setValue(jsonData, forKey: "registerLessons")
            
            try context.save()
            print("✅ Kurs bilgileri CoreData'ya aktarıldı.")
            
            // Veriyi okuma
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Users")
                
                do {
                    let results = try context.fetch(fetchRequest)
                    if let firstResult = results.first,
                       let jsonData = firstResult.value(forKey: "registerLessons") as? Data {
                        // JSON verisini MockData dizisine dönüştür
                        let decodedMockData = try JSONDecoder().decode([MockData].self, from: jsonData)
                        
                        // Verileri yazdır
                        for mockData in decodedMockData {
                            print("Lesson ID: \(mockData.lessonId)")
                            print("Title: \(mockData.title)")
                            print("Description: \(mockData.description)")
                            print("URL: \(mockData.urlString)")
                            print("--------------------")
                        }
                    }
                } catch {
                    print("Veri okuma hatası: \(error)")
                }
            }
        } catch {
            print("Veri kaydetme hatası: \(error)")
        }
    }
    
    
    // MockData dizisinin geri okunması. (Kaydedilen registerLessons verisini tekrar "MockData" nesnelerine dönüştürmek için.
    func fetchMockData(context: NSManagedObjectContext) -> [MockData]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        do {
            print("1")
            if let results = try context.fetch(fetchRequest) as? [NSManagedObject],
               let firstResult = results.first,
               let jsonData = firstResult.value(forKey: "registerLessons") as? Data {
                print("2")
                // JSON verisini MockData dizisine dönüştürün
                let mockData = try JSONDecoder().decode([MockData].self, from: jsonData)
                print(mockData)
                for data in mockData {
                    print("Lesson ID: \(data.lessonId)")
                    print("Title: \(data.title)")
                    print("Description: \(data.description)")
                    print("URL: \(data.urlString)")
                    print("--------------------")
                }
                return mockData
            }
        } catch {
            print("Error fetching MockData: \(error)")
        }
        return nil
    }
    
    //MARK: Favorite Button
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        let favButton = sender.tag  //Debug kontrol için. Tag numarasını aldım.
        if sender.isSelected {
            // Uncheck the button.
            sender.isSelected = false
            sender.setImage(UIImage(systemName: "star"), for: .normal)
            print("\(favButton). Favorilerden çıkarıldı..")
        } else {
            // Check the button.
            sender.isSelected = true
            sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
            print("\(favButton). Favorilere eklendi..")
        }
    }
    
    func addFavorite(favorite: Bool) {
        
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}


