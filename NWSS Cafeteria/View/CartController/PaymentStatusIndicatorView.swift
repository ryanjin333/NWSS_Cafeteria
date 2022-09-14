//
//  PaymentStatusActivityIndicatorView.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-07.
//

import UIKit

extension CartController {
    
    func setUpPaymentStatusIndicatorView() {
        
        //Constraints
        view.addSubview(paymentStatusIndicatorView)
        paymentStatusIndicatorView.addSubview(paymentStatusIndicator)
        
        paymentStatusIndicatorView.addConstraint(top: nil, left: nil, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 80, height: 80)
        paymentStatusIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        paymentStatusIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        paymentStatusIndicator.addConstraint(top: nil, left: nil, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 80, height: 80)
        paymentStatusIndicator.centerXAnchor.constraint(equalTo: paymentStatusIndicatorView.centerXAnchor).isActive = true
        paymentStatusIndicator.centerYAnchor.constraint(equalTo: paymentStatusIndicatorView.centerYAnchor).isActive = true
        
    }
    
    
}
