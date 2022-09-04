//
//  ReceiptTableViewCell.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-29.
//

import UIKit
import FirebaseStorageUI

class ReceiptTableViewCell: UITableViewCell {
    
    //MARK: - Local Closure Variables
    let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.init(name: "AvenirNext-DemiBold", size: CartControllerVariables.titleLabelSize)
        label.numberOfLines = 0
        return label
    }()
    
    let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "AvenirNext-DemiBold", size: 15)
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "AvenirNext-Medium", size: 13)
        label.textColor = .lightGray
        return label
    }()
    
    
    
    //MARK: - Local Variable
    var foodNames: [String] = []
    
    func getFoodNames() {
        HomeTableViewCell.receipt.keys.forEach {
            foodNames.append($0)
        }
    }
    
    func set(indexPath: IndexPath) {
        
        //Variables
        let priceLabelTopConstraint = (HomeControllerVariables.cellHeight / 2) - (CartControllerVariables.priceLabelHeight / 2) 
        let itemImageTopConstraint = (HomeControllerVariables.cellHeight / 2) - (CartControllerVariables.itemImageLength / 2) 
        let itemTotal = Double(truncating: HomeTableViewCell.receipt[foodNames[indexPath.row]]!.price) * Double(HomeTableViewCell.receipt[foodNames[indexPath.row]]!.amount)
        
        //Cell Attributes
        let storageRef = Storage.storage().reference(forURL: HomeTableViewCell.receipt[foodNames[indexPath.row]]!.image)
        self.itemImageView.sd_setImage(with: storageRef)
        titleLabel.text = foodNames[indexPath.row]
        priceLabel.text = "$\(String(format: "%.2f", itemTotal))"
        amountLabel.text = "x \(HomeTableViewCell.receipt[foodNames[indexPath.row]]!.amount)"
        
        //Constraints
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(itemImageView)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(amountLabel)
        itemImageView.addConstraint(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, right: nil, bottom: nil, paddingTop: itemImageTopConstraint, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: CartControllerVariables.itemImageLength, height: CartControllerVariables.itemImageLength)
        titleLabel.addConstraint(top: self.contentView.topAnchor, left: itemImageView.rightAnchor, right: nil, bottom: nil, paddingTop: 20, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        priceLabel.addConstraint(top: self.contentView.topAnchor, left: nil, right: self.contentView.rightAnchor, bottom: nil, paddingTop: priceLabelTopConstraint, paddingLeft: 0, paddingRight: 20, paddingBottom: 0, width: 0, height: CartControllerVariables.priceLabelHeight)
        amountLabel.addConstraint(top: titleLabel.bottomAnchor, left: itemImageView.rightAnchor, right: nil, bottom: nil, paddingTop: 2, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
}
