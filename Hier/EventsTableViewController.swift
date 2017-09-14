//
//  EventsTableViewController.swift
//  Hier
//
//  Created by P.R.K on 7/18/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var dataMgr = DataMgr()

    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI configurations
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tableView.separatorColor = Constants.LightGreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataMgr.getEvents().count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventTableViewCell", for: indexPath)
        if let eventCell = cell as? EventTableViewCell {
            eventCell.event = dataMgr.getEvents()[indexPath.row]
        }
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailedEvent", let detvc = segue.destination as? DetailedEventTableViewController, let cell = sender as? EventTableViewCell {
            detvc.event = cell.event
        }
    }

}
