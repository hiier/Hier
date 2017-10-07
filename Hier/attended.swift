//
//  attended.swift
//  Hier
//
//  Created by P.R.K on 10/7/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import Material

class attendedViewController: UIViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.purple.base
        
        prepareTabItem()
        
    }
}

extension attendedViewController {
    fileprivate func prepareTabItem() {
        tabItem.title = "Attended"
        tabItem.titleColor = Color.blueGrey.base
        tabItem.pulseAnimation = .none
          tabItem.titleLabel!.font =  tabItem.titleLabel!.font.withSize(Constants.tabFontSize)
    }
}
