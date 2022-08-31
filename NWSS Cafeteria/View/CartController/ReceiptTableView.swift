//
//  ReceiptTableView.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-27.
//

import UIKit

extension CartController {
    
    func setUpRecieptTableView() {

        //Remove all previous receiptViews and receiptTableViews
        receiptView.removeFromSuperview()
        receiptTableView.removeFromSuperview()
        
        //Create a new instance of receiptView and receiptTableView
        receiptView = {
            let view = UIView()
            view.backgroundColor = .backgroundWhite
            view.layer.applyShadow(color: .black, alpha: 0.1, x: 0, y: 4, blur: 11, spread: 0)
            view.layer.cornerRadius = 11
            return view
        }()
        receiptTableView = {
            let tableView = UITableView()
            tableView.backgroundColor = .backgroundWhite
            tableView.isScrollEnabled = false
            tableView.showsVerticalScrollIndicator = false
            tableView.separatorStyle = .none
            tableView.layer.cornerRadius = 11
            return tableView
        }()
        
        //receiptTableView General Configurations
        receiptTableView.dataSource = self
        receiptTableView.delegate = self
        receiptTableView.register(ReceiptTableViewCell.self, forCellReuseIdentifier: "receiptCell")
        if HomeTableViewCell.receipt.count > 3 {
            receiptTableView.isScrollEnabled = true
            scrollDownLabel.alpha = 1
        }
        else {
            scrollDownLabel.alpha = 0
        }
        
    
        //Variables
        var tableViewCellCount: CGFloat = 0
        if HomeTableViewCell.receipt.count == 1 {
            tableViewCellCount = 1
        }
        else if HomeTableViewCell.receipt.count == 2 {
            tableViewCellCount = 2
        }
        else {
            tableViewCellCount = 3
        }
        
        //Constraints
        view.addSubview(receiptView)
        receiptView.addSubview(receiptTableView)
        receiptView.addSubview(zeroItemMessageLabel)
        receiptView.addSubview(scrollDownLabel)
        receiptView.addConstraint(top: yourOrderLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 10, paddingLeft: 20, paddingRight: 20, paddingBottom: 0, width: 0, height: HomeControllerVariables.cellHeight * tableViewCellCount)
        receiptTableView.addConstraint(top: receiptView.topAnchor, left: receiptView.leftAnchor, right: receiptView.rightAnchor, bottom: receiptView.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        zeroItemMessageLabel.addConstraint(top: receiptView.topAnchor, left: receiptView.leftAnchor, right: receiptView.rightAnchor, bottom: receiptView.bottomAnchor, paddingTop: 0, paddingLeft: 30, paddingRight: 30, paddingBottom: 0, width: 0, height: 0)
        scrollDownLabel.addConstraint(top: nil, left: nil, right: nil, bottom: receiptView.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 5, width: 0, height: 0)
        scrollDownLabel.centerXAnchor.constraint(equalTo: receiptView.centerXAnchor).isActive = true
        
        //Zero Item Message Visibility
        if HomeTableViewCell.receipt.count == 0 {
            tableViewCellCount = 3
            receiptTableView.removeFromSuperview()
            zeroItemMessageLabel.isHidden = false
        }
        else {
            zeroItemMessageLabel.isHidden = true
        }
        
    }
    
}

//MARK: - Receipt Table View Data Source

extension CartController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeTableViewCell.receipt.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = receiptTableView.dequeueReusableCell(withIdentifier: "receiptCell", for: indexPath) as! ReceiptTableViewCell
        cell.getFoodNames()
        cell.set(indexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromDisappearing = scrollView.contentSize.height - contentYoffset - HomeControllerVariables.cellHeight / 2
        if scrollView.contentOffset.y <= 20 {
            UIView.animate(withDuration: 0.25) {
                self.scrollDownLabel.alpha = 1
            }
        }
        if distanceFromDisappearing <= height && scrollView.contentOffset.y > 0 {
            UIView.animate(withDuration: 0.25) {
                self.scrollDownLabel.alpha = 0
            }
        }
    }
}

//MARK: - Receipt Table View Delegate

extension CartController: UITableViewDelegate {

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return  HomeControllerVariables.cellHeight
}
}
