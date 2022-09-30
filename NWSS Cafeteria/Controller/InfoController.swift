//
//  InfoController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-22.
//

import UIKit

class InfoController: UIViewController {
    
    let backButton = BackButton()
    
    let greetingTextLabel: UILabel = {
        let label = UILabel() 
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 32)
        label.numberOfLines = 0
        return label
    }()
    
    let emailTextfield: UserInfoTextFieldView = {
        let view = UserInfoTextFieldView()
        let iconName = "mailIcon"
        view.setInfo(imageName: iconName, imageNameSelected: "\(iconName)Selected", placeholderText: "Email", isPassword: false)
        return view
    }()
    
    let passwordTextfield: UserInfoTextFieldView = {
        let view = UserInfoTextFieldView()
        let iconName = "passwordIcon"
        view.setInfo(imageName: iconName, imageNameSelected: "\(iconName)Selected", placeholderText: "Password", isPassword: true)
        return view
    }()
    
    let topButton = AccountButton()
    
    let bottomButton = AccountButton()
    
    let continueErrorLabel = ErrorMessageLabel()
    
    let missingFieldErrorLabel = ErrorMessageLabel(errorMessage: InfoControllerVariables.missingFieldMessage)
    
    let topAndBottomButtonDivider: UILabel = {
        let label = UILabel()
        let text = "or"
        label.textColor = .lightGray
        label.text = text
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInfoController()
        setupConstraints()
        setupBackButton()
        setupKeyboardLayout()
    }
    
    //MARK: - Info Controller Functions
    func setupGreetingTextLabel(textLabel: String) {
        let textLabel = textLabel
        greetingTextLabel.text = textLabel
    }
    
    //MARK: - Keyboard Layout
    
    func setupKeyboardLayout() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    //MARK: - Back Button Functions
    private func setupBackButton() {
        backButton.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc private func backButtonPressed(sender: UIButton!) {
        dismiss(animated: true)
    }
    
    //MARK: - Constraints
    func setupConstraints() {
        view.addSubview(backButton)
        view.addSubview(greetingTextLabel)
        view.addSubview(emailTextfield)
        view.addSubview(passwordTextfield)
        view.addSubview(continueErrorLabel)
        view.addSubview(missingFieldErrorLabel)
        view.addSubview(topButton)
        view.addSubview(topAndBottomButtonDivider)
        view.addSubview(bottomButton)
        
        backButton.addConstraint(top: view.topAnchor, left: view.leftAnchor, right: nil, bottom: nil, paddingTop: 20, paddingLeft: InfoControllerVariables.leftRightPadding, paddingRight: 0, paddingBottom: 0, width: 35, height: 35)
        greetingTextLabel.addConstraint(top: backButton.bottomAnchor, left: view.leftAnchor, right: nil, bottom: nil, paddingTop: InfoControllerVariables.greetingLabelTopConstraint, paddingLeft: InfoControllerVariables.leftRightPadding, paddingRight: 0, paddingBottom: 0, width: 150, height: 0)
        emailTextfield.addConstraint(top: nil, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: InfoControllerVariables.leftRightPadding, paddingRight: InfoControllerVariables.leftRightPadding, paddingBottom: 0, width: 0, height: 50)
        passwordTextfield.addConstraint(top: emailTextfield.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 20, paddingLeft: InfoControllerVariables.leftRightPadding, paddingRight: InfoControllerVariables.leftRightPadding, paddingBottom: 0, width: 0, height: 50)
        continueErrorLabel.addConstraint(top: passwordTextfield.bottomAnchor, left: nil, right: nil, bottom: topButton.topAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 3, width: 0, height: 0)
        continueErrorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        missingFieldErrorLabel.addConstraint(top: passwordTextfield.bottomAnchor, left: nil, right: nil, bottom: topButton.topAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 3, width: 0, height: 0)
        missingFieldErrorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topButton.addConstraint(top: passwordTextfield.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 30, paddingLeft: InfoControllerVariables.leftRightPadding, paddingRight: InfoControllerVariables.leftRightPadding, paddingBottom: 0, width: 0, height: 50)
        topAndBottomButtonDivider.addConstraint(top: topButton.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 10, paddingLeft: InfoControllerVariables.leftRightPadding, paddingRight: InfoControllerVariables.leftRightPadding, paddingBottom: 0, width: 0, height: 0)
        topAndBottomButtonDivider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomButton.addConstraint(top: topAndBottomButtonDivider.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 10, paddingLeft: InfoControllerVariables.leftRightPadding, paddingRight: InfoControllerVariables.leftRightPadding, paddingBottom: 40, width: 0, height: 50)
    }
    
}
