//
//  OrderNavigationBarView.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-25.
//

import UIKit

class OrderNavigationBarView: UIView {
    
    let orderNavigationBar: UINavigationBar = {
        let navBar = UINavigationBar()
        navBar.backgroundColor = .transparent
        navBar.prefersLargeTitles = true
        navBar.largeTitleTextAttributes = [
            .font: UIFont(name: "AvenirNext-DemiBold", size: 29)!
        ]
        return navBar
    }()
    
    let orderNavigationTitle: UINavigationItem = {
        let navItem = UINavigationItem()
        navItem.title = HomeControllerVariables.navigationTitle
        return navItem
    }()
    
    let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "NWSSLogo")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
        setupNavBar()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    private func setupView() {
        self.backgroundColor = .backgroundWhite
        self.layer.applyShadow(color: .black, alpha: 0.25, x: 0, y: -6, blur: 17, spread: 0)
    }
    
    private func setupNavBar() {
        orderNavigationBar.setItems([orderNavigationTitle], animated: false)
    }
    
    private func setupConstraints() {
        self.addSubview(orderNavigationBar)
        self.addSubview(logo)
        orderNavigationBar.addConstraint(top: self.safeAreaLayoutGuide.topAnchor, left: self.leftAnchor, right: self.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: HomeControllerVariables.barHeight)
        logo.addConstraint(top: self.safeAreaLayoutGuide.topAnchor, left: nil, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 50, height: 50)
        logo.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
