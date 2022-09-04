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
    let titleButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.init(name: "AvenirNext-DemiBold", size: HomeControllerVariables.titleButtonSize)
        button.setTitleColor(UIColor.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        return button
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
    
    let expandMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "AvenirNext-Medium", size: 12)
        label.text = HomeControllerVariables.expandMessage
        label.textAlignment = .center
        return label
    }()
    
    let expandedTitleView: UIView = {
        let view = UIView()
        view.applyBlurEffect()
        view.layer.cornerRadius = 9
        view.isHidden = true
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
        self.contentView.addSubview(titleButton)
        self.contentView.addSubview(itemImageView)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(cellStepper)
        self.contentView.addSubview(expandMessageLabel)
        self.contentView.addSubview(expandedTitleView)
        self.contentView.addSubview(seperatorLine)
        
        //Set Cell Properties With Firebase
        let storageRef = Storage.storage().reference(forURL: food.cellPictures?[indexPath.row] ?? HomeControllerVariables.nilImage)
        self.itemImageView.sd_setImage(with: storageRef)
        self.titleButton.setTitle(food.cellLabels[indexPath.row], for: .normal)
        self.priceLabel.text = "$\(String(format: "%.2f", Double(truncating: food.cellPrice[indexPath.row])))"
        
        //Stepper Setup
        cellStepper.tag = indexPath.row
        cellStepper.addTarget(self, action: #selector(cellStepperTapped), for: .valueChanged)
        
        //Title Button Setup
        titleButton.addTarget(self, action: #selector(titleButtonTapped), for: .touchUpInside)
        
        //Expanded Message Setup
        var currentSize = HomeControllerVariables.titleButtonSize
        while titleButton.isTruncated == true {
            //expandMessageLabel.isHidden = true
            currentSize -= 1
            titleButton.titleLabel?.font = UIFont.init(name: "AvenirNext-DemiBold", size: currentSize)
        }
        
        //Seperator Line Setup
        if indexPath.row == food.cellLabels.count - 1 {
            seperatorLine.backgroundColor = .clear
        }

        
        //Home Table View Cell Constraints
        titleButton.addConstraint(top: self.contentView.topAnchor, left: itemImageView.rightAnchor, right: nil, bottom: nil, paddingTop: HomeControllerVariables.titleButtonTopConstraint, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: HomeControllerVariables.titleButtonWidth, height: HomeControllerVariables.titleButtonHeight)
        itemImageView.addConstraint(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, right: nil, bottom: nil, paddingTop: itemImageTopConstraint, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: HomeControllerVariables.itemImageLength, height: HomeControllerVariables.itemImageLength)
        priceLabel.addConstraint(top: titleButton.bottomAnchor, left: itemImageView.rightAnchor, right: nil, bottom: nil, paddingTop: 3, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: 75, height: 0)
        cellStepper.addConstraint(top: self.contentView.topAnchor, left: nil, right: self.contentView.rightAnchor, bottom: nil, paddingTop: HomeControllerVariables.cellStepperTopPadding, paddingLeft: 0, paddingRight: 10, paddingBottom: 0, width: HomeControllerVariables.cellSteppterWidth, height: HomeControllerVariables.cellStepperHeight)
//        expandMessageLabel.addConstraint(top: nil, left: nil, right: nil, bottom: seperatorLine.topAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 15, width: 0, height: 0)
//        expandMessageLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
//        expandedTitleView.addConstraint(top: self.contentView.topAnchor, left: itemImageView.rightAnchor, right: nil, bottom: nil, paddingTop: HomeControllerVariables.titleButtonTopConstraint, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: HomeControllerVariables.titleButtonWidth, height: HomeControllerVariables.titleButtonHeight * 2)
        seperatorLine.addConstraint(top: nil, left: self.contentView.leftAnchor, right: self.contentView.rightAnchor, bottom: self.contentView.bottomAnchor, paddingTop: 0, paddingLeft: HomeControllerVariables.itemImageLength + 20, paddingRight: 20, paddingBottom: 0, width: 0, height: 1)
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
    
    @objc func titleButtonTapped(sender: UIButton!) {
        if sender.isTruncated == true {
            //expandMessageLabel.isHidden = true
        }
        
    }
}
