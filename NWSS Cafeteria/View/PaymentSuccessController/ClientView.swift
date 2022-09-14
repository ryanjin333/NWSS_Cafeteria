//
//  ClientView.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-07.
//

import UIKit

extension PaymentSuccessController {
    
    func setUpClientView() {
        
        //Constraints
        view.addSubview(checkmarkImageView)
        view.addSubview(paymentConfirmedLabel)
        view.addSubview(clientNameLabel)
        
        checkmarkImageView.addConstraint(top: nil, left: nil, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 100, height: 100)
        checkmarkImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        paymentConfirmedLabel.addConstraint(top: checkmarkImageView.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 20, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 21)
        paymentConfirmedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        paymentConfirmedLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        clientNameLabel.addConstraint(top: paymentConfirmedLabel.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 5, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 17)
        clientNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
}
