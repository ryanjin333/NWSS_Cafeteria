//
//  HomeControllerVariables.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-06.
//

import UIKit

struct HomeControllerVariables {
    
    //Variables for HomeController
    static let navigationTitle = "Order"
    
    //Variables for HomeControllerOrder
    static let barHeight: CGFloat = 95
    
    //Variables for HomeTableView
    static let cellHeight: CGFloat = 80
    static let menuName: String = "Full Menu"
    static let titleLabelSize: CGFloat = 16
    
    //Variables for HomeTableViewCell
    static let pictureIndex = 0
    static let priceIndex = 1
    static let cellStepperHeight: CGFloat = 50
    static let itemImageLength: CGFloat = 55
    static let cellSteppterWidth: CGFloat = 120
    static let titleLabelHeight: CGFloat = 22
    static let titleLabelTopConstraint: CGFloat = 18
    static let cellStepperTopPadding: CGFloat = cellHeight / 2 - cellStepperHeight / 2 
    static let titleLabelWidth = UIScreen.main.bounds.width - itemImageLength - cellSteppterWidth - 20
    static let expandMessage = "Tap title to expand"
    
    //Variables for Cart Button
    static let cartButtonLength: CGFloat = 70
    
    //Optional Variables for HomeTableViewCell
    static let nilImage = "gs://nwss-cafeteria.appspot.com/Miscellaneous/nilImage.png"
}
