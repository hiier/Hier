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
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.blue.base
        
        prepareTabItem()
        prepareProfileSubTableView()
        
    }
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
        prepareData( btnLabel: tabItem.title! )
        
    }
    
    fileprivate func prepareData(btnLabel : String) {
        let persons = [["name": "Daniel"], ["name": "Sarah"]]
        for person in persons {
            dataSourceItems.append(DataSourceItem(data: person))
        }
        tableView.dataSourceItems = dataSourceItems
        tableView.reloadData()
    }
    
    
}
