//
//  CartControllerBarView.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-24.
//

import UIKit

extension CartController {
    
    //MARK: - Bar Initialization
    
    func setUpCartBar() {
        
        //Others
        cartNavigationBar.setItems([cartNavigationTitle], animated: false)
        //cartNavigationBar.topItem?.leftBarButtonItem = doneButton
        
        //Constraints
        view.addSubview(cartNavigationBar)
        cartNavigationBar.addConstraint(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
}
