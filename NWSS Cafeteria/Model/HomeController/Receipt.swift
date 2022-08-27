//
//  Receipt.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-26.
//

import UIKit

struct Receipt {
    var name: String
    var price: NSNumber
    var amount: Int
    
    init(name: String, price: NSNumber, amount: Int) {
        self.name = name
        self.price = price
        self.amount = amount
    }
    
}
