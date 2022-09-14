//
//  OrderNumberController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-06.
//

import UIKit

class PaymentSuccessController: UIViewController {
    
    let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "checkmark")
        return imageView
    }()
    
    let paymentConfirmedLabel: UILabel = {
        let label = UILabel()
        label.text = "Payment Confirmed"
        label.font = UIFont.init(name: "AvenirNext-DemiBold", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    
    let clientNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "Please listen for your name"
        label.font = UIFont.init(name: "AvenirNext-DemiBold", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    
    let restartButton: UIButton = {
        let button = UIButton()
        let buttonTitle = "Return to Menu"
        button.setTitle(buttonTitle, for: .normal)
        button.backgroundColor = .black
        button.layer.applyShadow(color: .black, alpha: 0.5, x: 0, y: 3, blur: 8, spread: 0)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPaymentSuccessController()
        setUpClientView()
        setUpRestartButton()
    }
}
