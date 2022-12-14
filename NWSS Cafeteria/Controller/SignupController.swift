//
//  SignupController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignupController: InfoController {
    
    let nameTextfield: UserInfoTextFieldView = {
        let view = UserInfoTextFieldView()
        let iconName = "nameIcon"
        view.setInfo(imageName: iconName, imageNameSelected: "\(iconName)Selected", placeholderText: "Full Name", isPassword: false)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGreetingTextLabel(textLabel: InfoControllerVariables.signupLabel)
        setupSignupButton()
        setupLoginButton()
    }
    
    //MARK: - Signup Button Initialization
    
    private func setupSignupButton() {
        let buttonTitle = "Sign up"
        topButton.setInfo(buttonTitle: buttonTitle, isBordered: false)
        topButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    
    @objc private func signupButtonTapped(sender: UIButton!) {
        guard let name = nameTextfield.userInfoTextField.text , !name.isEmpty,
              let email = emailTextfield.userInfoTextField.text, !email.isEmpty,
              let password = passwordTextfield.userInfoTextField.text, !password.isEmpty else {
            continueErrorLabel.isHidden = true
            missingFieldErrorLabel.isHidden = false
            return
        }
        
        //Firebase Auth
        let auth = FirebaseAuth.Auth.auth()
        auth.createUser(withEmail: email, password: password) { result, error in            
            guard error == nil else {
                self.missingFieldErrorLabel.isHidden = true
                self.continueErrorLabel.text = InfoControllerVariables.signupErrorMessage
                self.continueErrorLabel.isHidden = false
                return
            }
            
            let data = [
                "name" : name,
                "email" : email
            ]
            
            let firestoreDatabase = Firestore.firestore()
            firestoreDatabase.collection("customers").document(auth.currentUser!.uid).collection("general").document("info").setData(data) { error in
                if let error = error {
                    print("Error writing document: \(error)")
                }
                else {
                    print("Document successfully written!")
                }
                
            }
            
            //TODO: Implement when payment gateway is needed
            
            //APIClient.createCustomer(email: email, name: name, customerId: auth.currentUser!.uid)
            self.dismiss(animated: true)
        }
    }
    
    //MARK: - Login Button Initialization
    
    private func setupLoginButton() {
        let buttonTitle = "Log in"
        bottomButton.setInfo(buttonTitle: buttonTitle, isBordered: true)
        bottomButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped(sender: UIButton!) {
        weak var signupController = self.presentingViewController
        
        dismiss(animated: true) {
            let loginController = LoginController()
            signupController?.present(loginController, animated: true)
        }
    }
    
    //MARK: - Constraints
    
    override func setupConstraints() {
        super.setupConstraints()
        view.addSubview(nameTextfield)
        
        nameTextfield.addConstraint(top: nil, left: view.leftAnchor, right: view.rightAnchor, bottom: emailTextfield.topAnchor, paddingTop: 0, paddingLeft: InfoControllerVariables.leftRightPadding, paddingRight: InfoControllerVariables.leftRightPadding, paddingBottom: 20, width: 0, height: 50)
     }
}
