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
        label.font = UIFont.init(name: "AvenirNext-DemiBold", size: HomeControllerVariables.titleLabelSize)
        label.textColor = .black
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkerGrey
        label.font = UIFont.init(name: "AvenirNext-DemiBold", size: 12)
        return label
    }()
    
    let seperatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .specialGrey
        view.layer.cornerRadius = 0.5
        return view
    }()
    
    let cellStepper: GMStepper = {
        let stepper = GMStepper()
        stepper.cornerRadius = 7
        stepper.labelWidthWeight = 0.3
        stepper.labelFont = UIFont(name: "AvenirNext-DemiBold", size: 16)!
        stepper.labelTextColor = .black
        stepper.labelBackgroundColor = .transparent
        stepper.buttonsFont = UIFont(name: "AvenirNext-DemiBold", size: 15)!
        stepper.buttonsTextColor = .black
        stepper.buttonsBackgroundColor = .transparent
        stepper.limitHitAnimationColor = .transparent
        return stepper
    }()
    
    //MARK: - Local Variables
    var food: Food = Food()
    var amountOfRows = 0
    
    //MARK: - Local Properties
    
    func getFood(food: Food) {
        self.food = food
    }
    
    func getNumberOfRows(amount: Int) {
        self.amountOfRows = amount
    }
     
    func set(indexPath: IndexPath) {
        
        //Variables
        let itemImageTopConstraint = (HomeControllerVariables.cellHeight / 2) - (HomeControllerVariables.itemImageLength / 2)
        
        //Home Table View Cell Initialization
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(itemImageView)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(cellStepper)
        self.contentView.addSubview(seperatorLine)
        
        //Set Cell Properties With Firebase
        let storageRef = Storage.storage().reference(forURL: food.cellPictures?[indexPath.row] ?? HomeControllerVariables.nilImage)
        self.itemImageView.sd_setImage(with: storageRef)
        self.titleLabel.text = food.cellLabels[indexPath.row]
        self.priceLabel.text = "$\(String(format: "%.2f", Double(truncating: food.cellPrice[indexPath.row])))"
        
        //Stepper Setup
        cellStepper.value = 0
        cellStepper.tag = indexPath.row
        cellStepper.addTarget(self, action: #selector(cellStepperTapped), for: .valueChanged)
        
        //Title Label Setup
        var currentSize = HomeControllerVariables.titleLabelSize
        while titleLabel.isTruncated == true {
            currentSize -= 0.5
            titleLabel.font = UIFont.init(name: "AvenirNext-DemiBold", size: currentSize)
        }
        
        //Seperator Line Setup
//        if indexPath.row == food.cellLabels.count - 1 {
//            seperatorLine.backgroundColor = .clear
//        }

        
        //Home Table View Cell Constraints
        titleLabel.addConstraint(top: self.contentView.topAnchor, left: itemImageView.rightAnchor, right: nil, bottom: nil, paddingTop: HomeControllerVariables.titleLabelTopConstraint, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: HomeControllerVariables.titleLabelWidth, height: HomeControllerVariables.titleLabelHeight)
        itemImageView.addConstraint(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, right: nil, bottom: nil, paddingTop: itemImageTopConstraint, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: HomeControllerVariables.itemImageLength, height: HomeControllerVariables.itemImageLength)
        priceLabel.addConstraint(top: titleLabel.bottomAnchor, left: itemImageView.rightAnchor, right: nil, bottom: nil, paddingTop: 3, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: 75, height: 0)
        cellStepper.addConstraint(top: self.contentView.topAnchor, left: nil, right: self.contentView.rightAnchor, bottom: nil, paddingTop: HomeControllerVariables.cellStepperTopPadding, paddingLeft: 0, paddingRight: 10, paddingBottom: 0, width: HomeControllerVariables.cellSteppterWidth, height: HomeControllerVariables.cellStepperHeight)
        seperatorLine.addConstraint(top: nil, left: self.contentView.leftAnchor, right: self.contentView.rightAnchor, bottom: self.contentView.bottomAnchor, paddingTop: 0, paddingLeft: HomeControllerVariables.itemImageLength + 20, paddingRight: 20, paddingBottom: 2, width: 0, height: 1)
    }
    
    //MARK: - Button Actions
    
    @objc func cellStepperTapped(sender: GMStepper) {
        let row = sender.tag
        let value = Int(sender.value)
        let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
        impactGenerator.impactOccurred()
        if value == 0 {
            HomeTableViewCell.receipt.removeValue(forKey: food.cellLabels[row])
        }
        else {
            HomeTableViewCell.receipt[food.cellLabels[row]] = Receipt(price: food.cellPrice[row], image: food.cellPictures![row], amount: value)
        }
    }
}
