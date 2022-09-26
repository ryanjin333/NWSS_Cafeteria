//
//  LogoutController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-23.
//

import UIKit
import FirebaseAuth


class LogoutController: UIViewController {
    
    let logoutButton = AccountButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogoutController()
        setupConstraints()
        setupLogoutButton()
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
        view.addSubview(logoutButton)
        logoutButton.addConstraint(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 200, paddingLeft: InfoControllerVariables.leftRightPadding, paddingRight: InfoControllerVariables.leftRightPadding, paddingBottom: 0, width: 0, height: 50)
    }
}
