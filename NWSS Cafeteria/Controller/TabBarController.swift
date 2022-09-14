//
//  TabBarController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-26.
//

import UIKit

class TabBarController: UITabBarController {
    
    static var tabBarController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
}
