//
//  myevents.swift
//  Hier
//
//  Created by P.R.K on 10/7/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import Material

class myeventsViewController: UIViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.brown.base
        
        prepareTabItem()
        
    }
}

extension myeventsViewController {
    fileprivate func prepareTabItem() {
        tabItem.title = "MyEvents"
        tabItem.titleColor = Color.blueGrey.base
        tabItem.pulseAnimation = .none
          tabItem.titleLabel!.font =  tabItem.titleLabel!.font.withSize(Constants.tabFontSize)
    }
}
