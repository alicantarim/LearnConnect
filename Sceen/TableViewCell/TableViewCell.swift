//
//  TableViewCell.swift
//  LearnConnect
//
//  Created by Alican TARIM on 26.11.2024.
//

import UIKit
import AVKit
import AVFoundation

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func comminInit(title: String, subTitle: String, videoUrl: String) {
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
        
        let url = URL(string: videoUrl)
        self.getThumbnailFromVideoURL(url: url!) { (thumbnailImage) in
            self.thumbnailImageView.image = thumbnailImage
        }
        
    }
    
    //MARK: - Favorite Button
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        
    }
    
    //MARK: - Register Button
    @IBAction func registerButtoın(_ sender: UIButton) {
        
    }
    
    //MARK: - Play Button
    @IBAction func playButtonPressed(_ sender: UIButton) {
        
    }
    
    
    //MARK: - Get thumbnail
    func getThumbnailFromVideoURL(url: URL, completion: @escaping ((_ image: UIImage?) -> Void)) {
        // Görüntüyü oluşturur.
        DispatchQueue.global().async {
            let asset = AVURLAsset(url: url)
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            
            avAssetImageGenerator.appliesPreferredTrackTransform = true
            
            let thumbnailTime = CMTimeMake(value: 2, timescale: 1)
            
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumbnailTime, actualTime: nil)
                
                let thumbImage = UIImage(cgImage: cgThumbImage)
                
                DispatchQueue.main.async {
                    completion(thumbImage)
                }

            } catch {
                print(error.localizedDescription)
            }
        }
    }

 
    
}
