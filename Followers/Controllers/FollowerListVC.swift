//
//  FolowerListVC.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 16.05.21.
//

import UIKit

class FollowerListVC: UIViewController {
    
    //MARK: - Interface
    
    //MARK: - Properties
    
    var userName: String!
    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        
        NetworkManager.shared.getFollowers(for: userName, page: 1) { (followers, error) in
            
            guard let followers = followers else {
                self.presentFAllertOnMainThread(title: "Something went wrong", message: error ?? "", buttonTitle: "Ok")
                return
            }
            print(followers)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    //MARK: - Methods
    
    //MARK: - Extensions

}
