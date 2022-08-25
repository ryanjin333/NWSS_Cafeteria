//
//  CartButton.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-24.
//

import UIKit

extension HomeController {
    
    func setUpCartButton() {
        cartButton.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        view.addSubview(cartButtonShadow)
        view.addSubview(cartButton)
        cartButtonShadow.addConstraint(top: nil, left: nil, right: view.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 50, paddingBottom: 50, width: HomeControllerVariables.cartButtonLength, height: HomeControllerVariables.cartButtonLength)
        cartButton.addConstraint(top: nil, left: nil, right: view.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 50, paddingBottom: 50, width: HomeControllerVariables.cartButtonLength, height: HomeControllerVariables.cartButtonLength)
    }
    
}
