//
//  ExtensionsUIKit.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 17.05.21.
//

import UIKit

extension UIViewController {
    
    func presentFAllertOnMainThread(title: String, message: String, buttonTitle: String) {
        
        DispatchQueue.main.async {
            let allertVC = FAllertVC(title: title, message: message, buttonTitle: buttonTitle)
            allertVC.modalPresentationStyle = .overFullScreen
            allertVC.modalTransitionStyle = .crossDissolve
        
            self.present(allertVC, animated: true)
        }
        
    }
    
}
