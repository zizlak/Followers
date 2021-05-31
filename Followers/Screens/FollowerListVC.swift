//
//  FolowerListVC.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 16.05.21.
//

import UIKit

class FollowerListVC: DataLoadingVC {
    
    //MARK: - Interface
    
    enum Section { case main }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    //MARK: - Properties
    
    var userName: String!
    
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var isSearching = false
    var isLoading = false
    
    var page = 1
    var hasMoreFollowers = true
    
    
    //MARK: - LifeCycle Methods
    
    init(userName: String) {
        super.init(nibName: nil, bundle: nil)
        self.userName = userName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

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
        title = userName
    }
    
    
    //MARK: - Methods
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let plus = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusTapped))
        
        navigationItem.rightBarButtonItem = plus
    }
    
    
    @objc func plusTapped() {
        showLoadingScreen()
        
        NetworkManager.shared.getUserInfo(for: userName) {[weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingScreen()
            
            switch result {
            case .failure(let error):
                self.presentFAllertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                
            case .success(let user):
                self.addUserToFavorites(user: user)
            }
        }
    }
    
    
    private func addUserToFavorites(user: User) {
        guard let login = user.login, let avatarUrl = user.avatarUrl else {
            self.presentFAllertOnMainThread(title: "Something went wrong", message: "User's data is not complete", buttonTitle: "Ok")
            return
        }
        
        let favorite = Follower(login: login, avatarUrl: avatarUrl)
        
        if let error = PersistanceManager.update(with: favorite, withAction: .add) {
            self.presentFAllertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        } else {
            self.presentFAllertOnMainThread(title: "well done!!!", message: "User was added to your favorites\n🥳", buttonTitle: "Hooray!!!")
        }
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
        navigationItem.searchController = searchController
    }
    
    
    //MARK: - Networking
    func getFollowers() {
        showLoadingScreen()
        isLoading = true
        
        NetworkManager.shared.getFollowers(for: userName, page: self.page) { [weak self] (result) in
            
            guard let self = self else { return }
            self.dismissLoadingScreen()
            
            switch result {
            case .success(let followers):
                self.updateUI(with: followers)
                
            case .failure(let error):
                self.presentFAllertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
        self.isLoading = false
    }
    
    
    private func updateUI(with followers: [Follower]) {
        if followers.count < 100 { self.hasMoreFollowers = false }
        
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty {
                self.showEmtyStateView(with: "This user has no followers. Go follow them 😜", in: self.view)
                return
        }
        
        self.updateData(on: self.followers)
    }
}


//MARK: - Extensions

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight =  scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoading else { return }
            page += 1
            getFollowers()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let array = isSearching ? filteredFollowers : followers
        let follower = array[indexPath.row]
        
        let vc = UserInfoVC()
        vc.delegate = self
        vc.userName = follower.login
        
        let navC = UINavigationController(rootViewController: vc)
        self.present(navC, animated: true)
    }
}


//MARK: - Search
extension FollowerListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let filter = searchController.searchBar.text, !filter.isEmtyOrWhiteSpace() else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return }
        
        isSearching = true
        filteredFollowers = followers.filter { $0.login!.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
}
    

//MARK: - UserInfoVCDelegate
extension FollowerListVC: UserInfoVCDelegate {
    
    func didRequestFollowers(for userName: String) {
        self.userName = userName
        title = userName
        followers = []
        filteredFollowers = []
        page = 1
        
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers()
    }
}
