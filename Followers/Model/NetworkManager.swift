//
//  NetworkManager.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 17.05.21.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let numberOfPages = "100"
    
    private init(){}
    
    
    
    func getFollowers(for userName: String, page: Int, completion: @escaping ([FollowerModel]?, String?) -> Void) {
        
        //MARK: - URL
        //    let baseURL = "https://api.github.com/users/"
        //    let endpoint = baseURL + userName + "/followers?per_page=" + numberOfPages + "&page=" + "\(page)"
        
        
        guard let url = createStringURL(userName: userName, page: page) else {
            completion(nil, "Invalid Request")
            return
        }
        
        
        //MARK: - URLSession
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, "Unable to complete the request: \n" + error.localizedDescription)
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, "Invalid response from the server")
                return
            }
            
            //MARK: - Data
            
            guard let data = data else {
                completion(nil, "The data recieved from the server is invalid")
                return
            }
            
            //MARK: - Decode
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let followers = try jsonDecoder.decode([FollowerModel].self, from: data)
                completion(followers, nil)
            } catch {
                completion(nil, "The data recieved from the server is invalid")
            }
            
        }
        
        task.resume()
    }
    
    //MARK: - createStringURL
    private func createStringURL(userName: String, page: Int) -> URL? {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.github.com"
        components.path.append("/users/")
        components.path.append(userName)
        components.path.append("/followers")
        
        components.queryItems = [
            URLQueryItem(name: "per_page", value: "\(numberOfPages)"),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        return components.url
        
    }
}
