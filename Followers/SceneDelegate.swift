//
//  SceneDelegate.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 14.05.21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
    
        window?.rootViewController = cteateTabBarC()
        window?.makeKeyAndVisible()
        
        configureNavBar()
    }
    
    
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
    
    private func cteateTabBarC() -> UITabBarController {
        let tabC = UITabBarController()
        UITabBar.appearance().tintColor = .systemGreen
        
        tabC.viewControllers = [createSearchNC(), createFavoritesNC()]
        return tabC
    }
    
    private func configureNavBar() {
        UINavigationBar.appearance().tintColor = .systemGreen
        UINavigationBar.appearance().prefersLargeTitles = true
    }
    

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

