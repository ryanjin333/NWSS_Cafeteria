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
        payButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        
        view.addSubview(payButton)
        payButton.addConstraint(top: nil, left: nil, right: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 50, width: 300, height: 50)
        payButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
