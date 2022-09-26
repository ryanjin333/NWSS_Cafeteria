//
//  HelperCartController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-24.
//

import UIKit
import Stripe
import FirebaseAuth

extension CartController {
    
    func setupCartController() {
        
        //General Configurations
        view.backgroundColor = .backgroundWhite
    }
    
    func getTotalOfOrder() {
        totalOfOrder = 0
        HomeTableViewCell.receipt.forEach {
            let itemTotal = Double(truncating: $1.price) * Double($1.amount)
            totalOfOrder += itemTotal
        }
    }
    
    func getPaymentDescription() {
        paymentDescription = ""
        HomeTableViewCell.receipt.forEach {
            paymentDescription += "\($1.amount) x \($0), "
        }
        if paymentDescription != "" {
            paymentDescription.removeLast(2)
        }
    }
}

//MARK: - Stripe Delegate

extension CartController: STPPaymentContextDelegate {
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        if isPayButtonTapped {
            
            DispatchQueue.main.async {
                //Set Controller in a Disabled State
                self.userInfoButton.backgroundColor = .lightGray
                self.payButton.backgroundColor = .lightGray
                UITabBar.appearance().tintColor = .lightGray
                self.view.isUserInteractionEnabled = false
                TabBarController.tabBarController?.view.isUserInteractionEnabled = false
                self.paymentStatusIndicator.isHidden = false
                self.paymentStatusIndicator.statusIndicator.startAnimating()
                
                //If in disabled state for a prolonged amount of time
                Timer.scheduledTimer(withTimeInterval: 8, repeats: false) { _ in 
                    self.paymentStatusIndicator.isHidden = true
                    self.paymentStatusIndicator.statusIndicator.stopAnimating()
                    self.userInfoButton.backgroundColor = .black
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
        paymentStatusIndicator.isHidden = true
        paymentStatusIndicator.statusIndicator.stopAnimating()
        userInfoButton.backgroundColor = .black
        payButton.backgroundColor = .black
        self.view.isUserInteractionEnabled = true
        UITabBar.appearance().tintColor = .schoolOrange
        TabBarController.tabBarController?.view.isUserInteractionEnabled = true
        self.isPayButtonTapped = false
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {
        guard let currentUser = FirebaseAuth.Auth.auth().currentUser?.uid else {
            print("No current user")
            return
        }
        APIClient.createPaymentIntent(amount: (Double(paymentContext.paymentAmount)), currency: "cad", customerId: currentUser, description: paymentDescription) { (response) in
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
            paymentStatusIndicator.isHidden = true
            paymentStatusIndicator.statusIndicator.stopAnimating()
            userInfoButton.backgroundColor = .black
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
            paymentStatusIndicator.isHidden = true
            paymentStatusIndicator.statusIndicator.stopAnimating()
            userInfoButton.backgroundColor = .black
            payButton.backgroundColor = .black
            self.view.isUserInteractionEnabled = true
            UITabBar.appearance().tintColor = .schoolOrange
            TabBarController.tabBarController?.view.isUserInteractionEnabled = true
            self.isPayButtonTapped = false
        }
        
    }
}

//MARK: - Receipt Table View Data Source

extension CartController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeTableViewCell.receipt.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = receiptTableView.dequeueReusableCell(withIdentifier: "receiptCell", for: indexPath) as! ReceiptTableViewCell
        cell.getFoodNames()
        cell.set(indexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromDisappearing = scrollView.contentSize.height - contentYoffset - HomeControllerVariables.cellHeight / 2
        if scrollView.contentOffset.y <= 20 {
            UIView.animate(withDuration: 0.25) {
                self.scrollDownLabel.alpha = 1
            }
        }
        if distanceFromDisappearing <= height && scrollView.contentOffset.y > 0 {
            UIView.animate(withDuration: 0.25) {
                self.scrollDownLabel.alpha = 0
            }
        }
    }
}

//MARK: - Receipt Table View Delegate

extension CartController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  HomeControllerVariables.cellHeight
    }
}


