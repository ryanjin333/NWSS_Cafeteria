//
//  PaymentStatusIndicatorView.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-25.
//

import UIKit

class PaymentStatusIndicatorView: UIView {
    
    let statusIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.tintColor = .black
        activityIndicator.backgroundColor = .clear
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    private func setupView() {
        self.layer.cornerRadius = CartControllerVariables.paymentStatusIndicatorViewCornerRadius
        self.applyProminentBlurEffect()
        self.isHidden = true
    }
    
    private func setupConstraints() {
        self.addSubview(statusIndicator)
        statusIndicator.addConstraint(top: nil, left: nil, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 80, height: 80)
        statusIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        statusIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
