//
//  EventTableViewCell.swift
//  Hier
//
//  Created by Yang Zhao on 8/16/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var eventPhoto: UIImageView! {
        didSet {
            eventPhoto.layer.cornerRadius = Constants.CornerRadius
            eventPhoto.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var eventTitle: UILabel!
    
    @IBOutlet weak var eventDescription: UILabel!
    
    @IBOutlet weak var numLikes: UILabel!
    
    @IBOutlet weak var numComments: UILabel!
    
    // MARK: - Properties
    
    var event: Event? {
        didSet {
            updateUI()
        }
    }

    // MARK: - Custom methods
    
    private func updateUI() {
        if let unwrappedEvent = event {
            eventTitle.text = unwrappedEvent.title
            eventDescription.text = unwrappedEvent.description
            numLikes.text = String(unwrappedEvent.likes.count)
            numComments.text = String(unwrappedEvent.comments.count)
        }
    }
}
