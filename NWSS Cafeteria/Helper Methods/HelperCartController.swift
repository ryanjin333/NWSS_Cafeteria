//
//  HelperCartController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-24.
//

import UIKit

extension CartController {
    
    func setUpCartController() {
        
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
