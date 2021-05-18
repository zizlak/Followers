//
//  FolowerListVC.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 16.05.21.
//

import UIKit

class FollowerListVC: UIViewController {
    
    //MARK: - Interface
    
    var collectionView: UICollectionView!
    
    //MARK: - Properties
    
    var userName: String!
    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: - Methods
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    //MARK: - Networking
    private func getFollowers() {
        NetworkManager.shared.getFollowers(for: userName, page: 1) { result in
            switch result {
            case .failure(let error):
                self.presentFAllertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                
            case .success(let followers):
                print(followers)
            }
        }
    }
    
    //MARK: - Extensions
    
}
