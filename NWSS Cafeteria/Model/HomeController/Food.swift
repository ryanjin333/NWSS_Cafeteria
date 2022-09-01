//
//  Food.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-20.
//

import Foundation

struct Food {
    var sectionLabel: String
    var cellLabels: [String]
    var cellPictures: [String]?
    var cellPrice: [NSNumber]
    
    init(sectionLabel: String = "", cellLabels: [String] = [], cellPictures: [String] = [], cellPrice: [NSNumber] = []) {
        self.sectionLabel = sectionLabel
        self.cellLabels = cellLabels
        self.cellPictures = cellPictures
        self.cellPrice = cellPrice
    }
}
