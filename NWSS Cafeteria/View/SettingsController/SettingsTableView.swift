//
//  HomeScrollView.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-07-31.
//

import UIKit

extension SettingsController: UITableViewDelegate, UITableViewDataSource {
    
    private static let fullList = SettingsTitleTableList()
    
    //MARK: - Table View Initialization

    func setUpSettingsTableView() {
        
        //Table View Initialization
        view.addSubview(settingsTableView)
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "settingsCell")
        
        //Table View Constraints
        settingsTableView.addConstraint(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
    }
    
    //MARK: - Settings Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsController.fullList.cellLabels[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsController.fullList.cellTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingsController.fullList.cellTitles[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! SettingsTableViewCell
        cell.set(indexPath: indexPath)
        return cell;
    }
    
    //MARK: - Settings Table View Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
