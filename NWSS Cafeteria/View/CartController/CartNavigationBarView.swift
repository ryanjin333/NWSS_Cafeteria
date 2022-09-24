//
//  CartControllerBarView.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-24.
//

import UIKit

class CartNavigationBarView: UINavigationBar {
    
    let cartNavigationTitle = UINavigationItem()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addItemsToNavigationBar()
        setupView()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    func setInfo(navbarTitle: String) {
        cartNavigationTitle.title = navbarTitle
    }
    
    private func setupView() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        self.standardAppearance = appearance
    }
    
    private func addItemsToNavigationBar() {
        self.setItems([cartNavigationTitle], animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
