//
//  ViewController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-07-23.
//


import UIKit

class HomeController: UIViewController {
    
    
    let orderNavigationBar: UINavigationBar = {
        let navBar = UINavigationBar()
        navBar.backgroundColor = .transparent
        navBar.prefersLargeTitles = true
        return navBar
    }()
    
    let orderNavigationTitle: UINavigationItem = {
        let navItem = UINavigationItem()
        navItem.title = HomeControllerVariables.navigationTitle
        return navItem
    }()
    
    let orderBarShadow: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundWhite
        view.layer.applyShadow(color: .black, alpha: 0.4, x: 0, y: -6, blur: 20, spread: 0)
        return view
    }()
    
    let settingsButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.image = UIImage(systemName: "gearshape.fill")
        barButton.action = #selector(settingsButtonTapped)
        return barButton
    }()
    
    let cartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cart"), for: .normal)
        button.setImage(UIImage(named: "cart.fill"), for: .highlighted)
        button.layer.cornerRadius = 0.5 * HomeControllerVariables.cartButtonLength
        button.tintColor = .backgroundWhite
        button.backgroundColor = .transparent
        button.clipsToBounds = true
        return button
    }()
    
    let cartButtonShadow: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 0.5 * HomeControllerVariables.cartButtonLength
        view.layer.applyShadow(color: .black, alpha: 0.35, x: 0, y: 3, blur: 14, spread: 0)
        view.backgroundColor = .lightBlue
        return view
    }()
    
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
    
    //Variables
    let settingsController = SettingsController()
    let cartController = CartController()
    var foods: [Food] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHomeController()
        setUpHomeTableView()
        setUpCartButton()
        homeTableViewDatabaseConfigurations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpOrderBar()
    }
}

