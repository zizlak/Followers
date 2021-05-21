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
    var filteredFollowers: [Follower] = []
    var isSearching = false
    
    var page = 1
    var hasMoreFollowers = true
    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        configureDataSource()
        
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.create3ColumnFlowlayout(in: view))
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        collectionView.delegate = self
    }
    

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as? FollowerCell else {fatalError("Cell not created")}
            cell.set(follower: follower)
            
            return cell
        })
    }
    
    private func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
    }
    
    //MARK: - Networking
    func getFollowers() {
        showLoadingScreen()
        NetworkManager.shared.getFollowers(for: userName, page: self.page) { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingScreen()
            
            switch result {
            case .failure(let error):
                self.presentFAllertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                
            case .success(let followers):
                if followers.count < 100 {
                    self.hasMoreFollowers = false
                }
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                        self.showEmtyStateView(with: "This user has no followers. Go follow them 😜", in: self.view)
                        return
                }
              
                self.updateData(on: self.followers)
            }
            
        }
    }
}

//MARK: - Extensions

extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight =  scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers()
            
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let array = isSearching ? filteredFollowers : followers
        let follower = array[indexPath.row]
        
        let vc = UserInfoVC()
        vc.delegate = self
        vc.user = nil
        vc.userName = follower.login
        
        let navC = UINavigationController(rootViewController: vc)
        self.present(navC, animated: true)
    }
}

//MARK: - Search
extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmtyOrWhiteSpace() else { return }
        isSearching = true
        filteredFollowers = followers.filter { $0.login!.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
    
}
    

extension FollowerListVC {
    func userSelected(user: String) {
        navigationController?.navigationBar.prefersLargeTitles = true
        userName = user
        title = user
        followers = []
        page = 1
        getFollowers()
    }
}
