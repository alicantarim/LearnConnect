//
//  VideoCell.swift
//  LearnConnect
//
//  Created by Alican TARIM on 19.12.2024.
//

import UIKit
import AVKit
import AVFoundation

class VideoCell : UITableViewCell {

    private lazy var containerView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var videoImage = {
        let img = UIImageView()
        img.layer.cornerRadius = 8
        img.contentMode = .scaleAspectFit
//        img.backgroundColor = .systemIndigo
        img.layer.borderColor = UIColor.black.cgColor
        img.layer.borderWidth = 1
        return img
    }()
    
    private lazy var playButton = {
        let playBtn = UIButton()
        playBtn.setImage(UIImage(named: "playButton"), for: .normal)
        return playBtn
    }()
    
    private lazy var videoTitle = {
        let lbl = UILabel()
        lbl.text = "Video Title"
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = .boldSystemFont(ofSize: 14)
        return lbl
    }()
    
    private lazy var videoDescriptionTitle = {
        let lbl = UILabel()
        lbl.text = "Big Buck Bunny tells the story of a giant rabbit with a heart bigger than himself. Licensed under the Creative Commons Attribution license www.bigbuckbunny."
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 12)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private(set) lazy var registerButton =  {
        let btn = UIButton()
        btn.setTitle("Kayıt Ol", for: .normal)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 8
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 1
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    private(set) lazy var likeButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "star"), for: .normal)
        return btn
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        contentView.addSubview(containerView)
        containerView.addSubview(videoImage)
        containerView.addSubview(playButton)
        containerView.addSubview(videoTitle)
        containerView.addSubview(videoDescriptionTitle)
        containerView.addSubview(registerButton)
        containerView.addSubview(likeButton)
        
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func setupConstraints(){
        
        containerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(180)
        }
        
        videoImage.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().inset(15)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        playButton.snp.makeConstraints { make in
            make.centerX.equalTo(videoImage)
            make.centerY.equalTo(videoImage)
            make.width.height.equalTo(40)
        }
        
        videoTitle.snp.makeConstraints { make in
            make.left.equalTo(videoImage.snp.right).offset(10)
            make.top.equalTo(videoImage.snp.top)
            make.right.equalToSuperview().inset(5)
        }
        
        videoDescriptionTitle.snp.makeConstraints { make in
            make.top.equalTo(videoTitle.snp.bottom).offset(5)
            make.left.equalTo(videoTitle)
            make.right.equalToSuperview().inset(5)
        }
        
        registerButton.snp.makeConstraints { make in
            make.bottom.equalTo(videoImage)
            make.left.equalTo(videoTitle)
            make.height.equalTo(36)
            make.right.equalTo(likeButton.snp.left).offset(-20)
        }
        
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(videoImage)
            make.right.equalToSuperview().inset(5)
            make.width.height.equalTo(36)
        }
    }
    
    func configureCell(data: MockData){
        videoTitle.text = data.title
        videoDescriptionTitle.text = data.description
        let image = data.courseImage
        videoImage.image = UIImage(named: image)
    }
    
    func getPlayButton() -> UIButton {
            return playButton
        }
}



