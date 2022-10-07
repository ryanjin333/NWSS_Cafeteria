//
//  UserInfoLabel.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-10-06.
//

import UIKit

class UserInfoLabel: UIView {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        label.textAlignment = .center
        return label
    }()
    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupLabels()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    func setLabelText(nameLabelText: String, emailLabelText: String) {
        self.nameLabel.text = nameLabelText
        self.emailLabel.text = emailLabelText
    }
    
    
    private func setupLabels() {
        
    }
    
    private func setupConstraints() {
        self.addSubview(nameLabel)
        self.addSubview(emailLabel)
        nameLabel.addConstraint(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        emailLabel.addConstraint(top: nameLabel.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
