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
        
        view.backgroundColor = .systemBackground
        title = userName
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Methods
    
    //MARK: - Extensions

}