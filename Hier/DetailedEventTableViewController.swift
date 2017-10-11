//
//  DetailedEventTableViewController.swift
//  Hier
//
//  Created by Yang Zhao on 9/11/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import SnapKit

class DetailedEventTableViewController: UITableViewController {
    
    private var eventTitle: UILabel!
    
    private var eventTime: UILabel!
    
    private var eventLocation: UILabel!
    
    private var eventPhoto: UIImageView = UIImageView(image: UIImage(named: "defaultPhoto"))
    
    // MARK: - Properties
    
    var event: Event!
    var cells: [[UITableViewCell]] = [
        [
            UITableViewCell(),
        ]
    ]

    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Event"
        
        tableView.tableHeaderView = eventPhoto
        eventPhoto.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(eventPhoto.snp.leading).offset(0)
            make.trailing.equalTo(eventPhoto.snp.trailing).offset(0)
            make.width.equalTo(eventPhoto.snp.height).multipliedBy(16 / 9)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells[section].count
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
