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
    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    //MARK: - Methods
    
    private func configureItems() {
        itemInfoView1.setupItem(of: .followers, withCount: user.followers ?? 0)
        itemInfoView2.setupItem(of: .following, withCount: user.following ?? 0)
        
        actionButton.set(color: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate?.didTapGetFollowers(for: user)
    }
}


//MARK: - Extensions
