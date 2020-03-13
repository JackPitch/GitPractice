//
//  Service.swift
//  GitPractice
//
//  Created by Jackson Pitcher on 2/12/20.
//  Copyright © 2020 Jackson Pitcher. All rights reserved.
//

import UIKit

class Service {
    static let shared = Service()
    
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    

    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], Error>) -> Void) {
        let fullUrl = "https://api.github.com/users/\(username)/followers?per_page=100&page=\(page)"

        guard let url = URL(string: fullUrl) else {
            print("invalid url info")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("error getting url info")
                return
            }

            guard let data = data else {
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                print("error getting data")
            }
        }

        task.resume()
    }
    
    func getUserInfo(username: String, completed: @escaping (Result<User, GFError>) -> Void) {

        let fullUrl = "https://api.github.com/users/\(username)"

        guard let url = URL(string: fullUrl) else { completed(.failure(.invalidUsername))
            return }

        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let _ = err {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else { completed(.failure(.invalidData))
                return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch let err {
                print("invalid server info", err)
            }

        }.resume()
    }
}
