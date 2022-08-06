//
//  HomeTableViewCell.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-05.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    let homeTitleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.init(name: "Avenir-Medium", size: 15)
        return label
    }()
    
    let foodImage: UIImage = {
        let image = UIImage()
        return image
    }()
    
    func set(indexPath: IndexPath) {
        
        //Home Table View Cell Initialization
        self.contentView.addSubview(homeTitleLabel)
        //Add image initialization
        
        
        //Home Table View Cell Label Text
        let list = HomeTitleTableList()
        homeTitleLabel.text = list.cellLabels[indexPath.row]
        //Add images to foodImage
        
        //Home Table View Cell Constraints
        homeTitleLabel.addConstraint(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, right: nil, bottom: nil, paddingTop: 25, paddingLeft: 20, paddingRight: 0, paddingBottom: 0, width: 175, height: 30)
        //Add image constraints
    }
    
}
