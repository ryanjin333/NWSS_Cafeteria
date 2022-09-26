//
//  RestartButton.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-25.
//

import UIKit

class RestartButton: UIButton {
    
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
        self.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
