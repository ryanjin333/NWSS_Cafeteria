//
//  PaymentSuccessLabel.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-25.
//

import UIKit

class PaymentSuccessLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    func setInfo(text: String, textSize: CGFloat, textColor: UIColor) {
        self.text = text
        self.font = UIFont(name: "AvenirNext-DemiBold", size: textSize)
        self.textColor = textColor
    }
    
    private func setupLabel() {
        self.numberOfLines = 0
        self.textAlignment = .center
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
