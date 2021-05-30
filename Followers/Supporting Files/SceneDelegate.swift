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
        
        window?.rootViewController = FTabBarController()
        window?.makeKeyAndVisible()

        UINavigationBar.appearance().tintColor = .systemGreen
        UINavigationBar.appearance().prefersLargeTitles = true
    }
}

