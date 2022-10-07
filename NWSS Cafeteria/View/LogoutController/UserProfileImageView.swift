//
//  UserPictureImageView.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-10-06.
//

import UIKit

class UserProfileImageView: UIView {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView() 
        imageView.image = UIImage(named: "profilePictureIcon")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    convenience init(imageName: String) {
        self.init(frame: CGRect.zero)
        profileImageView.image = UIImage(named: imageName)
    }
    
    private func setupView() {
        self.backgroundColor = .backgroundWhite
        self.layer.applyShadow(color: .black, alpha: 0.1, x: 0, y: 4, blur: 11, spread: 0)
        self.layer.cornerRadius = 0.5 * InfoControllerVariables.userProfilePictureLength
    }
    
    private func setupConstraints() {
        self.addSubview(profileImageView)
        profileImageView.addConstraint(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, paddingTop: 15, paddingLeft: 15, paddingRight: 15, paddingBottom: 15, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } 
}
