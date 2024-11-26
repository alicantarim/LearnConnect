//
//  HomeViewViewController.swift
//  LearnConnect
//
//  Created by Alican TARIM on 25.11.2024.
//

import UIKit
import AVKit
import AVFoundation


struct MockData {
    let title: String
    let description: String
    let urlString: String
}

class HomeViewController: UIViewController {
    
    var videoTitle = ["Big Buck Bunny", "Elephant Dream", "For Bigger Blazes", "For Bigger Escape"]
    var videoSubtitle = ["Big Buck Bunny tells the story of a giant rabbit with a heart bigger than himself. Licensed under the Creative Commons Attribution license www.bigbuckbunny.",
                         "The first Blender Open Movie from 2006. For when you want to settle into your Iron Throne to watch the latest episodes.",
                         "HBO GO now works with Chromecast. The easiest way to enjoy online video and music on your TV—for when Batman's escapes aren't quite big enough. For $35.",
                         "Introducing Chromecast. The easiest way to enjoy online video and music on your TV. For $35. Find out more at google.com/chromecast.",
                         "Introducing Chromecast. The easiest way to enjoy online video and music on your TV—for the times that call for bigger joyrides."]
    var videoUrl = ["http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
                    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
                    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
                    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
                    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    var playerViewController = AVPlayerViewController()
    var playerView = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        
        // Create NIB
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        // videoCell -> cell identifier
        tableView.register(nib, forCellReuseIdentifier: "videoCell")
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoTitle.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as? TableViewCell
        cell?.comminInit(title: videoTitle[indexPath.row], subTitle: videoSubtitle[indexPath.row], videoUrl: videoUrl[indexPath.row])
        
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playVideo(videoUrl: videoUrl[indexPath.row])
    }
    
    // Create Play Video
    
    func playVideo(videoUrl: String) {
        let url: URL = URL(string: videoUrl)!
        playerView = AVPlayer(url: url)
        playerViewController.player = playerView
        
        self.present(playerViewController, animated: true) {
            self.playerView.play()
        }
        //self.playerViewController.player?.play()
        
    }
    
}


