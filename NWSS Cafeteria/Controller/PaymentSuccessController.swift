//
//  OrderNumberController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-06.
//

import UIKit

class PaymentSuccessController: UIViewController {
    
    //MARK: - View Variables
    let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "checkmark")
        return imageView
    }()
    
    let paymentConfirmedLabel: PaymentSuccessLabel = {
        let label = PaymentSuccessLabel()
        label.setInfo(text: "Payment Confirmed", textSize: 18, textColor: .black)
        return label
    }()
    
    let clientNameLabel: PaymentSuccessLabel = {
        let label = PaymentSuccessLabel()
        label.setInfo(text: "Please listen for your name", textSize: 14, textColor: .lightGray)
        return label
    }()
    
    let restartButton = RestartButton(buttonTitle: PaymentSuccessControllerVariables.restartButtonTitle)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPaymentSuccessController()
        setupConstraints()
        setupRestartButton()
    }
    
    //MARK: - Restart Button
    
    func setupRestartButton() {
        restartButton.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
    }
    
    @objc func restartButtonTapped(sender: UIButton!) {

        //Create new instance of Tab Bar Controller
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: false)
    }
    
    //MARK: - Constraints
    
    private func setupConstraints() {
        
        view.addSubview(checkmarkImageView)
        view.addSubview(paymentConfirmedLabel)
        view.addSubview(clientNameLabel)
        view.addSubview(restartButton)
        
        checkmarkImageView.addConstraint(top: nil, left: nil, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 100, height: 100)
        checkmarkImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        paymentConfirmedLabel.addConstraint(top: checkmarkImageView.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 20, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 21)
        paymentConfirmedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        paymentConfirmedLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        clientNameLabel.addConstraint(top: paymentConfirmedLabel.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 5, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 17)
        clientNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        restartButton.addConstraint(top: clientNameLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 130, paddingLeft: 50, paddingRight: 50, paddingBottom: 0, width: 0, height: 50)
    }
}
