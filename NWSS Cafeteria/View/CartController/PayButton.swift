//
//  PayButton.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-25.
//

import UIKit
import PassKit

extension CartController {
    
    func setUpPayButton() {
        
        //General Configurations
        paymentRequest.paymentSummaryItems = [PKPaymentSummaryItem(label: "NWSS Cafeteria", amount: NSDecimalNumber(value: totalOfOrder))]
        
        //Button Setup
        payButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        
        //Button Constraints
        view.addSubview(payButton)
        payButton.addConstraint(top: nil, left: view.leftAnchor, right: view.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 0, paddingLeft: 20, paddingRight: 20, paddingBottom: 50, width: 0, height: 50)
    }
    
    @objc func payButtonTapped(sender: UIButton!) {
        let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
        if let controller = controller {
            controller.delegate = self
            present(controller, animated: true) {
                print("Completed")
            }
        }
    }
}

extension CartController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
}
