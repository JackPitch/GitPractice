//
//  Api_Models.swift
//  GitPractice
//
//  Created by Jackson Pitcher on 2/12/20.
//  Copyright © 2020 Jackson Pitcher. All rights reserved.
//

import UIKit

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
}

struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
}
