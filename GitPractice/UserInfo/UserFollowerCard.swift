//
//  UserFollowerCard.swift
//  GitPractice
//
//  Created by Jackson Pitcher on 2/21/20.
//  Copyright © 2020 Jackson Pitcher. All rights reserved.
//

import UIKit

class UserFollowerCard: UIView {
    
    weak var delegate: UserInfoDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupFollowing()
        setupFollowers()
        setupGetFollowersButton()
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 16
    }
    
    var user: User! {
        didSet {
            DispatchQueue.main.async {
                self.followingView.countLabel.text = String(self.user.following)
                self.followersView.countLabel.text = String(self.user.followers)
            }
        }
    }
    
    func setupFollowing() {
        addSubview(followingView)
        followingView.set(itemType: .following, withCount: 10)
        followingView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 15)
    }
    
    func setupFollowers() {
        addSubview(followersView)
        followersView.set(itemType: .followers, withCount: 10)
        followersView.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 0, height: 15)
        followersView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupGetFollowersButton() {
        addSubview(getFollowersButton)
        getFollowersButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        getFollowersButton.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 50)
    }
    
    @objc func handleTap() {
        delegate.didTapRequestFollowers(user: user)
    }
    
    let getFollowersButton = GetFollowersButton(backgroundColor: .systemPink, title: "Get Followers", coloredBackground: .yes)
    let followingView = UserItemInfoView()
    let followersView = UserItemInfoView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
