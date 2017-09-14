//
//  DetailedEventTableViewController.swift
//  Hier
//
//  Created by Yang Zhao on 9/11/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit

class DetailedEventTableViewController: UITableViewController {
    
    @IBOutlet weak var eventTitle: UILabel! {
        didSet {
            eventTitle.font = Constants.TitleFont
        }
    }
    
    @IBOutlet weak var eventTime: UILabel! {
        didSet {
            eventTime.font = Constants.DefaultTextFont
        }
    }
    
    @IBOutlet weak var eventLocation: UILabel! {
        didSet {
            eventLocation.font = Constants.DefaultTextFont
        }
    }
    
    @IBOutlet weak var eventPhoto: UIImageView! {
        didSet {
            eventPhoto.layer.cornerRadius = Constants.CornerRadius
            eventPhoto.layer.borderWidth = 1
            eventPhoto.clipsToBounds = true
        }
    }
    
    // MARK: - Properties
    
    var event: Event!

    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
