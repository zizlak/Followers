//
//  UserModel.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 17.05.21.
//

import Foundation

struct UserModel: Codable {
    var login: String?
    var avatarUrl: String?
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int?
    var publicGists: Int?
    var htmlUrl: String?
    var following: Int?
    var followers: Int?
    var createdAt: String?
    
}
