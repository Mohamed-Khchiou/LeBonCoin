//
//  Project > Le bon coin
//  Filename > MainTabBarController.swift
//
//  Created by Guillaume Gonzales on 04/10/2018.
//  Copyright © 2018 Tokidev S.A.S. - All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    
    fileprivate func setupViewControllers() {
        let layout = UICollectionViewFlowLayout()
        
        let navHomeController = UINavigationController(rootViewController: HomeController(collectionViewLayout: layout))
        
        navHomeController.tabBarItem.image = #imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal)
        navHomeController.tabBarItem.selectedImage = #imageLiteral(resourceName: "search_selected").withRenderingMode(.alwaysOriginal)
        
        let navNewOfferController = UINavigationController(rootViewController: NewOfferController())
        navNewOfferController.tabBarItem.image = #imageLiteral(resourceName: "new_offer").withRenderingMode(.alwaysOriginal)
        navNewOfferController.tabBarItem.selectedImage = #imageLiteral(resourceName: "new_offer_selected").withRenderingMode(.alwaysOriginal)
        
        viewControllers = [navHomeController, navNewOfferController]
        
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
}
