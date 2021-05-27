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
        configureLogo()
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        label.text = message
    }
    
    
    //MARK: - Methods
    
    private func configureLabel() {
        addSubview(label)
        
        label.numberOfLines = 3
        label.textColor = .secondaryLabel
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let topDistance: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -100 : -150
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: topDistance),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            label.heightAnchor.constraint(equalToConstant: 200),
            
        ])
        
    }
    
    private func configureLogo() {
        
        addSubview(logo)
        
        
        logo.image = Images.emptyStateLogo
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomDistance: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 40
        
        NSLayoutConstraint.activate([
            logo.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logo.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
            logo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomDistance)
        ])
        
    }
    
    //MARK: - Extensions
    
    
}
