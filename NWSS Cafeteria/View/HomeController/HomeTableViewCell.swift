//
//  HomeTableViewCell.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-05.
//

import UIKit
import FirebaseStorageUI
import GMStepper


class HomeTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.init(name: "AvenirNext-Bold", size: 16)
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
        label.font = UIFont.init(name: "AvenirNext-Medium", size: 12)
        return label
    }()
    
    let cellStepper: GMStepper = {
        let stepper = GMStepper()
        stepper.cornerRadius = 7
        stepper.labelWidthWeight = 0.4
        stepper.labelFont = UIFont(name: "AvenirNext-Medium", size: 16)!
        stepper.labelTextColor = .black
        stepper.labelBackgroundColor = .transparent
        stepper.buttonsFont = UIFont(name: "AvenirNext-Medium", size: 15)!
        stepper.buttonsTextColor = .black
        stepper.buttonsBackgroundColor = .transparent
        stepper.limitHitAnimationColor = .transparent
        return stepper
    }()
     
    func set(indexPath: IndexPath, with event: Food) {
        
        //Home Table View Cell Initialization
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(itemImageView)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(cellStepper)
        
        //Set Cell Properties With Firebase
        let storageRef = Storage.storage().reference(forURL: event.cellPictures[indexPath.row])
                self.itemImageView.sd_setImage(with: storageRef)
                self.titleLabel.text = event.cellLabels[indexPath.row]
        self.priceLabel.text = "$\(String(format: "%.2f", Double(truncating: event.cellPrice[indexPath.row])))"
        
        //Title Label Configurations
        //let topTitleLabelPadding: CGFloat = (HomeControllerVariables.cellHeight / 2) - ((titleLabel.layer.frame.height + priceLabel.layer.frame.height) / 2)
        //print((titleLabel.layer.frame.height + priceLabel.layer.frame.height) / 2)
        
        //Home Table View Cell Constraints
        titleLabel.addConstraint(top: self.contentView.topAnchor, left: itemImageView.rightAnchor, right: nil, bottom: nil, paddingTop: 20, paddingLeft: 20, paddingRight: 0, paddingBottom: 0, width: 140, height: 0)
        itemImageView.addConstraint(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, right: nil, bottom: nil, paddingTop: 5, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: 70, height: 70)
        priceLabel.addConstraint(top: titleLabel.bottomAnchor, left: itemImageView.rightAnchor, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 20, paddingRight: 0, paddingBottom: 0, width: 75, height: 0)
        cellStepper.addConstraint(top: self.contentView.topAnchor, left: nil, right: self.contentView.rightAnchor, bottom: nil, paddingTop: HomeControllerVariables.cellStepperTopPadding, paddingLeft: 0, paddingRight: 30, paddingBottom: 0, width: 100, height: HomeControllerVariables.cellStepperHeight)
    }
    
}
