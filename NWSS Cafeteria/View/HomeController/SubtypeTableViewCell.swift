//
//  subtypeTableViewCell.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-16.
//

import UIKit


class SubtypeTableViewCell: HomeTableViewCell {
    let priceLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.init(name: "Avenir-Medium", size: 10)
        return label
    }()
    
    override func set(indexPath: IndexPath) {
        //Subtype Table View Cell Initialization
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(itemImageView)
        self.contentView.addSubview(priceLabel)
        
        //Subtype Table View Cell Label Attributes
        self.titleLabel.text = "Coke"
        itemImageView.image = UIImage(named: "cake")
        self.priceLabel.text = "$8"
        
        //Subtype Table View Cell Constraints
        titleLabel.addConstraint(top: self.contentView.topAnchor, left: itemImageView.rightAnchor, right: nil, bottom: nil, paddingTop: 25, paddingLeft: 20, paddingRight: 0, paddingBottom: 0, width: 175, height: 30)
        itemImageView.addConstraint(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, right: nil, bottom: nil, paddingTop: 5, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: 70, height: 70)
        priceLabel.addConstraint(top: titleLabel.bottomAnchor, left: itemImageView.rightAnchor, right: nil, bottom: nil, paddingTop: 5, paddingLeft: 20, paddingRight: 0, paddingBottom: 0, width: 25, height: 15)
        
    }
    
    
    
    
}
