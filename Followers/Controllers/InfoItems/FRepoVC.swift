//
//  FRepoVC.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 21.05.21.
//

import UIKit


protocol FRepoVCCDelegate: class {
    func didTapGitHubProfile(for user: User)
}


class FRepoVC: FItemInfoVC {
    

    weak var delegate: FRepoVCCDelegate?
    
    init(user: User, delegate: FRepoVCCDelegate) {
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
    
    private func configureItems() {
        itemInfoView1.setupItem(of: .repo, withCount: user.publicRepos ?? 0)
        itemInfoView2.setupItem(of: .gist, withCount: user.publicGists ?? 0)
        
        actionButton.set(color: .systemPurple, title: "GitHub Profile")

    }
    
    
    override func actionButtonTapped() {
        delegate?.didTapGitHubProfile(for: user)
    }

}
