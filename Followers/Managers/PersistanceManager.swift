//
//  PersistancyManager.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 24.05.21.
//

import Foundation

enum PersistancyAction {
    case add, delete
}

struct PersistanceManager {
    
    static private let userDefaults = UserDefaults.standard
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func update(with favorite: Follower, withAction action: PersistancyAction) -> FError? {
        
        switch retrieveFavorites() {
        
        case .success(var favorites):
            
            switch action {
            case .add:
                guard !favorites.contains(favorite) else { return .alrearyFavorite }
                
                favorites.append(favorite)
                
            case .delete:
                favorites.removeAll(where: { $0.login == favorite.login
                })
            }
            
            return save(favorites: favorites)
           
        case .failure(let error):
            return error
        }
    }
    
    
    static func retrieveFavorites() -> Result<[Follower], FError> {
        
        guard let favoritesData = userDefaults.object(forKey: Keys.favorites) as? Data else { return .success([]) }
        
        do {
            let result = try JSONDecoder().decode([Follower].self, from: favoritesData)
            return .success(result)
        } catch {
            return .failure(.invalidFavorites)
        }
    }
    
    
    static func save(favorites: [Follower]) -> FError? {
        
        do {
            let data = try JSONEncoder().encode(favorites)
            userDefaults.setValue(data, forKey: Keys.favorites)
            return nil
        } catch {
            return .couldNotSaveFavorite
        }
    }
}
