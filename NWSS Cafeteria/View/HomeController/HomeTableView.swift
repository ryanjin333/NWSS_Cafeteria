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
            
            //Fills an empty array within another empty array (Output: 2D Array)
            HomeTitleTableList.cellLabels = Array(repeating: [], count: Int(snapshot.childrenCount))
            HomeTitleTableList.cellPictures = Array(repeating: [], count: Int(snapshot.childrenCount))
            HomeTitleTableList.cellPrice = Array(repeating: [], count: Int(snapshot.childrenCount))
            
            //MARK: Database: First Layer
            var i = 0
            for child in snapshot.children {
                guard let child = child as? DataSnapshot else { return }
                
                //Fills an empty array within the 2D empty Array (Output: 3D Array)
                HomeTitleTableList.cellPictures[i] = Array(repeating: [], count: Int(child.childrenCount))
                HomeTitleTableList.cellPrice[i] = Array(repeating: [], count: Int(child.childrenCount))
                
                //First Layer Configuration(s)
                HomeTitleTableList.sectionLabels.insert(child.key, at: i)
                
                //MARK: Database: Second Layer
                var j = 0
                for child in child.children {
                    guard let child = child as? DataSnapshot else { return }
                    
                    //Fills default values within 3D array
                    HomeTitleTableList.cellPictures[i][j] = Array(repeating: "", count: Int(child.childrenCount))
                    HomeTitleTableList.cellPrice[i][j] = Array(repeating: 0, count: Int(child.childrenCount))
                    
                    //Second Layer Configuration(s)
                    HomeTitleTableList.cellLabels[i].insert(child.key, at: j)
                    
                    //MARK: Database: Third Layer
                    var k = 0
                    for child in child.children {
                        guard let child = child as? DataSnapshot else { return }
                        
                        //Third Layer Configuration(s)
                        if k == HomeControllerVariables.pictureIndex {
                            HomeTitleTableList.cellPictures[i][j].insert(child.value as! String, at: HomeControllerVariables.pictureIndex)
                        }
                        else {
                            HomeTitleTableList.cellPrice[i][j].insert(child.value as! NSNumber, at: HomeControllerVariables.priceIndex)
                        }
                        k += 1
                    }
                    j += 1
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
        return HomeTitleTableList.sectionLabels.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return HomeTitleTableList.sectionLabels[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeTitleTableList.cellLabels[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = homeTableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
            cell.set(indexPath: indexPath)
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
