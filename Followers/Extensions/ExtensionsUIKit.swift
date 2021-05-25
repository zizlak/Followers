//
//  ExtensionsUIKit.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 17.05.21.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentFAllertOnMainThread(title: String, message: String, buttonTitle: String) {
        
        DispatchQueue.main.async {
            let allertVC = FAllertVC(title: title, message: message, buttonTitle: buttonTitle)
            allertVC.modalPresentationStyle = .overFullScreen
            allertVC.modalTransitionStyle = .crossDissolve
            
            self.present(allertVC, animated: true)
        }
        
    }

    
    
    func showEmtyStateView(with message: String, in view: @autoclosure @escaping () -> UIView) {
        DispatchQueue.main.async {
            let emptyStateView = EmptyStateView(message: message)
            emptyStateView.frame = view().bounds
            view().addSubview(emptyStateView)
        }
    }
    
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}



//MARK: - DataLoadingVC

class DataLoadingVC: UIViewController {
    
    private var loadingScreen: UIView?
    
    func showLoadingScreen() {
        loadingScreen = UIView(frame: view.bounds)
        guard let loadingScreen = loadingScreen else { return }
        
        view.addSubview(loadingScreen)
        
        loadingScreen.backgroundColor = .systemBackground
        loadingScreen.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            loadingScreen.alpha = 0.8
        }
        let activityInd = UIActivityIndicatorView(style: .large)
        loadingScreen.addSubview(activityInd)
        
        activityInd.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityInd.centerYAnchor.constraint(equalTo: loadingScreen.centerYAnchor),
            activityInd.centerXAnchor.constraint(equalTo: loadingScreen.centerXAnchor)
        ])
        
        activityInd.startAnimating()
        
    }
    
    func dismissLoadingScreen() {
        DispatchQueue.main.async {
            self.loadingScreen?.removeFromSuperview()
            self.loadingScreen = nil
        }
    }
}
