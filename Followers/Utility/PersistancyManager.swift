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

struct PersistancyManager {
    
    static private let userDefaults = UserDefaults.standard
    
    static private let favoritesKey = "favorites"
    
    
    static func update(with favorite: Follower, withAction action: PersistancyAction) -> FError? {
        
        var arrayOfFavorites = [Follower]()
        
        switch retrieveFavorites() {
        
        case .success(let favorites):
            arrayOfFavorites = favorites
            
            switch action {
            case .add:
                guard !arrayOfFavorites.contains(favorite) else {
                    return .alrearyFavorite
                }
                arrayOfFavorites.append(favorite)
                
            case .delete:
                arrayOfFavorites.removeAll(where: { $0.login == favorite.login
                })
            }
            
            return save(favorites: arrayOfFavorites)
            
           
        case .failure(let error):
            return error
        }
    }
    
    
    
    
    static func retrieveFavorites() -> Result<[Follower], FError> {
        
        guard let favoritesData = userDefaults.object(forKey: favoritesKey) as? Data else { return .success([]) }
        
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
            userDefaults.setValue(data, forKey: favoritesKey)
            return nil
        } catch {
            return .couldNotSaveFavorite
        }
        
    }
    
}
