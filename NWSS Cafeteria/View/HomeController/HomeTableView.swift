//
//  HomeTableView.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-05.
//

import UIKit
import FirebaseDatabase

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    private static let fullList = HomeTitleTableList()
    
    
    //MARK: - Table View Initialization
    
    func setUpHomeTableView() {
        
        //Table View Initialization
        view.addSubview(homeTableView)
        view.addSubview(subtypeTableView)
        view.addSubview(tableViewTopConstraint)
        homeTableView.dataSource = self
        homeTableView.delegate = self
        subtypeTableView.dataSource = self
        subtypeTableView.delegate = self
        homeTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "homeCell")
        subtypeTableView.register(SubtypeTableViewCell.self , forCellReuseIdentifier: "subtypeCell")
        
        //Table View Constraints
        tableViewTopConstraint.addConstraint(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: homeControllerVariables.barHeight)
        homeTableView.addConstraint(top: tableViewTopConstraint.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        subtypeTableView.addConstraint(top: tableViewTopConstraint.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
    func homeTableViewDatabaseConfigurations() {
        let ref = Database.database().reference()
        ref.child(homeControllerVariables.menuName).observe(.value, with: { snapshot in
            HomeTitleTableList.cellLabels = Array(repeating: "", count: Int(snapshot.childrenCount))
            self.homeTableView.reloadData()
        })
    }
    
    //MARK: - Home Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == homeTableView {
            return HomeTitleTableList.cellLabels.count
        }
        else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == homeTableView {
            let cell = homeTableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
            cell.set(indexPath: indexPath)
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell = subtypeTableView.dequeueReusableCell(withIdentifier: "subtypeCell", for: indexPath) as! SubtypeTableViewCell
            cell.set(indexPath: indexPath)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let ref = Database.database().reference()
//        ref.child(HomeTitleTableList.cellLabels[indexPath.row]).observe(.value, with: { snapshot in
//        
//        
//    })
        if tableView == homeTableView {
        subtypeTableView.isHidden = false
        }
        else {
            subtypeTableView.isHidden = true
        }
    }
    
    //MARK: - Settings Table View Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  HomeController.fullList.homeHeights
    }
}
