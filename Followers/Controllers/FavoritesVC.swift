//
//  FavoritesVC.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 14.05.21.
//

import UIKit

class FavoritesVC: UIViewController {
    
    //MARK: - Interface
    
    let tableView = UITableView()
    
    //MARK: - Properties
    
    var array = [Follower]()
    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }
    
    
    //MARK: - Methods
    
    private func configure() {
        view.backgroundColor = .systemBlue
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.tableFooterView = UIView()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.id)
    }
    
    
    
    private func reload() {
        let result = PersistanceManager.retrieveFavorites()
        switch result {
        case .success(let favorites):
            array = favorites
            tableView.reloadData()
            
        case .failure(let error):
            presentFAllertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
    
    
}
//MARK: - Extensions
extension FavoritesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.id) as? FavoritesCell else {
            fatalError("Cell for Table View not found")
        }
        
        let favorite = array[indexPath.row]
        cell.setCell(with: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
     
        let favorite = array[indexPath.row]
        guard let userName = favorite.login else { return }
        let vc = FollowerListVC(userName: userName)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let favorite = array[indexPath.row]
            if let error = PersistanceManager.update(with: favorite, withAction: .delete) {
                presentFAllertOnMainThread(title: "Unable to delete", message: error.rawValue, buttonTitle: "Ok")
            }
            
            array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .middle)
        }
    }
}
