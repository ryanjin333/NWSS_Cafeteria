//
//  HelperTabBarController.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-26.
//

import UIKit

extension TabBarController: UITabBarControllerDelegate {
    
    func setUpTabBar() {
        
        //Tab Bar Initialization
        delegate = self
        
        //Home Controller Tab
        let homeController = HomeController()
        let homeControllerIcon = UITabBarItem(title: "Menu", image: UIImage(systemName: "menucard"), selectedImage: UIImage(systemName: "menucard.fill"))
        homeController.tabBarItem = homeControllerIcon
        
        //Cart Controller Tab
        let cartController = CartController()
        let cartControllerIcon = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))
        cartController.tabBarItem = cartControllerIcon
        
        //Settings Controller Tab
        let settingsController = SettingsController()
        let settingsControllerIcon = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
        settingsController.tabBarItem = settingsControllerIcon
        
        //Connection of Controllers
        let controllers = [homeController, cartController, settingsController]
        self.viewControllers = controllers
        
        //Tab Bar Attributes
        tabBar.backgroundColor = .backgroundWhite
        UITabBar.appearance().barStyle = .default
        let appearance = UITabBarItem.appearance()
        let attributesNormal = [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Medium", size: 12)]
        appearance.setTitleTextAttributes(attributesNormal as [NSAttributedString.Key : Any], for: .normal)
        UITabBar.appearance().tintColor = .schoolOrange
        
        //MARK: - Delegate
        func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
                return true
            }
        
    }
    
}
