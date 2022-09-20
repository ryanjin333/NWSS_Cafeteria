//
//  CreateCustomerButton.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-17.
//

import UIKit
import FirebaseAuthUI

extension CartController {
    
    func setUpCreateCustomerButton() {
        
        //Create Customer Button Configurations
        createCustomerButton.addTarget(self, action: #selector(createCustomerButtonTapped), for: .touchUpInside)
        
        //Constraints
        view.addSubview(createCustomerButton)
        createCustomerButton.addConstraint(top: nil, left: view.leftAnchor, right: view.rightAnchor, bottom: payButton.topAnchor, paddingTop: 0, paddingLeft: 20, paddingRight: 20, paddingBottom: 10, width: 0, height: 50)
        
    }
    
    @objc func createCustomerButtonTapped(sender: UIButton!) {
        APIClient.createCustomer()
        
//        //Get the default auth UI Object
//        let authUI = FUIAuth.defaultAuthUI()
//        guard authUI != nil else { return }
//        
//        //Set delegate to self
//        authUI?.delegate = self
//        
//        //Get reference to auth UI view controller
//        let authViewController = authUI?.authViewController()
//        
//        //Present controller
//        present(authViewController!, animated: true, completion: nil)
    }
}

//MARK: - Auth UI Delegate

//extension CartController: FUIAuthDelegate {
//    
//    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
//        
//        //Check for Error
//        guard error == nil else { 
//            print(error?.localizedDescription as Any)
//            return 
//        }
//        
//        //Get UID: authDataResult?.user.uid
//        
//        dismiss(animated: true)
//        
//    }
//}
