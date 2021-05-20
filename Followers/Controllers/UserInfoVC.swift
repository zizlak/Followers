//
//  UserInfoVC.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 19.05.21.
//

import UIKit

class UserInfoVC: UIViewController {
    
    //MARK: - Interface
    
    let headerView = UIView()
    let itemView1 = UIView()
    let itemView2 = UIView()
    
    //MARK: - Properties
    
    var user: User?
    var userName: String?
    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureVC()
        fetchUser()
        layoutUI()
    }
    
    //MARK: - Methods
    
    private func configureVC() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    private func fetchUser() {
        guard let userName = userName else { return }
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: UserHeaderVC(user: user), to: self.headerView)
                }
                
            case .failure(let error):
                self.presentFAllertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    private func layoutUI() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func add(childVC: UIViewController, to container: UIView) {
        addChild(childVC)
        container.addSubview(childVC.view)
        childVC.view.frame = container.bounds
        childVC.didMove(toParent: self)
    }
}

//MARK: - Extensions
