//
//  FItemInfoVC.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 20.05.21.
//

import UIKit

class FItemInfoVC: UIViewController {

    
    //MARK: - Interface
    
    let stackView = UIStackView()
    let itemInfoView1 = FItemInfoView()
    let itemInfoView2 = FItemInfoView()
    var actionButton = FButton()
    
    //MARK: - Properties
    let padding: CGFloat = 20
    var user: User
    
    //MARK: - LifeCycle Methods
    
    init (user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        layoutUI()
        configStackView()

    }
    
    //MARK: - Methods
    
    private func configureVC() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
    }
    
    private func layoutUI() {
        
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.addArrangedSubview(itemInfoView1)
        stackView.addArrangedSubview(itemInfoView2)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
    }
    
    //MARK: - Extensions

    

}
