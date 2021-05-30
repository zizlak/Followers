//
//  FButton.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 15.05.21.
//

import UIKit

class FButton: UIButton {
    
    //MARK: - LifeCycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(color: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = color
        self.setTitleColor(color, for: .highlighted)
        self.setTitle(title, for: .normal)
    }
    
    //MARK: - Methods
    
    private func configure() {
        layer.cornerRadius      = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func set(color: UIColor, title: String) {
        self.setTitle(title, for: .normal)
        
        self.backgroundColor = color
        self.setTitleColor(color, for: .highlighted)
    }
    
}
