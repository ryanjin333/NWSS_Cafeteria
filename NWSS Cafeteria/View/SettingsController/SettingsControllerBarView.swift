//
//  SettingsControllerBarView.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-07-31.
//

import UIKit

extension SettingsController {
    
    //MARK: - Bar Initialization
    
    func setUpSettingsBar() {
        
        //Others
        settingsNavigationBar.setItems([settingsNavigationTitle], animated: false)
        
        //Constraints
        view.addSubview(settingsNavigationBar)
        settingsNavigationBar.addConstraint(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
    }
    
}
