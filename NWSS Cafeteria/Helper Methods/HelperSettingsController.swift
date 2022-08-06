//
//  HelperSettingsController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-07-31.
//

import UIKit

extension SettingsController {
    
    func setUpSettingsController() {
        
        view.backgroundColor = .backgroundWhite
    }
    
    @objc func doneButtonTapped(sender: UIButton!) {
        self.dismiss(animated: true)
    }
    
}
