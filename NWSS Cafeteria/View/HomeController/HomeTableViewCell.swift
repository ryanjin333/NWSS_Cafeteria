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
    
    //MARK: - Global Variables
    static var receipt = [String: Receipt]()
    
    //MARK: - Local Closure Variables
    let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.init(name: "AvenirNext-Bold", size: HomeControllerVariables.titleLabelSize)
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
    
    //MARK: - Local Variables
    var food: Food = Food()
    
    //MARK: - Local Properties
    
    func getFood(food: Food) {
        self.food = food
    }
     
    func set(indexPath: IndexPath) {
        
        //Home Table View Cell Initialization
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(itemImageView)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(cellStepper)
        
        //Set Cell Properties With Firebase
        let storageRef = Storage.storage().reference(forURL: food.cellPictures[indexPath.row])
        self.itemImageView.sd_setImage(with: storageRef)
        self.titleLabel.text = food.cellLabels[indexPath.row]
        self.priceLabel.text = "$\(String(format: "%.2f", Double(truncating: food.cellPrice[indexPath.row])))"
        
        //Stepper Setup
        cellStepper.tag = indexPath.row
        cellStepper.addTarget(self, action: #selector(cellStepperTapped), for: .valueChanged)
        //Home Table View Cell Constraints
        titleLabel.addConstraint(top: self.contentView.topAnchor, left: itemImageView.rightAnchor, right: cellStepper.leftAnchor, bottom: nil, paddingTop: 15, paddingLeft: 20, paddingRight: 10, paddingBottom: 0, width: 0, height: 0)
        itemImageView.addConstraint(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, right: nil, bottom: nil, paddingTop: 5, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: 70, height: 70)
        priceLabel.addConstraint(top: titleLabel.bottomAnchor, left: itemImageView.rightAnchor, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 20, paddingRight: 0, paddingBottom: 0, width: 75, height: 0)
        cellStepper.addConstraint(top: self.contentView.topAnchor, left: nil, right: self.contentView.rightAnchor, bottom: nil, paddingTop: HomeControllerVariables.cellStepperTopPadding, paddingLeft: 0, paddingRight: 30, paddingBottom: 0, width: 100, height: HomeControllerVariables.cellStepperHeight)
    }
    
    @objc func cellStepperTapped(sender: GMStepper) {
        let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
        impactGenerator.impactOccurred()
        let row = sender.tag
        let value = Int(sender.value)
        if value == 0 {
            HomeTableViewCell.receipt.removeValue(forKey: food.cellLabels[row])
        }
        else {
            HomeTableViewCell.receipt[food.cellLabels[row]] = Receipt(name: food.cellLabels[row], price: food.cellPrice[row], amount: value)
            print("Name: \(HomeTableViewCell.receipt[food.cellLabels[row]]!.name), Price: \(HomeTableViewCell.receipt[food.cellLabels[row]]!.price), Value: \(HomeTableViewCell.receipt[food.cellLabels[row]]!.amount)")
        }
        print("------------------------------------")
        print("Receipt: \(HomeTableViewCell.receipt)")
    }
}
