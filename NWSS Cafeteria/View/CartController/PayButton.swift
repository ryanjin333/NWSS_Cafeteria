//
//  ApplePayButton.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-04.
//

import UIKit

class PayButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    convenience init(buttonTitle: String) {
        self.init(frame: CGRect.zero)
        self.setTitle(buttonTitle, for: .normal)
    }
    
    private func setupButton() {
        self.backgroundColor = .black
        //self.layer.applyShadow(color: .black, alpha: 0.5, x: 0, y: 3, blur: 8, spread: 0)
        self.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
