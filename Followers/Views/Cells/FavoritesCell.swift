//
//  FavoritesCell.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 24.05.21.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
    //MARK: - Interface
    
    let avatar = AvatarImageView(frame: .zero)
    let label = FTitleLabel(textAlignment: .left, fontSize: 26)
    
    //MARK: - Properties
    
    let padding: CGFloat = 10
    static let id = String(describing: FavoritesCell.self)
    
    //MARK: - LifeCycle Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Methods
    
    private func configure() {
        for v in [label, avatar] {
            contentView.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.accessoryType = .disclosureIndicator
        
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatar.heightAnchor.constraint(equalToConstant: 60),
            avatar.widthAnchor.constraint(equalTo: avatar.heightAnchor),
            avatar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            
            label.centerYAnchor.constraint(equalTo: avatar.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: padding),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    func setCell(with favorite: Follower) {
        label.text = favorite.login
        avatar.downloadImage(from: favorite.avatarUrl)
    }
}
