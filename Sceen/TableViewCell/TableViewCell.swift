//
//  TableViewCell.swift
//  LearnConnect
//
//  Created by Alican TARIM on 26.11.2024.
//

import UIKit
import AVKit
import AVFoundation

protocol TableViewCellDelegate: AnyObject {
    func registerButtonTapped(sender: UIButton)
}

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: TableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerButton.addTarget(self, action: #selector(registerButtoın(_:)), for: .touchUpInside)
    }
    
    func configure(with data: MockData, isRegistered: Bool = false) {
        
        self.titleLabel.text = data.title
        self.subTitleLabel.text = data.description
        //self.registerButton.titleLabel?.font = .systemFont(ofSize: 11.0, weight: .semibold)

        
        let url = URL(string: data.urlString)
        self.getThumbnailFromVideoURL(url: url!) { (thumbnailImage) in
            self.thumbnailImageView.image = thumbnailImage
        }
        
        registerButton.cornerRadius(radius: 5)
        
        // isRegistered’ı configure içinde yapmamız daha temiz olur.
        if isRegistered {
            registerButton.buttonStyle(backgroundColor: "323031", title: "Kayıtlı Ders", titleColor: .white)
        } else {
            registerButton.buttonStyle(backgroundColor: "5856D6", title: "Derse Kayıt Ol", titleColor: .white)
        }
    }
    
    //MARK: - Favorite Button
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        
    }
    
    //MARK: - Register Button
    @IBAction @objc func registerButtoın(_ sender: UIButton) {
        delegate?.registerButtonTapped(sender: sender)
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
