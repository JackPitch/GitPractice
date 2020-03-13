//
//  UserInfoHeader.swift
//  GitPractice
//
//  Created by Jackson Pitcher on 2/18/20.
//  Copyright © 2020 Jackson Pitcher. All rights reserved.
//

import UIKit
import WebKit

class UserInfoCard: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 12
        
        setupImageView()
        setupNameLabel()
        setupLocationImage()
        setupLocationLabel()
    }
    
    var user: User! {
        didSet {
            DispatchQueue.main.async {
                self.imageView.downloadImage(urlString: self.user.avatarUrl)
                self.nameLabel.text = self.user.login
                self.locationLabel.text = self.user.location ?? "No Location"
            }
        }
    }
    
    func setupImageView() {
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 20, paddingRight: 20, width: 0, height: 0)
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
    }
    
    func setupNameLabel() {
        nameLabel.numberOfLines = 1
        addSubview(nameLabel)
        nameLabel.anchor(top: topAnchor, left: imageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func setupLocationImage() {
        addSubview(locationImageView)
        locationImageView.anchor(top: nameLabel.bottomAnchor, left: imageView.rightAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        locationImageView.tintColor = .secondaryLabel
    }
    
    func setupLocationLabel() {
       addSubview(locationLabel)
        locationLabel.anchor(top: nameLabel.bottomAnchor, left: locationImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 14)
    }

    let imageView = FollowerAvatarImageView(frame: .zero)
    let nameLabel = TitleLabel(title: "Name Label", size: 32)
    let locationLabel = Label(title: "No Location", size: 18)
    
    
    let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: SFSymbols.location)
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
