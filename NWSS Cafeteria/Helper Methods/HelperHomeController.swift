//
//  HelperHomeController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-07-23.
//

import UIKit

extension HomeController {
    
    func setupHomeController() {
        view.backgroundColor = .backgroundWhite
    }
}

//MARK: - Home Table View Data Source

extension HomeController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return foods.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return foods[section].sectionLabel
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.frame = CGRect(x: 12, y: 5, width: UIScreen.main.bounds.width, height: 20)
        label.font = UIFont.init(name: "AvenirNext-DemiBold", size: 16)
        label.text = self.tableView(tableView, titleForHeaderInSection: section)
        label.textColor = .darkerGrey
        let headerView = UIView()
        headerView.frame = CGRect(x: 12, y: 5, width: UIScreen.main.bounds.width, height: 20)
        headerView.applyBlurEffect()
        headerView.addSubview(label)
        return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods[section].cellLabels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
            
        let food = foods[indexPath.section]
        cell.getFood(food: food)
        cell.set(indexPath: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsets.init(top: 0, left: UIScreen.main.bounds.width, bottom: 0.0, right: 0)
        return cell
    }
}


//MARK: - Settings Table View Delegate

extension HomeController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  HomeControllerVariables.cellHeight
    }
}

