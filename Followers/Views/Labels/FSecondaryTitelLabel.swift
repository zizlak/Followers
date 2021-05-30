//
//  FSecondaryTitelLabel.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 20.05.21.
//

import UIKit

class FSecondaryTitelLabel: UILabel {
    
    //MARK: - LifeCycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(font size: CGFloat) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: size)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Methods
    
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
