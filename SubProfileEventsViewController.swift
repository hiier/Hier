//
//  SubProfileEventsViewController.swift
//  Hier
//
//  Created by P.R.K on 8/29/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import MaterialComponents


class SubProfileEventsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBar = MDCTabBar(frame: view.bounds)
        tabBar.items = [
            UITabBarItem(title: "Recents", image: UIImage(named: "phone"), tag: 0),
            UITabBarItem(title: "Favorites", image: UIImage(named: "heart"), tag: 0),
        ]
        tabBar.itemAppearance = .titledImages
        tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        tabBar.sizeToFit()
        view.addSubview(tabBar)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
