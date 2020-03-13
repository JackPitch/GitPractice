//
//  FollowerCell.swift
//  GitPractice
//
//  Created by Jackson Pitcher on 2/12/20.
//  Copyright © 2020 Jackson Pitcher. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addSubview(usernameLabel)
        usernameLabel.anchor(top: nil, left: nil, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
        usernameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(followerImageView)
        followerImageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: usernameLabel.topAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 0, height: 0)
        followerImageView.heightAnchor.constraint(equalTo: followerImageView.widthAnchor).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "user"
        label.font = .boldSystemFont(ofSize: 13)
        return label
    }()
    
    let followerImageView = FollowerAvatarImageView(frame: .zero)
    
    
    
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        followerImageView.downloadImage(urlString: follower.avatarUrl)
    }
    
    
}
