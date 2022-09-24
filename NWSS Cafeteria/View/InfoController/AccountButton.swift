//
//  ShadowedButton.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-22.
//

import UIKit

class AccountButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    func setInfo(buttonTitle: String, isBordered: Bool) {
        self.setTitle(buttonTitle, for: .normal)
        
        //Variables
        var buttonBackgroundColor: UIColor = .black
        var titleColor: UIColor = .white
        
        //Check if bordered
        if isBordered {
            buttonBackgroundColor = .backgroundWhite
            titleColor = .lightGray
            self.layer.borderWidth = 2
            self.layer.borderColor = UIColor.darkerSpecialGrey.cgColor
        }
        
        //Set Button Attributes
        self.backgroundColor = buttonBackgroundColor
        self.setTitleColor(titleColor, for: .normal)
        self.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
