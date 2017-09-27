//
//  ProfileEvtsTabBarViewController.swift
//  Hier
//
//  Created by P.R.K on 8/30/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import MaterialComponents

class ProfileEvtsTabBarViewController: MDCTabBarViewController {
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let tabBar = MDCTabBar(frame: view.bounds)
        tabBar.items = [
            UITabBarItem(title: "Upcoming", image: UIImage(named: "phone"), tag: 0),
            UITabBarItem(title: "Attended", image: UIImage(named: "heart"), tag: 1),
            UITabBarItem(title: "My Events", image: UIImage(named: "phone"), tag: 2),
            UITabBarItem(title: "Saved", image: UIImage(named: "heart"), tag: 3),
        ]
        
        tabBar.tintColor = UIColor(red:0.04, green:0.73, blue:0.71, alpha:1.0)
        
        tabBar.barTintColor = UIColor(red:0.04, green:0.73, blue:0.71, alpha:1.0)
        tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        tabBar.sizeToFit()
        view.addSubview(tabBar)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
