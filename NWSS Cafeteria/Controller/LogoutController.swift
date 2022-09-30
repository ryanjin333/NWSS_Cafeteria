//
//  LogoutController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-23.
//

import UIKit
import FirebaseAuth


class LogoutController: UIViewController {
    
    let backButton = BackButton()
    
    let greetingTextLabel: UILabel = {
        let label = UILabel() 
        label.text = InfoControllerVariables.userLabel
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 32)
        return label
    }()
    
    let userPicture: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        return imageView
    }()
    
    let logoutButton = AccountButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogoutController()
        setupConstraints()
        setupBackButton()
        setupLogoutButton()
    }
    
    //MARK: - Back Button Function
    private func setupBackButton() {
        backButton.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped(sender: UIButton!) {
        dismiss(animated: true)
    }
    //MARK: - Logout Button Initialization
    
    private func setupLogoutButton() {
        let buttonTitle = "Log out"
        logoutButton.setInfo(buttonTitle: buttonTitle, isBordered: false)
        logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
    }
    
    @objc private func logoutButtonPressed(sender: UIButton!) {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            dismiss(animated: true)
        }
        catch {
            print("Could not log out")
        }
    }
    
    //MARK: - Constraints
    
    private func setupConstraints() {
        view.addSubview(greetingTextLabel)
        view.addSubview(logoutButton)
        greetingTextLabel.addConstraint(top: view.topAnchor, left: view.leftAnchor, right: nil, bottom: nil, paddingTop: InfoControllerVariables.greetingLabelTopConstraint, paddingLeft: InfoControllerVariables.leftRightPadding, paddingRight: 0, paddingBottom: 0, width: 200, height: 0)
        logoutButton.addConstraint(top: nil, left: view.leftAnchor, right: view.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 0, paddingLeft: InfoControllerVariables.leftRightPadding, paddingRight: InfoControllerVariables.leftRightPadding, paddingBottom: 40, width: 0, height: 50)
    }
}
