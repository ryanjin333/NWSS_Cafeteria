//
//  SettingsController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-07-31.
//

import UIKit

class SettingsController: UIViewController {
    
    let settingsTableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .backgroundWhite
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    let settingsNavigationBar: UINavigationBar = {
        let navBar = UINavigationBar()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navBar.standardAppearance = appearance
        return navBar
    }()
    
    let settingsNavigationTitle: UINavigationItem = {
        let navItem = UINavigationItem()
        navItem.title = "Settings"
        return navItem
    }()
    
    let doneButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "Done"
        barButton.action = #selector(doneButtonTapped)
        return barButton
    }()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            setUpSettingsController()
            setUpSettingsTableView()
            setUpSettingsBar()
        }
    
}
