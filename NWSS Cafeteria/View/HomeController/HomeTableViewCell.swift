//
//  HomeTableViewCell.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-05.
//

import UIKit
import FirebaseStorageUI


class HomeTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.init(name: "Avenir-Medium", size: 15)
        return label
    }()
    
    let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "Avenir-Medium", size: 12)
        return label
    }()
     
    func set(indexPath: IndexPath, with event: Food) {
        
        //Home Table View Cell Initialization
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(itemImageView)
        self.contentView.addSubview(priceLabel)
        //Set Cell Properties With Firebase
//        let storageRef = Storage.storage().reference(forURL: HomeTitleTableList.cellPictures[indexPath.section][indexPath.row][HomeControllerVariables.pictureIndex])
//        self.itemImageView.sd_setImage(with: storageRef)
//        self.titleLabel.text = HomeTitleTableList.cellLabels[indexPath.section][indexPath.row]
//        self.priceLabel.text = "$\(String(format: "%.2f", Double(truncating: HomeTitleTableList.cellPrice[indexPath.section][indexPath.row][HomeControllerVariables.priceIndex])))"
        let storageRef = Storage.storage().reference(forURL: event.cellPictures[indexPath.row][HomeControllerVariables.pictureIndex])
                self.itemImageView.sd_setImage(with: storageRef)
                self.titleLabel.text = event.cellLabels[indexPath.row]
        self.priceLabel.text = "$\(String(format: "%.2f", Double(truncating: event.cellPrice[indexPath.row][HomeControllerVariables.priceIndex])))"
        
        //Home Table View Cell Constraints
        titleLabel.addConstraint(top: self.contentView.topAnchor, left: itemImageView.rightAnchor, right: nil, bottom: nil, paddingTop: 15, paddingLeft: 20, paddingRight: 0, paddingBottom: 0, width: 175, height: 30)
        itemImageView.addConstraint(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, right: nil, bottom: nil, paddingTop: 5, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: 70, height: 70)
        priceLabel.addConstraint(top: titleLabel.bottomAnchor, left: itemImageView.rightAnchor, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 20, paddingRight: 0, paddingBottom: 0, width: 35, height: 15)
    }
    
}
