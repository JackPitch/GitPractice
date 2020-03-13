//
//  UserItemInfoView.swift
//  GitPractice
//
//  Created by Jackson Pitcher on 2/20/20.
//  Copyright © 2020 Jackson Pitcher. All rights reserved.
//

import UIKit

enum itemTypeInfo {
    case following, followers, repos, gists
}

class UserItemInfoView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(symbolImageView)
        symbolImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: symbolImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)

        addSubview(countLabel)
        countLabel.anchor(top: topAnchor, left: titleLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
    }
    
    let symbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "avatar-placeholder").withRenderingMode(.alwaysOriginal)
        return imageView
    }()
    
    let titleLabel = Label(title: "Title", size: 20)
    
    let countLabel = Label(title: "Count", size: 20)
    
    func set(itemType: itemTypeInfo, withCount: Int) {
        switch itemType {
        case .following:
            symbolImageView.image = UIImage(systemName: SFSymbols.following)
            titleLabel.text = "Following:"
        case .followers:
            symbolImageView.image = UIImage(systemName: SFSymbols.followers)
            titleLabel.text = "Followers:"
        case .repos:
            symbolImageView.image = UIImage(systemName: SFSymbols.repos)
            titleLabel.text = "Repos:"
        case .gists:
            symbolImageView.image = UIImage(systemName: SFSymbols.gists)
            titleLabel.text = "Gists:"
        }
        countLabel.text = String(withCount)
        countLabel.tintColor = .white
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        countLabel.font = .preferredFont(forTextStyle: .headline)
        symbolImageView.tintColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
