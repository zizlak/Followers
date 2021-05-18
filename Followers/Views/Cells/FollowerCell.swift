//
//  AvatarCell.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 18.05.21.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    //MARK: - Interface
    let avatrImageView = AvatarImageView(frame: .zero)
    let userNameLabel = FTitleLabel(textAlignment: .center, fontSize: 16)
    
    //MARK: - Properties
    
    static let reuseID = String(describing: FollowerCell.self)
    let padding: CGFloat = 8
    
    //MARK: - LifeCycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    func set(follower: FollowerModel) {
        userNameLabel.text = follower.login
    }
    
    private func configure() {
        addSubview(avatrImageView)
        addSubview(userNameLabel)
        
        NSLayoutConstraint.activate([
            
            //avatrImageView
            avatrImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatrImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatrImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatrImageView.heightAnchor.constraint(equalTo: avatrImageView.widthAnchor),
            
            //userNameLabel
            userNameLabel.topAnchor.constraint(equalTo: avatrImageView.bottomAnchor, constant: 12),
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
