//
//  UserHeaderVC.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 20.05.21.
//

import UIKit

class UserHeaderVC: UIViewController {
    
    //MARK: - Interface
    
    let avatarImageView = AvatarImageView(frame: .zero)
    let titelLabel = FTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = FSecondaryTitelLabel(font: 18)
    let locationImageView = UIImageView()
    let locationLabel = FSecondaryTitelLabel(font: 18)
    let bioLabel = FBodyLabel(textAlignment: .left)
    
    //MARK: - Properties

    let imagePadding: CGFloat = 12
    var user: User
    
    
    //MARK: - LifeCycle Methods

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    
    //MARK: - Methods
    
    private func configure() {
        addSubviews()
        layoutUI()
        setUser()
        bioLabel.numberOfLines = 3
        locationImageView.tintColor = .secondaryLabel
    }
    
    private func addSubviews() {
        for v in [avatarImageView, titelLabel, nameLabel, locationImageView, locationLabel, bioLabel] {
            view.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }

    }
    
    //MARK: - Constraints
    private func layoutUI() {
        
        NSLayoutConstraint.activate([
            
            //avatar
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
            
            //titelLabel
            titelLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            titelLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: imagePadding),
            titelLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titelLabel.heightAnchor.constraint(equalToConstant: 38),
            
            //nameLabel
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: imagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            //locationImageView
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: imagePadding),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            locationImageView.widthAnchor.constraint(equalTo: locationImageView.heightAnchor),
            
            //locationLabel
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            //bioLabel
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: imagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    
    private func setUser() {
        
        avatarImageView.downloadImage(from: user.avatarUrl)
        titelLabel.text = user.login
        nameLabel.text = user.name
        locationLabel.text = user.location ?? "No Location"
        bioLabel.text = user.bio ?? "No bio available"
        
        locationImageView.image = UIImage(systemName: SFSymbols.location)
    }
}
