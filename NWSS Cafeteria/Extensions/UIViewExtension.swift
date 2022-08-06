//
//  UIViewExtension.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-07-23.
//

import UIKit

extension UIView {
    
    func addConstraint(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingRight: CGFloat, paddingBottom: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        // Use the top parameter to set the top constraint
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        // Use the left parameter to set the left constraint
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        // Use the right parameter to set the right constraint
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        // Use the bottom parameter to set the bottom constraint
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        // Use the width parameter to set the top constraint
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        // Use the height parameter to set the top constraint
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}



