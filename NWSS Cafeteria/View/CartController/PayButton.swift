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
        if totalOfOrder == 0 {
            payButton.isEnabled = false
            payButton.backgroundColor = .lightGray
        }
        else {
            payButton.isEnabled = true
            payButton.backgroundColor = .black
        }
    
        
        let config = STPPaymentConfiguration.shared
        config.requiredShippingAddressFields = nil
        config.companyName = "NWSS Cafeteria"
        customerContext = STPCustomerContext(keyProvider: APIClient())
        paymentContext =  STPPaymentContext(customerContext: customerContext!, configuration: config, theme: .defaultTheme)
        self.paymentContext?.delegate = self
        self.paymentContext?.hostViewController = self
        self.paymentContext?.paymentAmount = Int(String(format: "%.2f", totalOfOrder).replacingOccurrences(of: ".", with: ""))!
        
        //Constraints
        view.addSubview(payButton)
        payButton.addConstraint(top: nil, left: view.leftAnchor, right: view.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 0, paddingLeft: 20, paddingRight: 20, paddingBottom: 50, width: 0, height: 50)
    }
    
    @objc func payButtonTapped(sender: UIButton!) {
        isPayButtonTapped = true
        self.paymentContext?.presentPaymentOptionsViewController()
    }
}

extension CartController: STPPaymentContextDelegate {
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        if isPayButtonTapped {
            
            DispatchQueue.main.async {
                //Set Controller in a Disabled State
                self.createCustomerButton.backgroundColor = .lightGray
                self.payButton.backgroundColor = .lightGray
                UITabBar.appearance().tintColor = .lightGray
                self.view.isUserInteractionEnabled = false
                TabBarController.tabBarController?.view.isUserInteractionEnabled = false
                self.paymentStatusIndicatorView.isHidden = false
                self.paymentStatusIndicator.startAnimating()
                
                //If in disabled state for a prolonged amount of time
                Timer.scheduledTimer(withTimeInterval: 8, repeats: false) { _ in 
                    self.paymentStatusIndicatorView.isHidden = true
                    self.paymentStatusIndicator.stopAnimating()
                    self.createCustomerButton.backgroundColor = .black
                    self.payButton.backgroundColor = .black
                    self.view.isUserInteractionEnabled = true
                    UITabBar.appearance().tintColor = .schoolOrange
                    TabBarController.tabBarController?.view.isUserInteractionEnabled = true
                    self.isPayButtonTapped = false
                }
                
                //Request payment controller
                self.isPayButtonTapped = true
                self.paymentContext?.requestPayment()
            }
        }
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        paymentStatusIndicatorView.isHidden = true
        paymentStatusIndicator.stopAnimating()
        createCustomerButton.backgroundColor = .black
        payButton.backgroundColor = .black
        self.view.isUserInteractionEnabled = true
        UITabBar.appearance().tintColor = .schoolOrange
        TabBarController.tabBarController?.view.isUserInteractionEnabled = true
        self.isPayButtonTapped = false
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {
        APIClient.createPaymentIntent(amount: (Double(paymentContext.paymentAmount)), currency: "cad", customerId: "bruh", description: paymentDescription) { (response) in
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
        
        if status == .success {
            //Reset View
            let paymentSuccessController = PaymentSuccessController()
            paymentStatusIndicatorView.isHidden = true
            paymentStatusIndicator.stopAnimating()
            createCustomerButton.backgroundColor = .black
            payButton.backgroundColor = .black
            self.view.isUserInteractionEnabled = true
            UITabBar.appearance().tintColor = .schoolOrange
            TabBarController.tabBarController?.view.isUserInteractionEnabled = true
            self.isPayButtonTapped = false
            
            //Reset Variables
            totalOfOrder = 0
            HomeTableViewCell.receipt = [:]
            
            //Segue
            paymentSuccessController.modalPresentationStyle = .fullScreen
            present(paymentSuccessController, animated: true)
        }
        else {
            paymentStatusIndicatorView.isHidden = true
            paymentStatusIndicator.stopAnimating()
            createCustomerButton.backgroundColor = .black
            payButton.backgroundColor = .black
            self.view.isUserInteractionEnabled = true
            UITabBar.appearance().tintColor = .schoolOrange
            TabBarController.tabBarController?.view.isUserInteractionEnabled = true
            self.isPayButtonTapped = false
        }
        
    }
    
    
}
