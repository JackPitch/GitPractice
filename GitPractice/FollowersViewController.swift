//
//  FollowersViewController.swift
//  GitPractice
//
//  Created by Jackson Pitcher on 2/12/20.
//  Copyright © 2020 Jackson Pitcher. All rights reserved.
//

import UIKit

protocol FollowerListDelegate: class {
    func didRequestFollowers(username: String)
}

class FollowersViewController: UIViewController, UICollectionViewDelegate, FollowerListDelegate {
    
    func didRequestFollowers(username: String) {
        isSearching = false
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
    }
    
    let followerCellID = "followerCellID"
    var followers = [Follower]()
    var filteredFollowers = [Follower]()
    var page = 1
    var collectionView: UICollectionView!
    var username: String!
    var isSearching = false
    var hasMoreFollowers = true

    override func viewDidLoad() {
        super.viewDidLoad()
        getFollowers(username: username, page: page)
        setupCollectionView()
        setupDiffableDataSource()
        configureSearchController()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        navigationItem.rightBarButtonItem = addButton
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .systemPink
    }

    var diffableDataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    enum Section {
        case main
    }

    //setup diffable data source
    func setupDiffableDataSource() {
        diffableDataSource = UICollectionViewDiffableDataSource<Section, Follower> (collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.followerCellID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            cell.backgroundColor = .systemBackground
            return cell
        })
    }
    
    @objc func handleAdd() {
           Service.shared.getUserInfo(username: username) { [weak self] (result) in
            guard self != nil else { return }
               //self.dismissLoadingView()
               
               switch result {
               case .success(let user):
                   let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                   
                   PersistenceManager.updateWith(favorite: favorite, actionType: .add) { (err) in
                       if let err = err {
                        print("error updating user info", err)
                           return
                       }
                     
                    print("successfully followed user")
                   }
                   break
               case .failure(let error):
                print("failed to get user info", error)
                   break
               }
           }
       }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let userInfoViewController = UserInfoViewController()
        userInfoViewController.username = follower.login
        userInfoViewController.delegate = self
        userInfoViewController.title = follower.login
        let navController = UINavigationController(rootViewController: userInfoViewController)
        present(navController, animated: true)
    }

    //setup snapshot
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.diffableDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    //update the follower list
    func getFollowers(username: String, page: Int) {
        Service.shared.getFollowers(for: username, page: page) { [weak self] (result) in
            guard let self = self else { return }
            switch result {

            case .success(let followers):
                if followers.count < 100 {
                    self.hasMoreFollowers = false
                }
                self.followers.append(contentsOf: followers)
                self.updateData()

            case .failure(let error):
                print("this user has no followers", error)
            }
        }
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }

    //create the layout
    func threeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 20
        let availableWidth = width - (2 * padding) - (2 * minimumItemSpacing)
        let itemWidth = availableWidth / 3

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)

        return flowLayout
    }
    
    //setup collectionView
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: threeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: followerCellID)
    }

    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}

extension FollowersViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredFollowers = followers.filter {$0.login.lowercased().contains(filter.lowercased())}
        updateData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData()
    }
}




