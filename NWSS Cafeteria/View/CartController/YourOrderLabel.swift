//
//  YourCartLabel.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-28.
//

import UIKit

extension CartController {
    
    func setUpYourOrderLabel() {
        view.addSubview(yourOrderLabel)
        yourOrderLabel.addConstraint(top: cartNavigationBar.bottomAnchor, left: view.leftAnchor, right: nil, bottom: nil, paddingTop: 10, paddingLeft: 20, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
}
