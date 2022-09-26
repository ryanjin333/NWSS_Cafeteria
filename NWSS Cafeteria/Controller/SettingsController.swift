//
//  SettingsController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-07-31.
//

import UIKit

class SettingsController: UIViewController {
    
    //MARK: - View Variables
    let settingsTableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .backgroundWhite
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    let settingsNavigationBar = SettingsControllerBarView()
    
    //MARK: - Local Variables
    let fullList = SettingsTitleTableList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettingsController()
        setupConstraints()
        setupSettingsTableView()
    }
    
    //MARK: - Table View Initialization

    func setupSettingsTableView() {
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "settingsCell")
    }
    
    //MARK: - Constraints
    
    private func setupConstraints() {
        view.addSubview(settingsNavigationBar)
        view.addSubview(settingsTableView)
        settingsNavigationBar.addConstraint(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        settingsTableView.addConstraint(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
}
