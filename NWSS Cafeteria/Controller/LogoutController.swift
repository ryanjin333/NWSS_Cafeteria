//
//  LogoutController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class LogoutController: UIViewController {
    
    let backButton = BackButton()
    
    let greetingTextLabel: UILabel = {
        let label = UILabel() 
        label.text = InfoControllerVariables.userLabel
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 32)
        return label
    }()
    
    let userPictureView = UserProfileImageView()
    
    let userInfoLabel = UserInfoLabel()
    
    let logoutButton = AccountButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogoutController()
        setupConstraints()
        setupBackButton()
        setupUserInfoLabel()
        setupLogoutButton()
    }
    
    //MARK: - Back Button Function
    private func setupBackButton() {
        backButton.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped(sender: UIButton!) {
        dismiss(animated: true)
    }
    
    //MARK: - User Info Label Initialization
    
    private func setupUserInfoLabel() {
        
        var userName = String()
        var userEmail = String()
        
        let auth = FirebaseAuth.Auth.auth()
        let firestoreDataBase = Firestore.firestore()
        let userRef = firestoreDataBase.collection("customers").document(auth.currentUser!.uid)
        userRef.collection("general").document("info").getDocument() { document, error in
            if let error = error {
                print("Error getting documents: \(error)")
            }
            else {
                userName = document?.get("name") as! String
                userEmail = document?.get("email") as! String
                self.userInfoLabel.setLabelText(nameLabelText: userName, emailLabelText: userEmail)
            }
       }
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
            weak var logoutController = self.presentingViewController
            
            dismiss(animated: true) {
                let loginController = LoginController()
                logoutController?.present(loginController, animated: true)
            }
        }
        catch {
            print("Could not log out")
        }
    }
    
    //MARK: - Constraints
    
    private func setupConstraints() {
        view.addSubview(backButton)
        view.addSubview(greetingTextLabel)
        view.addSubview(userPictureView)
        view.addSubview(userInfoLabel)
        view.addSubview(logoutButton)
        backButton.addConstraint(top: view.topAnchor, left: view.leftAnchor, right: nil, bottom: nil, paddingTop: 20, paddingLeft: InfoControllerVariables.leftRightPadding, paddingRight: 0, paddingBottom: 0, width: 35, height: 35)
        greetingTextLabel.addConstraint(top: backButton.bottomAnchor, left: view.leftAnchor, right: nil, bottom: nil, paddingTop: InfoControllerVariables.greetingLabelTopConstraint, paddingLeft: InfoControllerVariables.leftRightPadding, paddingRight: 0, paddingBottom: 0, width: 200, height: 0)
        userPictureView.addConstraint(top: nil, left: nil, right: nil, bottom: userInfoLabel.topAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 30, width: InfoControllerVariables.userProfilePictureLength, height: InfoControllerVariables.userProfilePictureLength)
        userPictureView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userInfoLabel.addConstraint(top: nil, left: nil, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        userInfoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userInfoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoutButton.addConstraint(top: nil, left: view.leftAnchor, right: view.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 0, paddingLeft: InfoControllerVariables.leftRightPadding, paddingRight: InfoControllerVariables.leftRightPadding, paddingBottom: 40, width: 0, height: 50)
    }
}
