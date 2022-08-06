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
        label.font = UIFont.init(name: "Avenir-Medium", size: 15)
        return label
    }()
    
    func set(indexPath: IndexPath) {
        
        //Settings Table View Cell Initialization
        self.contentView.addSubview(settingsTitleLabel)
        
        //Settings Table View Cell Label Text
        let list = SettingsTitleTableList()
        settingsTitleLabel.text = list.cellLabels[indexPath.section][indexPath.row]
        
        //Settings Table View Cell Constraints
        settingsTitleLabel.addConstraint(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, right: nil, bottom: nil, paddingTop: 11, paddingLeft: 20, paddingRight: 0, paddingBottom: 0, width: 175, height: 30)
    }
    
}
