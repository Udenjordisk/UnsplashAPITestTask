//
//  TabBarController.swift
//  BelashovTestTask
//
//  Created by Кирилл on 03.09.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var currentNavigationController: UINavigationController {
            TabBarController().viewControllers?[TabBarController().selectedIndex] as! UINavigationController
        }
        
        self.viewControllers = [PhotoViewController(),FavoriteListTableViewController()].map { UINavigationController(rootViewController: $0) }
        self.selectedIndex = 0
        
        if let tabBarItem1 = self.tabBar.items?[0] {
            tabBarItem1.title = "Main"
            tabBarItem1.image = UIImage(systemName: "photo.fill")
            tabBarItem1.selectedImage = UIImage(systemName: "photo")
        }
        if let tabBarItem2 = self.tabBar.items?[1] {
            tabBarItem2.title = "Favorite"
            tabBarItem2.image = UIImage(systemName: "heart.fill")
            tabBarItem2.selectedImage = UIImage(systemName: "heart")
        }
        
    }
    
    
}

