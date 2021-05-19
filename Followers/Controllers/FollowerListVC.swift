//
//  FolowerListVC.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 16.05.21.
//

import UIKit

class FollowerListVC: UIViewController {
    
    //MARK: - Interface
    enum Section { case main }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    //MARK: - Properties
    
    var userName: String!
    var followers: [Follower] = []
    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
        configureDataSource()
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.create3ColumnFlowlayout(in: view))
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as? FollowerCell else {fatalError("Cell not created")}
            cell.set(follower: follower)
            
            return cell
        })
    }
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
    
    //MARK: - Networking
     func getFollowers() {
        NetworkManager.shared.getFollowers(for: userName, page: 1) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.presentFAllertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                
            case .success(let followers):
                self.followers = followers
                self.updateData()
            }
        }
    }
}

//MARK: - Extensions
