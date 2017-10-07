//
//  saved.swift
//  Hier
//
//  Created by P.R.K on 10/7/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import Material

class savedViewController: UIViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.cyan.base

        
        prepareTabItem()
        
    }
}

extension savedViewController {
    fileprivate func prepareTabItem() {
        tabItem.title = "Saved"
        tabItem.titleColor = Color.blueGrey.base
        tabItem.pulseAnimation = .none
        tabItem.titleLabel!.font =  tabItem.titleLabel!.font.withSize(Constants.tabFontSize)
    }
}
