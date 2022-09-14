//
//  RestartButtonView.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-07.
//

import UIKit

extension PaymentSuccessController {
    
    func setUpRestartButton() {
        
        //Action
        restartButton.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
        
        //Constraints
        view.addSubview(restartButton)
        restartButton.addConstraint(top: clientNameLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 130, paddingLeft: 50, paddingRight: 50, paddingBottom: 0, width: 0, height: 50)
    }
    
    @objc func restartButtonTapped(sender: UIButton!) {

        //Create new instance of Tab Bar Controller
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true)
    }
    
}
