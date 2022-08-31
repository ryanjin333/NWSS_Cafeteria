//
//  Receipt.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-26.
//

import UIKit

struct Receipt {
    var price: NSNumber
    var image: String
    var amount: Int
    
    init(price: NSNumber, image: String, amount: Int) {
        self.price = price
        self.image = image
        self.amount = amount
    }
    
}
