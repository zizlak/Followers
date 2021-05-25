//
//  EmptyStateView.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 19.05.21.
//

import UIKit

class EmptyStateView: UIView {
    
    //MARK: - Interface
    
    let label = FTitleLabel(textAlignment: .center, fontSize: 28)
    let logo = UIImageView()
    
    //MARK: - Properties
    
    //MARK: - LifeCycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   convenience init(message: String) {
        self.init(frame: .zero)
        label.text = message
    }
    
    
    //MARK: - Methods
    
    private func configure() {
        addSubview(label)
        addSubview(logo)
        
        label.numberOfLines = 3
        label.textColor = .secondaryLabel
        
        logo.image = Images.emptyStateLogo
        
        label.translatesAutoresizingMaskIntoConstraints = false
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        let topDistance: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -100 : -150
        let bottomDistance: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 40

        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: topDistance),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            label.heightAnchor.constraint(equalToConstant: 200),
            
            logo.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logo.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
            logo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomDistance)
        ])
    }
    
    
    //MARK: - Extensions

    
}
