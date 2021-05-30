//
//  UserInfoVC.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 19.05.21.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didRequestFollowers(for userName: String)
}

class UserInfoVC: UIViewController {
    
    //MARK: - Interface
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let headerView = UIView()
    let itemView1 = UIView()
    let itemView2 = UIView()
    let dateLabel = FBodyLabel(textAlignment: .center)
    
    
    //MARK: - Properties
    
    weak var delegate: UserInfoVCDelegate?
    
    var userName: String?
    let padding: CGFloat = 20
    let itemHeight: CGFloat = 140
    
    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureVC()
        configureScrollView()
        fetchUser()
        layoutUI()
    }
    
    
    //MARK: - Methods
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.pin(to: view)
        contentView.pin(to: scrollView)
        
        scrollView.showsVerticalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 620)
        ])
    }
    
    
    private func configureVC() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
    //MARK: - Networking
    private func fetchUser() {
        guard let userName = userName else { return }
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.cofigureUI(with: user)
                }
                
            case .failure(let error):
                self.presentFAllertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    
    private func cofigureUI(with user: User) {
        
        let repoVC = FRepoVC(user: user, delegate: self)
        let followerVC = FFollowersVC(user: user, delegate: self)
        
        self.add(childVC: UserHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoVC, to: self.itemView1)
        self.add(childVC: followerVC, to: self.itemView2)

        self.dateLabel.text = "on GitHub since " + (user.createdAt?.convertToMmmYyyyFormat() ?? "N/A")
    }
    
    //MARK: - Layout
    private func layoutUI() {
        for v in [headerView, itemView1, itemView2, dateLabel] {
            contentView.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                v.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                v.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            
            //Header
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            
            //Item1
            itemView1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemView1.heightAnchor.constraint(equalToConstant: itemHeight),
            
            
            //Item2
            itemView2.topAnchor.constraint(equalTo: itemView1.bottomAnchor, constant: padding),
            itemView2.heightAnchor.constraint(equalToConstant: itemHeight),
            
            //DateLabel
            dateLabel.topAnchor.constraint(equalTo: itemView2.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
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

extension UserInfoVC: FRepoVCCDelegate, FFollowersVCDelegate {
    
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl ?? "") else {
            presentFAllertOnMainThread(title: "Invalid URL", message: "URL of this user is invalid", buttonTitle: "OK")
            return }
        presentSafariVC(with: url)
    }
    
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentFAllertOnMainThread(title: "No Followers", message: "This user has no Followers", buttonTitle: "OK")
            return
        }
        guard let name = user.login else { return }
        delegate?.didRequestFollowers(for: name)
        dismiss(animated: true)
    }
}

