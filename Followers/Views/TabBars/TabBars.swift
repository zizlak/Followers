//
//  TabBars.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 24.05.21.
//

import UIKit

class FTabBarController: UITabBarController {

    //MARK: - LifeCycle Methods

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(), createFavoritesNC()]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods

    private func createSearchNC() -> UINavigationController {
        let vc = SearchVC()
        vc.title = "Search"
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: vc)
    }
    
    private func createFavoritesNC() -> UINavigationController {
        let vc = FavoritesVC()
        vc.title = "Favorites"
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: vc)
    }
}
