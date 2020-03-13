//
//  PersistenceManager.swift
//  GitPractice
//
//  Created by Jackson Pitcher on 2/28/20.
//  Copyright © 2020 Jackson Pitcher. All rights reserved.
//

import UIKit

enum PersistenceManager {
    static let defaults = UserDefaults.standard

    enum Keys {
        static let favorites = "favorites"
    }

    enum actionType {
        case add, remove
    }
    
    static func updateWith(favorite: Follower, actionType: actionType, completed: @escaping (GFError?) -> Void) {
           retrieveFavorites { (result) in
               switch result {
               case .success(var favorites):

                   switch actionType {
                   case .add:
                       guard !favorites.contains(favorite) else {
                           completed(.alreadyAdded)
                           return
                       }
                       favorites.append(favorite)
                   case .remove:
                       favorites.removeAll {$0.login == favorite.login}
                   }

                   completed(saveFavorites(favorites: favorites))

                   break
               case .failure(let error):
                   completed(error)
                   break
               }
           }
       }

    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }

        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch let err {
            print("error decoding follower data", err)
        }
    }

    static func saveFavorites(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .alreadyAdded
        }
    }
}


enum GFError: String, Error {
    case alreadyAdded = "This follower has already been added"
    case unableToFavorite = "Unable to Favorite"
    case invalidUsername = "This is an invalid username"
    case unableToComplete = "Unable to complete"
    case invalidResponse = "This is an invalid response"
    case invalidData = "Invalid data"
}

