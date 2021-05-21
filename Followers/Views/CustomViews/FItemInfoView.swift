//
//  FItemInfoView.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 20.05.21.
//

import UIKit


//MARK: - ItemInfoType
struct ItemInfoType {
    let symbol: String
    let text: String
    
    static let repo = ItemInfoType(symbol: SFSymbols.repos, text: "Public Repos")
    static let following = ItemInfoType(symbol: SFSymbols.following, text: "Following")
    static let followers = ItemInfoType(symbol: SFSymbols.followers, text: "Followers")
    static let gist = ItemInfoType(symbol: SFSymbols.gist, text: "Public Gists")
}




class FItemInfoView: UIView {

    //MARK: - Interface
    
    let symbolImageView = UIImageView()
    let titelLabel = FTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = FTitleLabel(textAlignment: .center, fontSize: 14)
    
    //MARK: - Properties
    
    //MARK: - LifeCycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Methods
    
    private func configure() {
        for v in [symbolImageView, titelLabel, countLabel] {
            self.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            symbolImageView.widthAnchor.constraint(equalTo: symbolImageView.heightAnchor),
            
            titelLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titelLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titelLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titelLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
    
    func setupItem(of type: ItemInfoType, withCount count: Int) {
        symbolImageView.image = UIImage(systemName: type.symbol)
        titelLabel.text = type.text
        countLabel.text = "\(count)"
    }
    
    
    //MARK: - Extensions
    
}
