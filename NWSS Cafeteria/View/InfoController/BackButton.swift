//
//  BackButton.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-29.
//

import UIKit

class BackButton: UIView {
    
    let backButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backArrow")
        return imageView
    }()
    
    let backButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    private func setupConstraints() {
        
        self.addSubview(backButtonImageView)
        self.addSubview(backButton)
        
        backButtonImageView.addConstraint(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        backButton.addConstraint(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
