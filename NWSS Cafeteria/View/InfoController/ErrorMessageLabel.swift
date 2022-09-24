//
//  File.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-23.
//

import UIKit

class ErrorMessageLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupErrorLabel()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    convenience init(errorMessage: String) {
        self.init(frame: CGRect.zero)
        self.text = errorMessage
    }
    
    private func setupErrorLabel() {
        self.textColor = .red
        self.font = UIFont(name: "AvenirNext-Medium", size: 11)
        self.isHidden = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
