//
//  RegisterCourseViewController.swift
//  LearnConnect
//
//  Created by Alican TARIM on 19.12.2024.
//

import UIKit
import AVFoundation
import AVKit

class RegisterCourseViewController: UIViewController {
    
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
    
    var savedMockDatas : [MockData] = []
    
    var playerViewController = AVPlayerViewController()
    var playerView = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Kayıtlı Dersler"
        loadSavedMockData()
        view.backgroundColor = .systemBackground
        print("Saved Mock Datas:", savedMockDatas)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(10)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(registerCourseUpdated), name: NSNotification.Name(rawValue: "courseSaved"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
   @objc private func registerCourseUpdated(){
       loadSavedMockData()
    }
    
    private func loadSavedMockData() {
        
        if let savedData = UserDefaults.standard.data(forKey: "savedCourses"),
           let decodedCourses = try? JSONDecoder().decode([MockData].self, from: savedData) {
            self.savedMockDatas = decodedCourses
            self.tableView.reloadData()
        }
        
    }
    
    @objc private func playVideoButtonTapped(_ sender: UIButton) {
        let videoUrlString = savedMockDatas[sender.tag].urlString
        // rowIndex kontrol amaçlı yazdım.
        let rowIndex = sender.tag
        print("\(rowIndex). Video açıldı")
        playVideo(videoUrl: videoUrlString)
    }
    
    // Create Play Video
    private func playVideo(videoUrl: String) {
        guard let url: URL = URL(string: videoUrl) else {
            return
        }
        playerView = AVPlayer(url: url)
        playerViewController.player = playerView
        self.present(playerViewController, animated: true) {
            self.playerView.play()
        }
    }
    
}

extension RegisterCourseViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell",for: indexPath) as! VideoCell
        cell.registerButton.isHidden = true
        cell.likeButton.isHidden = true
        let data = savedMockDatas[indexPath.row]
        
        cell.configureCell(data:data)        
        cell.getPlayButton().tag = indexPath.row
        cell.getPlayButton().addTarget(self, action: #selector(playVideoButtonTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedMockDatas.count
    }
}
