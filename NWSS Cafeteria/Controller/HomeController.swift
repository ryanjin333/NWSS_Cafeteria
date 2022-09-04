//
//  ViewController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-07-23.
//


import UIKit

class HomeController: UIViewController {
    
    //MARK: - Local Closure Variables
    
    let orderNavigationBar: UINavigationBar = {
        let navBar = UINavigationBar()
        navBar.backgroundColor = .transparent
        navBar.prefersLargeTitles = true
        navBar.largeTitleTextAttributes = [
            .font: UIFont(name: "AvenirNext-DemiBold", size: 29)!
        ]
        return navBar
    }()
    
    let orderNavigationTitle: UINavigationItem = {
        let navItem = UINavigationItem()
        navItem.title = HomeControllerVariables.navigationTitle
        return navItem
    }()
    
    let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "NWSSLogo")
        return imageView
    }()
    
    let orderBarShadow: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundWhite
        view.layer.applyShadow(color: .black, alpha: 0.25, x: 0, y: -6, blur: 17, spread: 0)
        return view
    }()
    
    let settingsButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.image = UIImage(systemName: "gearshape.fill")
        barButton.tintColor = .transparent
        barButton.action = #selector(settingsButtonTapped)
        return barButton
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
    
    //MARK: - Local Variables
    let settingsController = SettingsController()
    let cartController = CartController()
    var foods: [Food] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHomeController()
        setUpHomeTableView()
        homeTableViewDatabaseConfigurations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpOrderBar()
    }
}

