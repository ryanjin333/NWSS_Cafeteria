//
//  ViewController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-07-23.
//


import UIKit
import FirebaseDatabase

class HomeController: UIViewController {
    
    //MARK: - View Variables
    
    let orderBarShadow = OrderNavigationBarView()
    
    let homeTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundWhite
        return tableView
    }()
    
    let tableViewTopConstraint: UIView = {
        let constraint = UIView()
        constraint.alpha = 0
        return constraint
    }()
    
    //MARK: - Local Variables
    let settingsController = SettingsController()
    let cartController = CartController()
    var foods: [Food] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHomeController()
        setupHomeTableView()
        homeTableViewDatabaseConfigurations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupConstraints()
    }
    
    //MARK: - Table View Initialization
    
    func setupHomeTableView() {
        
        //Table View Initialization
        self.homeTableView.backgroundColor = .backgroundWhite
        self.homeTableView.separatorStyle = .none
        homeTableView.dataSource = self
        homeTableView.delegate = self
        homeTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "homeCell")
        
        //Table View Constraints
        view.addSubview(homeTableView)
        view.addSubview(tableViewTopConstraint)
        tableViewTopConstraint.addConstraint(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: HomeControllerVariables.barHeight)
        homeTableView.addConstraint(top: tableViewTopConstraint.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
    func homeTableViewDatabaseConfigurations() {
        
        //Database Configurations
        let ref = Database.database().reference()
        ref.child(HomeControllerVariables.menuName).observe(.value) { snapshot in
            
            //MARK: Database: First Layer
            var i = 0
            for child in snapshot.children {
                guard let child = child as? DataSnapshot else { return }
                
                //Food Variables Created
                let sectionLabel: String
                var cellLabels: [String] = []
                var cellPictures: [String] = []
                var cellPrice: [NSNumber] = []
                
                //First Layer Configuration(s)
                sectionLabel = child.key
                
                //MARK: Database: Second Layer
                var j = 0
                for child in child.children {
                    guard let child = child as? DataSnapshot else { return }
                    
                    //Second Layer Configuration(s)
                    cellLabels.insert(child.key, at: j)
                    
                    //MARK: Database: Third Layer
                    var k = 0
                    for child in child.children {
                        guard let child = child as? DataSnapshot else { return }
                        
                        //Third Layer Configuration(s)
                        if k == HomeControllerVariables.pictureIndex {
                            child.value as! String != "" ? cellPictures.insert(child.value as! String, at: j) : cellPictures.insert(HomeControllerVariables.nilImage, at: j)
                        }
                        else {
                            cellPrice.insert(child.value as! NSNumber, at: j)
                        } 
                        k += 1
                    }
                    j += 1
                }
                self.foods.insert(Food(sectionLabel: sectionLabel, cellLabels: cellLabels, cellPictures: cellPictures, cellPrice: cellPrice), at: i)
                if self.foods.count > snapshot.childrenCount {
                    self.foods.remove(at: Int(snapshot.childrenCount))
                }
                i += 1
            }
            //Reset Receipt
            HomeTableViewCell.receipt = [:]
            
            self.homeTableView.reloadData()
        }
    }
    
    //MARK: - Constraints
    
    private func setupConstraints() {
        
        //Variables
        let safetyMarginHeight = view.safeAreaInsets.top
        let fullBarHeight = HomeControllerVariables.barHeight + safetyMarginHeight
        
        //Constraints
        view.addSubview(orderBarShadow)
        orderBarShadow.addConstraint(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: fullBarHeight)
    }
}

