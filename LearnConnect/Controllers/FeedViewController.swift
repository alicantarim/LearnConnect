//
//  FeedViewController.swift
//  LearnConnect
//
//  Created by Alican TARIM on 19.12.2024.
//

import UIKit
import AVKit
import AVFoundation

struct MockData: Codable {
    let lessonId: Int
    let title: String
    let description: String
    let urlString: String
    let courseImage: String
}

class FeedViewController: UIViewController {
    
    var mockDatas: [MockData] = [
        .init(lessonId: 0,
              title: "ReactNavite Eğitimi 2024",
              description: "React Native İle IOS ve ANDROID Platformunda Uygulamalar Geliştirerek Piyasada Fark Yaratın!",
              urlString: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
              courseImage: "react"),
        .init(lessonId: 1,
              title: "Complete Web Development",
              description: "Become a Full-Stack Web Developer with just ONE course. HTML, CSS, Javascript, Node, React, PostgreSQL, Web3 and DApps",
              urlString: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
              courseImage: "webDevelopment"),
        .init(lessonId: 2,
              title: "SwiftUI MasterClass 2024",
              description: "Create 2+ apps and master data management in iOS 18 app development with Apple's new SwiftData and SwiftUI frameworks.",
              urlString: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
              courseImage: "swiftUI"),
        .init(lessonId: 3,
              title: "Sıfırdan Zirveye İngilizce",
              description: "Platform üzerindeki ''En Sistemli'' İngilizce Kursu ile ''Özel ders alır gibi'' İngilizce öğrenin, anlayın ve konuşun!",
              urlString: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
              courseImage: "ingilizce")
    ]
    
    var savedCourses = [MockData]()
    
    private lazy var tableView = {
        let tView = UITableView()
        tView.backgroundColor = .clear
        tView.dataSource = self
        tView.delegate = self
        tView.rowHeight = 200
        tView.separatorStyle = .none
        tView.register(VideoCell.self, forCellReuseIdentifier: "VideoCell")
        tView.showsVerticalScrollIndicator = false
        return tView
    }()
    
    var playerViewController = AVPlayerViewController()
    var playerView = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Anasayfa"
        navigationItem.hidesBackButton = true
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(10)
        }
        
    }
    
    @objc func registerButtonTapped(_ sender: UIButton) {
        let willSaveCourse = mockDatas[sender.tag]
        
        // Mevcut kayıtlı kursları al
        
        if let savedData = UserDefaults.standard.data(forKey: "savedCourses"),
           let decodedCourses = try? JSONDecoder().decode([MockData].self, from: savedData) {
            savedCourses = decodedCourses
        }
        
        // Eğer o data ekliyse bir daha bastığında o datayı sil değilse ekle
        // UserDefaults.standard.removeObject(forKey: "savedCourses")
        // Eğer ders kayıtlıysa, sil; değilse ekle
        if let index = savedCourses.firstIndex(where: { $0.lessonId == willSaveCourse.lessonId }) {
            savedCourses.remove(at: index)
        } else {
            // Yeni kursu ekle
            savedCourses.append(willSaveCourse)
        }
                
        // Güncellenmiş listeyi kaydet
        if let encodedData = try? JSONEncoder().encode(savedCourses) {
            UserDefaults.standard.set(encodedData, forKey: "savedCourses")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "courseSaved"), object: nil)
        }
        
        // Button'un değişmesi için Tabloyu yeniden yükle.
        tableView.reloadData()
    }
}

//      MARK: UITableViewDelegate & UITableViewDataSource

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as? VideoCell else { return UITableViewCell() }
        let data = mockDatas[indexPath.row]
        
        if savedCourses.contains(where: { $0.lessonId == data.lessonId }) {
            cell.registerButton.setTitle("Kayıtlı Ders", for: .normal)
            cell.registerButton.backgroundColor = .black
        } else {
            cell.registerButton.setTitle("Kayıt Ol", for: .normal)
            cell.registerButton.backgroundColor = .systemIndigo
        }
        
        cell.configureCell(data:data)
        
        cell.getPlayButton().tag = indexPath.row
        cell.getPlayButton().addTarget(self, action: #selector(playVideoButtonTapped(_:)), for: .touchUpInside)
        cell.registerButton.tag = indexPath.row
        cell.registerButton.addTarget(self, action: #selector(registerButtonTapped(_:)), for: .touchUpInside)
   
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mockDatas.count
    }
    
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
    
}

//#Preview("FeedViewController"){
//    let vc = FeedViewController()
//    return vc
//}

