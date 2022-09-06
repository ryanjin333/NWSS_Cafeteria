//
//  CartController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-24.
//

import UIKit
import Stripe
import PassKit

class CartController: UIViewController {
    
    //MARK: - Local Closure Variables
    
    let cartNavigationBar: UINavigationBar = {
        let navBar = UINavigationBar()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navBar.standardAppearance = appearance
        navBar.tintColor = .lightGray
        return navBar
    }()
    
    let cartNavigationTitle: UINavigationItem = {
        let navItem = UINavigationItem()
        return navItem
    }()
    
    let createCustomerButton: UIButton = {
        let button = UIButton()
        let buttonTitle = "Create Customer"
        button.setTitle(buttonTitle, for: .normal)
        button.backgroundColor = .black
        button.layer.applyShadow(color: .black, alpha: 0.5, x: 0, y: 3, blur: 8, spread: 0)
        button.layer.cornerRadius = 10
        return button
    }()
    
    let payButton: UIButton = {
        let button = UIButton()
        let buttonTitle = "Pay Now"
        button.setTitle(buttonTitle, for: .normal)
        button.backgroundColor = .black
        button.layer.applyShadow(color: .black, alpha: 0.5, x: 0, y: 3, blur: 8, spread: 0)
        button.layer.cornerRadius = 10
        return button
    }()
    
    var receiptView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundWhite
        view.layer.applyShadow(color: .black, alpha: 0.1, x: 0, y: 4, blur: 11, spread: 0)
        view.layer.cornerRadius = 11
        return view
    }()
    
    var receiptTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundWhite
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 11
        return tableView
    }()
    
    let yourOrderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "AvenirNext-DemiBold", size: 22)
        label.text = "Your order"
        return label
    }()
    
    let subtotalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "AvenirNext-Medium", size: CartControllerVariables.subtotalAndTotalTextSize)
        label.text = "Subtotal"
        label.textColor = .lightGray
        return label
    }()
    
    let subtotalAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "AvenirNext-Medium", size: CartControllerVariables.subtotalAndTotalTextSize)
        label.textColor = .lightGray
        return label
    }()
    
    let taxLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "AvenirNext-Medium", size: CartControllerVariables.subtotalAndTotalTextSize)
        label.text = "Tax"
        label.textColor = .lightGray
        return label
    }()
    
    let taxAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "AvenirNext-Medium", size: CartControllerVariables.subtotalAndTotalTextSize)
        label.textColor = .lightGray
        return label
    }()
    
    let subtotalAndTotalSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 0.5
        return view
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "AvenirNext-Medium", size: CartControllerVariables.subtotalAndTotalTextSize)
        label.text = "Total"
        return label
    }()
    
    let totalAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "AvenirNext-Medium", size: CartControllerVariables.subtotalAndTotalTextSize)
        return label
    }()
    
    let zeroItemMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "AvenirNext-DemiBold", size: 16)
        label.text = CartControllerVariables.zeroItemMessage
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var scrollDownLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "AvenirNext-Medium", size: 12)
        label.text = CartControllerVariables.scrollDownMessage
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Local Variables
    var totalOfOrder: Double = 0
    var customerContext: STPCustomerContext?
    var paymentContext: STPPaymentContext?
    var isPayButtonTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCartController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getTotalOfOrder()
        setUpCartBar()
        setUpYourOrderLabel()
        setUpRecieptTableView()
        setUpSubtotalAndTotalView()
        setUpPayButton()
    }
}
