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
    
    let payButton = PayButton(buttonTitle: CartControllerVariables.payButtonTitle)
    
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
    
    let subtotalLabel = SummaryLabelView()
    
    let taxLabel = SummaryLabelView()
    
    let subtotalAndTotalSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 0.5
        return view
    }()
    
    let totalLabel = SummaryLabelView()
    
    let zeroItemMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "AvenirNext-DemiBold", size: 16)
        label.text = CartControllerVariables.zeroItemMessage
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let paymentStatusIndicator = PaymentStatusIndicatorView()
    
    let loginMessageLabel: ErrorMessageLabel = {
        let label = ErrorMessageLabel(errorMessage: CartControllerVariables.loginFirstMessage)
        label.isHidden = false
        label.alpha = 0
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
    var totalOfOrder = Double()
    var customerContext: STPCustomerContext?
    var paymentContext: STPPaymentContext?
    var isPayButtonTapped = Bool()
    var paymentDescription = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCartController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupConstraints()
        getTotalOfOrder()
        getPaymentDescription()
        setupCartBar()
        setupUserInfoButton()
        setupSummaryViews()
        setupPayButton()
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
    
    }
    
    //MARK: - User Info Initialization
    func setupUserInfoButton() {
        
        //Variables
        let userInfoLabelText = "User"
        let userInfoImageName = "userInfoIcon"
        
        //Create Customer Button Configurations
        userInfoButton.tappableButton.addTarget(self, action: #selector(userInfoButtonTapped), for: .touchUpInside)
        
        //Button Attributes
        userInfoButton.userInfoImageView.image = UIImage(named: userInfoImageName)
        userInfoButton.userInfoLabel.text = userInfoLabelText
            
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
    
    //MARK: - Summary View Initialization
    func setupSummaryViews() {
        subtotalLabel.setInfo(labelText: "Subtotal", amount: "$\(String(format: "%.2f", totalOfOrder))", color: .lightGray)
        taxLabel.setInfo(labelText: "Tax", amount: "N/A", color: .lightGray)
        totalLabel.setInfo(labelText: "Total", amount: "$\(String(format: "%.2f", totalOfOrder))", color: .black)
    }
    
    
    //MARK: - Pay Button Initialization
    
    func setupPayButton() {
        
        //Pay Button Configurations
        payButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        if totalOfOrder == 0 {
            payButton.isEnabled = false
            payButton.backgroundColor = .lightGray
            loginMessageLabel.isHidden = false
        }
        else {
            payButton.isEnabled = true
            payButton.backgroundColor = .black
        }
        if FirebaseAuth.Auth.auth().currentUser != nil {
            let config = STPPaymentConfiguration.shared
            config.requiredShippingAddressFields = nil
            config.companyName = "NWSS Cafeteria"
            customerContext = STPCustomerContext(keyProvider: APIClient())
            paymentContext =  STPPaymentContext(customerContext: customerContext!, configuration: config, theme: .defaultTheme)
            self.paymentContext?.delegate = self
            self.paymentContext?.hostViewController = self
            self.paymentContext?.paymentAmount = Int(String(format: "%.2f", totalOfOrder).replacingOccurrences(of: ".", with: ""))!
        }
    }
    
    @objc func payButtonTapped(sender: UIButton!) {
        guard FirebaseAuth.Auth.auth().currentUser != nil else {
            UIView.animate(withDuration: 0.2) {
                self.loginMessageLabel.alpha = 1
            }
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                UIView.animate(withDuration: 0.2) {
                    self.loginMessageLabel.alpha = 0
                }
            }
            return
        }
        DispatchQueue.main.async {
            self.isPayButtonTapped = true
            self.paymentContext?.presentPaymentOptionsViewController()
        }
    }
    
    //MARK: - Constraints
    private func setupConstraints() {
        
        view.addSubview(cartNavigationBar)
        view.addSubview(userInfoButton)
        view.addSubview(payButton)
        view.addSubview(yourOrderLabel)
        view.addSubview(loginMessageLabel)
        
        cartNavigationBar.addConstraint(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        userInfoButton.addConstraint(top: cartNavigationBar.bottomAnchor, left: nil, right: view.rightAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 20, paddingBottom: 0, width: 85, height: CartControllerVariables.userInfoButtonHeight)
        payButton.addConstraint(top: nil, left: view.leftAnchor, right: view.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 0, paddingLeft: 20, paddingRight: 20, paddingBottom: 50, width: 0, height: 50)
        yourOrderLabel.addConstraint(top: cartNavigationBar.bottomAnchor, left: view.leftAnchor, right: nil, bottom: nil, paddingTop: 10, paddingLeft: 20, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        loginMessageLabel.addConstraint(top: payButton.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        loginMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //MARK: Constraints for Table View
        
        //Remove all previous receiptViews and receiptTableViews
        receiptView.removeFromSuperview()
        receiptTableView.removeFromSuperview()
        
        //Create a new instance of receiptView and receiptTableView
        receiptView = {
            let view = UIView()
            view.backgroundColor = .backgroundWhite
            view.layer.applyShadow(color: .black, alpha: 0.1, x: 0, y: 4, blur: 11, spread: 0)
            view.layer.cornerRadius = 11
            return view
        }()
        receiptTableView = {
            let tableView = UITableView()
            tableView.backgroundColor = .backgroundWhite
            tableView.isScrollEnabled = false
            tableView.showsVerticalScrollIndicator = false
            tableView.separatorStyle = .none
            tableView.layer.cornerRadius = 11
            return tableView
        }()
        
        //receiptTableView General Configurations
        receiptTableView.dataSource = self
        receiptTableView.delegate = self
        receiptTableView.register(ReceiptTableViewCell.self, forCellReuseIdentifier: "receiptCell")
        if HomeTableViewCell.receipt.count > 3 {
            receiptTableView.isScrollEnabled = true
            scrollDownLabel.alpha = 1
        }
        else {
            scrollDownLabel.alpha = 0
        }
        
    
        //Variables
        var tableViewCellCount: CGFloat = 0
        if HomeTableViewCell.receipt.count == 1 {
            tableViewCellCount = 1
        }
        else if HomeTableViewCell.receipt.count == 2 {
            tableViewCellCount = 2
        }
        else {
            tableViewCellCount = 3
        }
        
        //Constraints
        view.addSubview(receiptView)
        receiptView.addSubview(receiptTableView)
        receiptView.addSubview(zeroItemMessageLabel)
        receiptView.addSubview(scrollDownLabel)
        receiptView.addConstraint(top: yourOrderLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 10, paddingLeft: 20, paddingRight: 20, paddingBottom: 0, width: 0, height: HomeControllerVariables.cellHeight * tableViewCellCount)
        receiptTableView.addConstraint(top: receiptView.topAnchor, left: receiptView.leftAnchor, right: receiptView.rightAnchor, bottom: receiptView.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        zeroItemMessageLabel.addConstraint(top: receiptView.topAnchor, left: receiptView.leftAnchor, right: receiptView.rightAnchor, bottom: receiptView.bottomAnchor, paddingTop: 0, paddingLeft: 30, paddingRight: 30, paddingBottom: 0, width: 0, height: 0)
        scrollDownLabel.addConstraint(top: nil, left: nil, right: nil, bottom: receiptView.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 5, width: 0, height: 0)
        scrollDownLabel.centerXAnchor.constraint(equalTo: receiptView.centerXAnchor).isActive = true
        
        //Summary Label Constraints
        view.addSubview(subtotalLabel)
        view.addSubview(taxLabel)
        view.addSubview(subtotalAndTotalSeperator)
        view.addSubview(totalLabel)
        subtotalLabel.addConstraint(top: receiptView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 20, paddingLeft: 20, paddingRight: 20, paddingBottom: 0, width: 0, height: 0)
        taxLabel.addConstraint(top: subtotalLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 15, paddingLeft: 20, paddingRight: 20, paddingBottom: 0, width: 0, height: 0)
        subtotalAndTotalSeperator.addConstraint(top: taxLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 15, paddingLeft: 20, paddingRight: 20, paddingBottom: 0, width: 0, height: 1)
        totalLabel.addConstraint(top: subtotalAndTotalSeperator.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 15, paddingLeft: 20, paddingRight: 20, paddingBottom: 0, width: 0, height: 0)
        
        //Zero Item Message Visibility
        if HomeTableViewCell.receipt.count == 0 {
            tableViewCellCount = 3
            receiptTableView.removeFromSuperview()
            zeroItemMessageLabel.isHidden = false
        }
        else {
            zeroItemMessageLabel.isHidden = true
        }
        
        //MARK: - Constraints for Payment Status Indicator
        view.addSubview(paymentStatusIndicator)
        paymentStatusIndicator.addConstraint(top: nil, left: nil, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 80, height: 80)
        paymentStatusIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        paymentStatusIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}


