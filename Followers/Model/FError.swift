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
}
