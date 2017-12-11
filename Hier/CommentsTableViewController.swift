//
//  CommentsTableViewController.swift
//  Hier
//
//  Created by Yang Zhao on 11/22/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController {
    
    // MARK: - Constants
    
    private static let CellReuseIdentifier = "commentTableViewCell"
    
    // MARK: - Properties
    
    public var comments: [Comment] = []

    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navigation bar
        title = "Comment"
        let commentBarButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(compose))
        commentBarButton.tintColor = Constants.ThemeColor
        navigationItem.rightBarButtonItem  = commentBarButton
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewController.CellReuseIdentifier, for: indexPath)
        if let ctvc = cell as? CommentTableViewCell {
            ctvc.selectionStyle = .none
            ctvc.comment = comments[indexPath.row]
        }
        return cell
    }
    
    // MARK: - Methods
    
    func compose() {
        
    }
}
