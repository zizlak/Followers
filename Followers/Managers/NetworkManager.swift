//
//  NetworkManager.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 17.05.21.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let numberOfPages = "100"
    let cache = NSCache<NSString, UIImage>()
    
    private init(){}
    
    
    func getFollowers(for userName: String, page: Int, completion: @escaping (Result<[Follower], FError>) -> Void) {
        
        //MARK: - URL
        //    let baseURL = "https://api.github.com/users/"
        //    let endpoint = baseURL + userName + "/followers?per_page=" + numberOfPages + "&page=" + "\(page)"
        
        guard let url = createStringURL(userName: userName, page: page) else {
            completion(.failure(.invalidUserName))
            return
        }
        
        //MARK: - URLSession
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            //MARK: - Data
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            //MARK: - Decode
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let followers = try jsonDecoder.decode([Follower].self, from: data)
                completion(.success(followers))
            } catch {
                completion(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
    
    
    func getUserInfo(for userName: String, completion: @escaping (Result<User, FError>) -> Void) {
        
        guard let url = createStringURL(userName: userName) else {
            completion(.failure(.invalidUserName))
            return
        }
        
        
        //MARK: - URLSession
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            //MARK: - Data
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            //MARK: - Decode
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            jsonDecoder.dateDecodingStrategy = .iso8601
            
            do {
                let user = try jsonDecoder.decode(User.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
    
    
    //MARK: - createStringURL
    private func createStringURL(userName: String, page: Int? = nil) -> URL? {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.github.com"
        components.path.append("/users/")
        components.path.append(userName)
        
        if page == nil {
            return components.url
        }
        
        guard let page = page else { return nil }
        components.path.append("/followers")
        
        components.queryItems = [
            URLQueryItem(name: "per_page", value: "\(numberOfPages)"),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        return components.url
    }
}
