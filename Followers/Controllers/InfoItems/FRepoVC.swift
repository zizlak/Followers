//
//  FRepoVC.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 21.05.21.
//

import UIKit

class FRepoVC: FItemInfoVC {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoView1.setupItem(of: .repo, withCount: user.publicRepos ?? 0)
        itemInfoView2.setupItem(of: .gist, withCount: user.publicGists ?? 0)
        
        actionButton.set(color: .systemPurple, title: "GitHub Profile")

    }
    
    
    override func actionButtonTapped() {
        delegate?.didTapGitHubProfile(for: user)
    }

}
