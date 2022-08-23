//
//  HomeTableView.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-05.
//

import UIKit
import FirebaseDatabase

extension HomeController {
    
    //MARK: - Table View Initialization
    
    func setUpHomeTableView() {
        
        //Table View Initialization
        view.addSubview(homeTableView)
        view.addSubview(tableViewTopConstraint)
        homeTableView.dataSource = self
        homeTableView.delegate = self
        homeTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "homeCell")
        
        //Table View Constraints
        tableViewTopConstraint.addConstraint(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: HomeControllerVariables.barHeight)
        homeTableView.addConstraint(top: tableViewTopConstraint.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
    func homeTableViewDatabaseConfigurations() {
        
        let ref = Database.database().reference()
        ref.child(HomeControllerVariables.menuName).observe(.value, with: { snapshot in
            
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
                            cellPictures.insert(child.value as! String, at: j)
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
            self.homeTableView.reloadData()
        })
    }
}


    //MARK: - Home Table View Data Source

extension HomeController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return HomeTitleTableList.sectionLabels.count
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //return HomeTitleTableList.sectionLabels[section]
        return foods[section].sectionLabel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return HomeTitleTableList.cellLabels[section].count
        return foods[section].cellLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = homeTableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
            
        let food = foods[indexPath.section]
        cell.set(indexPath: indexPath, with: food)
            cell.selectionStyle = .none
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let ref = Database.database().reference()
//        ref.child(HomeTitleTableList.cellLabels[indexPath.row]).observe(.value, with: { snapshot in
//        
//        
//    })
    }
}


    //MARK: - Settings Table View Delegate

extension HomeController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  HomeControllerVariables.cellHeight
    }
}
