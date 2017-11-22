//
//  EventsTableViewController.swift
//  Hier
//
//  Created by P.R.K on 7/18/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController {
    
    // MARK: - Constants
    
    private static let CellReuseIdentifier = "eventTableViewCell"
    
    // MARK: - Properties
    
    private var dataMgr = DataMgr()

    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navigation bar
        title = "Home"
        navigationController?.navigationBar.titleTextAttributes = [
            NSFontAttributeName: Constants.NavigationTitleFont,
            NSForegroundColorAttributeName: Constants.ThemeColor
        ]
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentCreateEventTableViewController))
        addBarButton.tintColor = Constants.ThemeColor
        navigationItem.rightBarButtonItem  = addBarButton
        
        // Table view config
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tableView.separatorColor = Constants.ThemeColor
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataMgr.getEvents().count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventsTableViewController.CellReuseIdentifier, for: indexPath)
        if let etvc = cell as? EventTableViewCell {
            etvc.event = dataMgr.getEvents()[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EventTableViewCell.CellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detvc = storyboard?.instantiateViewController(withIdentifier: "detailedEventTableViewController") as? DetailedEventTableViewController {
            detvc.event = dataMgr.getEvents()[indexPath.row]
            navigationController?.pushViewController(detvc, animated: true)
        }
    }
    
    // MARK: - Methods
    
    func presentCreateEventTableViewController() {
        if let cetvc = storyboard?.instantiateViewController(withIdentifier: "createEventTableViewController") as? CreateEventTableViewController {
            let nc = UINavigationController(rootViewController: cetvc)
            present(nc, animated: true, completion: nil)
        }
    }
}
