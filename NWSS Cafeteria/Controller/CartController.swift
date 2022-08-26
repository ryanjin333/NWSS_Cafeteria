//
//  CartController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-24.
//

import UIKit
import PassKit

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
    
    let payButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pay Now", for: .normal)
        button.backgroundColor = .lightBlue
        return button
    }()
    
    var paymentRequest: PKPaymentRequest = {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.com.huij.NWSS-Cafeteria"
        request.supportedNetworks = [.interac, .visa, .masterCard, .discover, .amex]
        request.supportedCountries = ["CA"]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "CA"
        request.currencyCode = "CAD"
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Foo", amount: 0.10)]
        return request
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCartController()
        setUpCartBar()
        setUpPayButton()
    }
}
