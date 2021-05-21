//
//  FFollowersVC.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 21.05.21.
//

import UIKit

class FFollowersVC: FItemInfoVC {
    
    //MARK: - Interface
    
    //MARK: - Properties
    
    weak var delegate: UserInfoVC?
    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    //MARK: - Methods
    
    private func configureItems() {
        itemInfoView1.setupItem(of: .followers, withCount: user.publicRepos ?? 0)
        itemInfoView2.setupItem(of: .following, withCount: user.publicGists ?? 0)
        
        actionButton.set(color: .systemGreen, title: "Get Followers")
        actionButton.addTarget(self, action: #selector(goToFollowers), for: .touchUpInside)
    }
    

    
    @objc func goToFollowers() {
        delegate?.userSelected(user: user.login ?? "")
    }

}


//MARK: - Extensions
