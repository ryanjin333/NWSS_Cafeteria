//
//  HomeTableView.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-05.
//

import UIKit

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    private static let fullList = HomeTitleTableList()
    
    //MARK: - Table View Initialization
    
    func setUpHomeTableView() {
        
        //Table View Initialization
        view.addSubview(homeTableView)
        view.addSubview(homeTableViewTopConstraint)
        homeTableView.dataSource = self
        homeTableView.delegate = self
        homeTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "homeCell")
        
        //Table View Constraints
        homeTableViewTopConstraint.addConstraint(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: homeControllerVariables.barHeight)
        homeTableView.addConstraint(top: homeTableViewTopConstraint.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
    //MARK: - Home Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeController.fullList.cellLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
        cell.set(indexPath: indexPath)
        return cell;
    }
    
    //MARK: - Settings Table View Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  HomeController.fullList.homeHeights[indexPath.row]
    }
}
