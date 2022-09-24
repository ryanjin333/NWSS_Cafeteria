//
//  UserInfoButton.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-22.
//

import UIKit

class UserInfoButton: UIView {
    
    let tappableButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    let userInfoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    let userInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    private func setupConstraints() {
        self.addSubview(userInfoImageView)
        self.addSubview(userInfoLabel)
        self.addSubview(tappableButton)

        userInfoImageView.addConstraint(top: nil, left: self.leftAnchor, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: 20, height: 20)
        userInfoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        userInfoLabel.addConstraint(top: nil, left: nil, right: self.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 15, paddingBottom: 0, width: 0, height: 20)
        userInfoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        tappableButton.addConstraint(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
    private func setupView() {
        self.layer.cornerRadius = 0.5 * CartControllerVariables.userInfoButtonHeight
        self.backgroundColor = .black
        self.layer.applyShadow(color: .black, alpha: 0.5, x: 0, y: 2, blur: 8, spread: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
