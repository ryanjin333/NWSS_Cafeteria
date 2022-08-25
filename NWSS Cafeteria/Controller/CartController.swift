//
//  CartController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-24.
//

import UIKit

class CartController: UIViewController {
    
    let cartNavigationBar: UINavigationBar = {
        let navBar = UINavigationBar()
        navBar.tintColor = .lightGray
        return navBar
    }()
    
    let cartNavigationTitle: UINavigationItem = {
        let navItem = UINavigationItem()
        navItem.title = CartControllerVariables.navigationTitle
        return navItem
    }()
    
    let doneButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "Back"
        barButton.action = #selector(doneButtonTapped)
        barButton.tintColor = .link
        return barButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCartController()
        setUpCartBar()
    }
}
