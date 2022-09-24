//
//  LogInPageView.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-20.
//

import UIKit

class UserInfoTextFieldView: UIView, UITextFieldDelegate {
    
    //MARK: View Variables
    let iconImageView = UIImageView()
    
    let userInfoTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        return textField
        
    }()
    
    let textFieldDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .specialGrey
        view.layer.cornerRadius = 2
        return view
    }()
    
    var imageName = String()
    var imageNameSelected = String()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupUserInfoTextField()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    func setInfo(imageName: String, imageNameSelected: String, placeholderText: String, isPassword: Bool) {
        
        //Set variables
        self.imageName = imageName
        self.imageNameSelected = imageNameSelected
        
        //Set view attributes
        iconImageView.image = UIImage(named: imageName)
        userInfoTextField.placeholder = placeholderText
        userInfoTextField.isSecureTextEntry = isPassword
    }
    
    private func setupUserInfoTextField() {
        userInfoTextField.delegate = self
    }
    
    private func setupConstraints() {
        self.addSubview(iconImageView)
        self.addSubview(userInfoTextField)
        self.addSubview(textFieldDivider)
        
        let iconDimensions: CGFloat = 25
        
        iconImageView.addConstraint(top: self.topAnchor, left: self.leftAnchor, right: nil, bottom: nil, paddingTop: 7, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: iconDimensions, height: iconDimensions)
        userInfoTextField.addConstraint(top: self.topAnchor, left: iconImageView.rightAnchor, right: self.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 20, paddingRight: 0, paddingBottom: 0, width: 0, height: 40)
        textFieldDivider.addConstraint(top: userInfoTextField.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, bottom: nil, paddingTop: 5, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserInfoTextFieldView: UITextViewDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldDivider.backgroundColor = .systemBlue
        iconImageView.image = UIImage(named: imageNameSelected)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            textFieldDivider.backgroundColor = .specialGrey
            iconImageView.image = UIImage(named: imageName)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    
}
