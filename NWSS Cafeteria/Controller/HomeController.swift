//
//  ViewController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-07-23.
//


import UIKit
import FirebaseDatabase

class HomeController: UIViewController {
    
    let orderNavigationBar: UINavigationBar = {
        let navBar = UINavigationBar()
        navBar.backgroundColor = .transparent
        navBar.prefersLargeTitles = true
        return navBar
    }()
    
    let orderNavigationTitle: UINavigationItem = {
        let navItem = UINavigationItem()
        navItem.title = "Order"
        return navItem
    }()
    
    let orderBarShadow: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundWhite
        view.layer.applyShadow(color: .black, alpha: 0.4, x: 0, y: -1, blur: 20, spread: 0)
        return view
    }()
    
    let settingsButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.image = UIImage(systemName: "gearshape.fill")
        barButton.action = #selector(settingsButtonTapped)
        return barButton
    }()
    
    let homeTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundWhite
        return tableView
    }()
    
    let homeTableViewTopConstraint: UIView = {
        let constraint = UIView()
        constraint.alpha = 0
        return constraint
    }()
    
    let homeControllerVariables = HomeControllerVariables()
    var homeTitleTableList = HomeTitleTableList()
    let database = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHomeController()
        setUpHomeTableView()
        setUpHomeTableViewDatabase()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpOrderBar()
    }
}

