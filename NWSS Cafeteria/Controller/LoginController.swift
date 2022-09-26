//
//  LogInController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-20.
//

import UIKit
import FirebaseAuth

class LoginController: InfoController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGreetingTextLabel(textLabel: InfoControllerVariables.loginLabel)
        setupLoginButton()
        setupSignupButton()
    }
    
    //MARK: - Login Button Initialization
    
    private func setupLoginButton() {
        let buttonTitle = "Log in"
        topButton.setInfo(buttonTitle: buttonTitle, isBordered: false)
        topButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped(sender: UIButton!) {
        guard let email = emailTextfield.userInfoTextField.text, !email.isEmpty, 
              let password = passwordTextfield.userInfoTextField.text, !password.isEmpty else {
            continueErrorLabel.isHidden = true
            missingFieldErrorLabel.isHidden = false
            return
        }
        
        //Firebase Auth
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { result, error in            
            guard error == nil else {
                self.missingFieldErrorLabel.isHidden = true
                self.continueErrorLabel.text = InfoControllerVariables.loginErrorMessage
                self.continueErrorLabel.isHidden = false
                return
            }
            self.dismiss(animated: true)
        }
    }
    
    //MARK: - Signup Button Initialization
    private func setupSignupButton() {
        let buttonTitle = "Sign up"
        bottomButton.setInfo(buttonTitle: buttonTitle, isBordered: true)
        bottomButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    
    @objc private func signupButtonTapped(sender: UIButton!) {
        weak var loginController = self.presentingViewController
        
        dismiss(animated: true) {
            let signupController = SignupController()
            loginController?.present(signupController, animated: true)
        }
    }
    
    
    //MARK: - Constraints
   override func setupConstraints() {
       super.setupConstraints()
    }
    
}
