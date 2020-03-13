//
//  UserInfoViewController.swift
//  GitPractice
//
//  Created by Jackson Pitcher on 2/16/20.
//  Copyright © 2020 Jackson Pitcher. All rights reserved.
//

import UIKit
import SafariServices

protocol UserInfoDelegate: class {
    func didTapRequestFollowers(user: User)
    func didTapGitHubProfile(user: User)
}

class UserInfoViewController: UIViewController, UserInfoDelegate {
    
    weak var delegate: FollowerListDelegate!
    
    func didTapRequestFollowers(user: User) {
        guard user.followers != 0 else {
             return
        }
        delegate.didRequestFollowers(username: user.login)
        dismiss(animated: true, completion: nil)
    }
    
    func didTapGitHubProfile(user: User) {
        guard let url = URL(string: user.htmlUrl) else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredControlTintColor = .systemPurple
        present(safariViewController, animated: true)
    }
        
    var username: String!
    var user: User! {
        didSet {
            headerCard.user = self.user
            middleView.user = self.user
            footerView.user = self.user
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDismiss))
        navigationItem.rightBarButtonItem?.tintColor = .systemPink
        
        getUserInfo()
        setupHeaderCard()
        setupFollowerCard()
        setupGitHubCard()
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    func setupHeaderCard() {
        view.addSubview(headerCard)
        headerCard.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: view.frame.height / 8, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: view.frame.height / 5)
    }
    
    func setupFollowerCard() {
        view.addSubview(middleView)
        middleView.delegate = self
        middleView.backgroundColor = .secondarySystemBackground
        middleView.layer.cornerRadius = 16
        middleView.anchor(top: headerCard.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 50, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: view.frame.height / 5)
    }
    
    func setupGitHubCard() {
        view.addSubview(footerView)
        footerView.delegate = self
        footerView.layer.cornerRadius = 16
        footerView.backgroundColor = .secondarySystemBackground
        footerView.anchor(top: middleView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 50, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: view.frame.height / 5)
    }
    
    
    let headerCard = UserInfoCard(frame: .zero)
    var middleView = UserFollowerCard(frame: .zero)
    var footerView = UserGitHubCard(frame: .zero)
    
    func getUserInfo() {
        Service.shared.getUserInfo(username: username) { (result) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.user = user
                }
            case .failure(let err):
                print("faild to get user info", err)
            }
        }
    }
}
