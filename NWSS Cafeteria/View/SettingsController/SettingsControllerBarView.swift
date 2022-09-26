//
//  SettingsTableView.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-25.
//

import UIKit

class SettingsControllerBarView: UINavigationBar {
    
    let settingsNavigationTitle: UINavigationItem = {
        let navItem = UINavigationItem()
        navItem.title = SettingsControllerVariables.navigationTitle
        return navItem
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBar()
        setupNavBar()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    private func setupNavBar() {
        self.setItems([settingsNavigationTitle], animated: false)
    }
    
    private func setupBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        self.standardAppearance = appearance
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
