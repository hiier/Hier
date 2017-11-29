//
//  MainTabBarViewController.swift
//  Hier
//
//  Created by Yang Zhao on 8/17/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let eventsTableViewController = EventsTableViewController()
        let eventsTableViewController = mainStoryboard.instantiateViewController(withIdentifier: "eventsTableViewController") as! EventsTableViewController
      
       
        eventsTableViewController.tabBarItem = UITabBarItem(title
            :"Home", image:UIImage(named:"home"), tag:0 )
//        eventsTableViewController.tabBarItem.image=UIImage(named:"home")
//        let profileViewController = ProfileViewController()
        let profileViewController = mainStoryboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileViewController.tabBarItem = UITabBarItem(title
            :"Profile", image:UIImage(named:"profile"), tag:1 )
//        profileViewController.tabBarItem.image=UIImage(named:"profile")
        
        
        
        let viewControllerList = [ eventsTableViewController, profileViewController ]
//        viewControllers = viewControllerList
        viewControllers = viewControllerList.map { UINavigationController(rootViewController: $0) }
        
        
        
        
    }
}
