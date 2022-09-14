//
//  SettingsTableViewCell.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-07-31.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    let settingsTitleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.init(name: "AvenirNext-DemiBold", size: 15)
        return label
    }()
    
    func set(indexPath: IndexPath) {
        
        //Variables
        let titleLabelTopConstraint = SettingsControllerVariables.cellHeight / 2 - SettingsControllerVariables.titleLabelHeight / 2
        
        //Settings Table View Cell Initialization
        self.contentView.addSubview(settingsTitleLabel)
        
        //Settings Table View Cell Label Text
        let list = SettingsTitleTableList()
        settingsTitleLabel.text = list.cellLabels[indexPath.section][indexPath.row]
        
        //Settings Table View Cell Constraints
        settingsTitleLabel.addConstraint(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, right: nil, bottom: nil, paddingTop: titleLabelTopConstraint, paddingLeft: 20, paddingRight: 0, paddingBottom: 0, width: 175, height: SettingsControllerVariables.titleLabelHeight)
    }
    
}
