//
//  FBodyLabel.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 17.05.21.
//

import UIKit

class FBodyLabel: UILabel {

    //MARK: - Interface
    
    //MARK: - Properties
    
    //MARK: - LifeCycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    
    private func configure() {
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Extensions
    

    
}

