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
        for (_, food) in HomeTableViewCell.receipt {
            totalOfOrder += Double(truncating: food.price) * Double(food.amount)
        }
    }
    
}
