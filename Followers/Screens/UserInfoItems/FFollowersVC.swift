//
//  FFollowersVC.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 21.05.21.
//

import UIKit

protocol FFollowersVCDelegate: class {
    func didTapGetFollowers(for: User)
}

class FFollowersVC: FItemInfoVC {
    
    //MARK: - Properties

    weak var delegate: FFollowersVCDelegate?
    
    
    //MARK: - LifeCycle Methods
    
    init(user: User, delegate: FFollowersVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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
