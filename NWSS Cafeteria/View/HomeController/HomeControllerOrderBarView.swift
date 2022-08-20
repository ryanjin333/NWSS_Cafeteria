//
//  HomeControllerView.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-07-30.
//

import UIKit

extension HomeController {
    
    //MARK: - Bar Initialization
    
    func setUpOrderBar() {
        
        //Variables
        let safetyMarginHeight = view.safeAreaInsets.top
        let fullBarHeight = HomeControllerVariables.barHeight + safetyMarginHeight
        
        //Others
        orderNavigationBar.setItems([orderNavigationTitle], animated: false)
        orderNavigationBar.topItem?.rightBarButtonItem = settingsButton
        
        //Constraints
        view.addSubview(orderBarShadow)
        view.addSubview(orderNavigationBar)
        orderBarShadow.addConstraint(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: fullBarHeight)
        orderNavigationBar.addConstraint(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: HomeControllerVariables.barHeight)
    }
    
}
