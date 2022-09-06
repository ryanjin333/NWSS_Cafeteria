//
//  ApplePayButton.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-04.
//

import UIKit
import Stripe
import PassKit

extension CartController {
    
    func setUpPayButton() {
        
        //Pay Button Configurations
        payButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        createCustomerButton.addTarget(self, action: #selector(createCustomerButtonTapped), for: .touchUpInside)
        if totalOfOrder == 0 {
            payButton.isEnabled = false
            payButton.backgroundColor = .lightGray
        }
        else {
            payButton.isEnabled = true
            payButton.backgroundColor = .black
        }
        let config = STPPaymentConfiguration.shared
        config.applePayEnabled = true
        config.requiredShippingAddressFields = nil
        config.companyName = "NWSS Cafeteria"
        customerContext = STPCustomerContext(keyProvider: APIClient())
        paymentContext =  STPPaymentContext(customerContext: customerContext!, configuration: config, theme: .defaultTheme)
        self.paymentContext?.delegate = self
        self.paymentContext?.hostViewController = self
        self.paymentContext?.paymentAmount = Int(String(format: "%.2f", totalOfOrder).replacingOccurrences(of: ".", with: ""))!
        
        //Constraints
        view.addSubview(payButton)
        view.addSubview(createCustomerButton)
        payButton.addConstraint(top: nil, left: view.leftAnchor, right: view.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 0, paddingLeft: 20, paddingRight: 20, paddingBottom: 50, width: 0, height: 50)
        createCustomerButton.addConstraint(top: nil, left: view.leftAnchor, right: view.rightAnchor, bottom: payButton.topAnchor, paddingTop: 0, paddingLeft: 20, paddingRight: 20, paddingBottom: 10, width: 0, height: 50)
    }
    
    @objc func payButtonTapped(sender: UIButton!) {
        isPayButtonTapped = true
        self.paymentContext?.presentPaymentOptionsViewController()
    }
    
    @objc func createCustomerButtonTapped(sender: UIButton!) {
        APIClient.createCustomer()
        
    }
}

extension CartController: STPPaymentContextDelegate {
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        if isPayButtonTapped {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
             self.paymentContext?.requestPayment()
             self.isPayButtonTapped = false
            }
        }
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        debugPrint(error)
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {
        APIClient.createPaymentIntent(amount: (Double(paymentContext.paymentAmount)), currency: "cad", customerId: "cus_MNevla2Z946yLa") { (response) in
                    switch response {
                    case .success(let clientSecret):
                        // Assemble the PaymentIntent parameters
                        let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
                        paymentIntentParams.paymentMethodId = paymentResult.paymentMethod?.stripeId
                        paymentIntentParams.paymentMethodParams = paymentResult.paymentMethodParams
                        
                        STPPaymentHandler.shared().confirmPayment(paymentIntentParams, with: paymentContext) { status, paymentIntent, error in
                            switch status {
                            case .succeeded:
                                // Your backend asynchronously fulfills the customer's order, e.g. via webhook
                                completion(.success, nil)
                            case .failed:
                                completion(.error, error) // Report error
                            case .canceled:
                                completion(.userCancellation, nil) // Customer cancelled
                            @unknown default:
                                completion(.error, nil)
                            }
                        }
                    case .failure(let error):
                        completion(.error, error) // Report error from your API
                        break
                    }
                }
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        
    }
}
