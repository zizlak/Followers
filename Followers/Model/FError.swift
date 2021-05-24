//
//  Errors.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 17.05.21.
//

import Foundation

enum FError: String, Error {
    case invalidUserName = "Invalid User Name"
    case unableToComplete = "Unable to complete the request"
    case invalidResponse = "Invalid response from the server"
    case invalidData = "The data recieved from the server is invalid"
    case invalidFavorites = "Failed to decode Favorites"
    case couldNotSaveFavorite = "Favorite could not be saved due to encoding error"
    case alrearyFavorite = "You have already added this user to your favorites. You must REALLY like them 😍"
}
