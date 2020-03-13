//
//  UserGitHubCard.swift
//  GitPractice
//
//  Created by Jackson Pitcher on 2/22/20.
//  Copyright © 2020 Jackson Pitcher. All rights reserved.
//

import UIKit

class UserGitHubCard: UIView {
    
    weak var delegate: UserInfoDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupGists()
        setupRepos()
        setupGetFollowersButton()
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 16
    }
    
    var user: User! {
        didSet {
            DispatchQueue.main.async {
                self.gistsView.countLabel.text = String(self.user.publicGists)
                self.reposView.countLabel.text = String(self.user.publicRepos)
            }
        }
    }
    
    func setupGists() {
        addSubview(gistsView)
        gistsView.set(itemType: .gists, withCount: 10)
        gistsView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func setupRepos() {
        addSubview(reposView)
        reposView.set(itemType: .repos, withCount: 10)
        reposView.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        reposView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupGetFollowersButton() {
        addSubview(gitHubButton)
        gitHubButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        gitHubButton.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 50)
    }
    
    @objc func handleTap() {
        delegate.didTapGitHubProfile(user: user)
    }
    
    let gitHubButton = GetFollowersButton(backgroundColor: .systemPurple, title: "GitHub Profile", coloredBackground: .yes)
    let gistsView = UserItemInfoView()
    let reposView = UserItemInfoView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
