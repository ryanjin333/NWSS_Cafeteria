//
//  SubtotalAndTotalView.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-28.
//

import UIKit

extension CartController {
    
    func setUpSubtotalAndTotalView() {
        
        //Set Amount For each label
        subtotalAmountLabel.text = "$\(String(format: "%.2f", totalOfOrder))"
        taxAmountLabel.text = "N/A"
        totalAmountLabel.text = "$\(String(format: "%.2f", totalOfOrder))"
        
        //Constraints
        view.addSubview(subtotalLabel)
        view.addSubview(taxLabel)
        view.addSubview(subtotalAndTotalSeperator)
        view.addSubview(totalLabel)
        view.addSubview(subtotalAmountLabel)
        view.addSubview(taxAmountLabel)
        view.addSubview(totalAmountLabel)
        
        subtotalLabel.addConstraint(top: receiptView.bottomAnchor, left: view.leftAnchor, right: nil, bottom: nil, paddingTop: 20, paddingLeft: 20, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        taxLabel.addConstraint(top: subtotalLabel.bottomAnchor, left: view.leftAnchor, right: nil, bottom: nil, paddingTop: 15, paddingLeft: 20, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        subtotalAndTotalSeperator.addConstraint(top: taxLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 15, paddingLeft: 20, paddingRight: 20, paddingBottom: 0, width: 0, height: 1)
        totalLabel.addConstraint(top: subtotalAndTotalSeperator.bottomAnchor, left: view.leftAnchor, right: nil, bottom: nil, paddingTop: 15, paddingLeft: 20, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        subtotalAmountLabel.addConstraint(top: receiptView.bottomAnchor, left: nil, right: view.rightAnchor, bottom: nil, paddingTop: 20, paddingLeft: 0, paddingRight: 20, paddingBottom: 0, width: 0, height: 0)
        taxAmountLabel.addConstraint(top: subtotalLabel.bottomAnchor, left: nil, right: view.rightAnchor, bottom: nil, paddingTop: 15, paddingLeft: 0, paddingRight: 20, paddingBottom: 0, width: 0, height: 0)
        totalAmountLabel.addConstraint(top: subtotalAndTotalSeperator.bottomAnchor, left: nil, right: view.rightAnchor, bottom: nil, paddingTop: 15, paddingLeft: 0, paddingRight: 20, paddingBottom: 0, width: 0, height: 0)
    }
    
}
