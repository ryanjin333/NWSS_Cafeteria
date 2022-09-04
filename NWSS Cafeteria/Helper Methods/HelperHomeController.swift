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

    }
    
    //MARK: - Home Controller Buttons
    
    @objc func settingsButtonTapped(sender: UIButton!) {
        settingsController.modalPresentationStyle = .fullScreen
        present(settingsController, animated: true, completion: nil)
    }
    
    @objc func cartButtonTapped(sender: UIButton!) {
        present(cartController, animated: true, completion: nil)
    }
    
}

