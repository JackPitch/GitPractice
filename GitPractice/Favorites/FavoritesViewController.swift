//
//  FavoritesViewController.swift
//  GitPractice
//
//  Created by Jackson Pitcher on 2/17/20.
//  Copyright © 2020 Jackson Pitcher. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    var favorites = [Follower]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.favoritesCellID, for: indexPath) as! FavoritesCell
        let favorite = favorites[indexPath.item]
        cell.avatarImageView.downloadImage(urlString: favorite.avatarUrl)
        cell.nameLabel.text = favorite.login
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setupTableView()
        getFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.item]
        let followerVC = FollowersViewController()
        followerVC.username = favorite.login
        followerVC.title = favorite.login
        navigationController?.pushViewController(followerVC, animated: true)
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.favoritesCellID)
    }

    func getFavorites() {
        PersistenceManager.retrieveFavorites { (result) in
            switch result {
            case .success(let favorites):
                self.favorites = favorites
            case .failure(_):
                print("error retrieving favorites, see FavoritesViewController")
            }
        }
    }
}
