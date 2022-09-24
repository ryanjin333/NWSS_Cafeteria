//
//  CartController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-24.
//

import UIKit
import Stripe
import PassKit
import FirebaseAuth

class CartController: UIViewController {
    
    //MARK: - Local Closure Variables
    
    let cartNavigationBar = CartNavigationBarView()
    
    let userInfoButton = UserInfoButton()
    
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
    
    let paymentStatusIndicatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = CartControllerVariables.paymentStatusIndicatorViewCornerRadius
        view.applyProminentBlurEffect()
        view.isHidden = true
        return view
    }()
    
    let paymentStatusIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.tintColor = .black
        activityIndicator.backgroundColor = .clear
        return activityIndicator
    }()
    
    var scrollDownLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "AvenirNext-Medium", size: 12)
        label.text = CartControllerVariables.scrollDownMessage
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Local Variables
    var totalOfOrder = Double()
    var customerContext: STPCustomerContext?
    var paymentContext: STPPaymentContext?
    var isPayButtonTapped = Bool()
    var paymentDescription = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCartController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getTotalOfOrder()
        getPaymentDescription()
        setupCartBar()
        setupUserInfoButton()
        setUpYourOrderLabel()
        setUpRecieptTableView()
        setUpSubtotalAndTotalView()
        setUpPayButton()
        setUpPaymentStatusIndicatorView()
    }
    
    //MARK: - Cart Bar Initialization
    
    func setupCartBar() {
        
        //Variables
        var totalNumberOfItems = 0
        HomeTableViewCell.receipt.values.forEach {
            totalNumberOfItems += $0.amount
        }
        let navbarTitle = "Cart (\(totalNumberOfItems))"
        
        //Navigation Bar Attributes
        cartNavigationBar.setInfo(navbarTitle: navbarTitle)
        
        //Constraints
        view.addSubview(cartNavigationBar)
        cartNavigationBar.addConstraint(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
    //MARK: - Login Button Initialization
    func setupUserInfoButton() {
        
        //Variables
        let userInfoLabelText = "User"
        let userInfoImageName = "userInfoIcon"
        
        //Create Customer Button Configurations
        userInfoButton.tappableButton.addTarget(self, action: #selector(userInfoButtonTapped), for: .touchUpInside)
        
        //Button Attributes
        userInfoButton.userInfoImageView.image = UIImage(named: userInfoImageName)
        userInfoButton.userInfoLabel.text = userInfoLabelText
            
        //Constraints
        view.addSubview(userInfoButton)
        userInfoButton.addConstraint(top: cartNavigationBar.bottomAnchor, left: nil, right: view.rightAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 20, paddingBottom: 0, width: 85, height: CartControllerVariables.userInfoButtonHeight)
            
    }
    
    @objc func userInfoButtonTapped(sender: UIButton!) {
        let loginController = LoginController()
        let logoutController = LogoutController()
        
        guard FirebaseAuth.Auth.auth().currentUser != nil else {
            present(loginController, animated: true)
            return
        }
        present(logoutController, animated: true)
    }
}

