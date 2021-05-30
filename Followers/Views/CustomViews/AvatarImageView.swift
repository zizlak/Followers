//
//  AvatarImageView.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 18.05.21.
//

import UIKit

class AvatarImageView: UIImageView {

    //MARK: - Properties
    
    let cache = NetworkManager.shared.cache
    
    
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
        layer.cornerRadius = 10
        clipsToBounds = true
        setPlaceholder()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setPlaceholder() {
        image = Images.avatarPlaceholder
    }
    
    
    func downloadImage(from urlString: String?) {
        guard let urlString = urlString else { return }
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let data = data, let image = UIImage(data: data) else { return }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async { self.image = image }
            
        }
        task.resume()
        
    }
}
