//
//  TableViewCell.swift
//  GitPractice
//
//  Created by Jackson Pitcher on 2/27/20.
//  Copyright © 2020 Jackson Pitcher. All rights reserved.
//

import UIKit

class FavoritesCell: UITableViewCell, UITableViewDelegate {
    
    static let favoritesCellID = "favoritesCellID"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(avatarImageView)
        avatarImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(nameLabel)
        nameLabel.anchor(top: nil, left: avatarImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    let avatarImageView = FollowerAvatarImageView(frame: .zero)
    let nameLabel = TitleLabel(frame: .zero)
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
