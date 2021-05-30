//
//  ViewController.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 14.05.21.
//

import UIKit

class SearchVC: UIViewController {
    
    //MARK: - Interface
    
    let logoImageView = UIImageView()
    let userTextField = FTextField()
    let callToActionButton = FButton(color: .systemGreen, title: "Get Followers")
    var logoTopConstr: NSLayoutConstraint!
    
    
    //MARK: - Properties
    var isUsernmeEntered: Bool {
        guard let text = userTextField.text else {return false}
        return !text.isEmtyOrWhiteSpace()
    }
    
    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureImageLogoView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        userTextField.text = ""
    }

    
    //MARK: - Methods
    
    private func configureImageLogoView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.logo
        
        let topDistance: CGFloat = DeviceTypes.isSmallScreen ? 20 : 80
        
        logoTopConstr = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topDistance)
        
        NSLayoutConstraint.activate([
            logoTopConstr,
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor)
        ])
    }
    
    
    private func configureTextField() {
        view.addSubview(userTextField)
        userTextField.delegate = self
        
        NSLayoutConstraint.activate([
            userTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    private func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    private func createDismissKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        
        view.addGestureRecognizer(tap)
    }
    
    
    @objc private func pushFollowerListVC() {
        guard isUsernmeEntered else {
            presentFAllertOnMainThread(title: "Empty Username", message: "Please enter username 😁", buttonTitle: "OK")
            return
        }
        
        userTextField.resignFirstResponder()
        
        let vc = FollowerListVC(userName: userTextField.text!)
        navigationController?.pushViewController(vc, animated: true)
    }
}
    

    //MARK: - Extensions

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        textField.resignFirstResponder()
        return true
    }
}



//MARK: - Sendmail
import MessageUI

extension SearchVC: MFMailComposeViewControllerDelegate {
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["you@yoursite.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            let image = UIImage(systemName: "hare")
            
            mail.addAttachmentData(image!.pngData()!, mimeType: "image/png", fileName: "one")
            
            mail.setMessageBody("GGGG", isHTML: false)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
