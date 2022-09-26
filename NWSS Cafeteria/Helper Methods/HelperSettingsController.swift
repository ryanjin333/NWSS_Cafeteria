//
//  HelperSettingsController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-07-31.
//

import UIKit

extension SettingsController {
    
    func setupSettingsController() {        
        view.backgroundColor = .backgroundWhite
    }
}

//MARK: - Settings Table View Data Source
extension SettingsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fullList.cellLabels[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fullList.cellTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return fullList.cellTitles[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! SettingsTableViewCell
        cell.set(indexPath: indexPath)
        return cell;
    }
}

//MARK: - Settings Table View Delegate
extension SettingsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SettingsControllerVariables.cellHeight
    }
}
