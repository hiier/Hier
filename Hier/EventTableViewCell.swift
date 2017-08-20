//
//  EventTableViewCell.swift
//  Hier
//
//  Created by Yang Zhao on 8/16/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var numLikes: UILabel!
    
    @IBOutlet weak var numComments: UILabel!
    
    var event: Event? {
        didSet {
            updateUI()
        }
    }

    private func updateUI() {
        if let unwrappedEvent = event {
            title.text = unwrappedEvent.title
            content.text = unwrappedEvent.description
            numLikes.text = String(unwrappedEvent.likes.count)
            numComments.text = String(unwrappedEvent.comments.count)
        }
    }
}
