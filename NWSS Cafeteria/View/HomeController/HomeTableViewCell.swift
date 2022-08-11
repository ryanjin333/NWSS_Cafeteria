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
    
    let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    func set(indexPath: IndexPath) {
        
        //Home Table View Cell Initialization
        self.contentView.addSubview(homeTitleLabel)
        self.contentView.addSubview(itemImageView)
        
        
        //Home Table View Cell Label Text
        let list = HomeTitleTableList()
        homeTitleLabel.text = list.cellLabels[indexPath.row]
        itemImageView.image = UIImage(named: "cake")
        
        //Home Table View Cell Constraints
        homeTitleLabel.addConstraint(top: self.contentView.topAnchor, left: itemImageView.rightAnchor, right: nil, bottom: nil, paddingTop: 25, paddingLeft: 20, paddingRight: 0, paddingBottom: 0, width: 175, height: 30)
        itemImageView.addConstraint(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, right: nil, bottom: nil, paddingTop: 5, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: 70, height: 70)
    }
    
}
