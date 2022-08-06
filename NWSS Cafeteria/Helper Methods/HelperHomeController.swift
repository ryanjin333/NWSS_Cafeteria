//
//  HelperHomeController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-07-23.
//

import UIKit

extension HomeController {
    
    //MARK: - Home Controller Initialization
    
    func setUpHomeController() {
        
        view.backgroundColor = .backgroundWhite
        
    }
    
    //MARK: - Home Controller Buttons
    
    @objc func settingsButtonTapped(sender: UIButton!) {
        let settingsController = SettingsController()
            settingsController.modalPresentationStyle = .fullScreen
        present(settingsController, animated: true, completion: nil)
    }
    
}

