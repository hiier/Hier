//
//  File.swift
//  Hier
//
//  Created by P.R.K on 10/7/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import Material

class profileTabsController: TabsController {
    
        
    open override func prepare() {
        self.viewControllers = [upcomingViewController(),
                                attendedViewController(),
                                myeventsViewController(),
                                savedViewController()]
        super.prepare()
        
        tabBarAlignment = .top
        tabBar.tabBarStyle = .auto
        tabBar.lineHeight = 2.0
        tabBar.dividerColor = Color.grey.lighten2
        tabBar.dividerAlignment = .top
        tabBar.lineColor = Color.cyan.base
        tabBar.lineAlignment = .bottom
        tabBar.backgroundColor = Color.grey.lighten5
        motionTransitionType = .autoReverse(presenting: .slide(direction: .left))
        
    }
}



