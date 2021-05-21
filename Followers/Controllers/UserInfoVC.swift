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
    weak var delegate: FollowerListVC?
    
    var user: User?
    var userName: String?
    let padding: CGFloat = 20
    let itemHeight: CGFloat = 140
    
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
                    self.add(childVC: FRepoVC(user: user), to: self.itemView1)
                    let vc = FFollowersVC(user: user)
                    vc.delegate = self
                    self.add(childVC: vc, to: self.itemView2)
                }
                
            case .failure(let error):
                self.presentFAllertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    //MARK: - Layout
    private func layoutUI() {
        for v in [headerView, itemView1, itemView2] {
            view.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                v.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                v.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            
            //Header
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            
            //Item1
            itemView1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemView1.heightAnchor.constraint(equalToConstant: itemHeight),
            
            
            //Item2
            itemView2.topAnchor.constraint(equalTo: itemView1.bottomAnchor, constant: padding),
            itemView2.heightAnchor.constraint(equalToConstant: itemHeight)
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

extension UserInfoVC {
    func userSelected(user: String) {
        self.dismiss(animated: true)
        delegate?.userSelected(user: user)
    }
}
