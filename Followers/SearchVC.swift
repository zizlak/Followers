//
//  ViewController.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 14.05.21.
//

import UIKit

class SearchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        let b = FButton(color: .systemBlue, title: "RRR")
        view.addSubview(b)
        b.topAnchor.constraint(equalTo: view.topAnchor, constant: 160).isActive = true
        b.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        b.widthAnchor.constraint(equalToConstant: 120).isActive = true
        b.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }


}

