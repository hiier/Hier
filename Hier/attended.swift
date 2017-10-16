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
    internal var tableView: ProfileSubTableView!
    open var dataSourceItems = [DataSourceItem]()
    var dataMgr = DataMgr()
    var events = [Event]()
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = Color.purple.base
        
        prepareTabItem()
        prepareProfileSubTableView()
        
    }
}

extension attendedViewController {
    fileprivate func prepareTabItem() {
        tabItem.title = "Attended"
        tabItem.titleColor = Color.blueGrey.base
        tabItem.pulseAnimation = .none
          tabItem.titleLabel!.font =  tabItem.titleLabel!.font.withSize(Constants.tabFontSize)
    }
    
    
    func prepareProfileSubTableView(){
        
        tableView = ProfileSubTableView()
        tableView.isScrollEnabled = true
        view.layout(tableView).edges()
        prepareData( )
    }
    
    fileprivate func prepareData() {
        self.events = self.dataMgr.getEvents()
        for evt in self.events {
            dataSourceItems.append(DataSourceItem(data: evt))
            dataSourceItems.append(DataSourceItem(data: evt))
        }
        
        tableView.dataSourceItems = dataSourceItems
        tableView.reloadData()
    }
    
    
}
