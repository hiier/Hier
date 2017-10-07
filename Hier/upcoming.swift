//
//  upcoming.swift
//  Hier
//
//  Created by P.R.K on 10/7/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//


import UIKit
import Material

class upcomingViewController: UIViewController {
    internal var tableView: ProfileSubTableView!
    open var dataSourceItems = [DataSourceItem]()
    var dataMgr = DataMgr()
    var events = [Event]()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.blue.base
        
        prepareTabItem()
//        prepareProfileSubTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareProfileSubTableView()
    }
//    open override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        prepareData()
//    }
//    
//    open override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        prepareData()
//    }

}

extension upcomingViewController {
    fileprivate func prepareTabItem() {
        tabItem.title = "Upcoming"
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
        }
        
        tableView.dataSourceItems = dataSourceItems
        tableView.reloadData()
    }
    
    
}
