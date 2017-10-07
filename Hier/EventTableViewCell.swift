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
        }
    }
    
    @IBOutlet weak var eventTitle: UILabel!
    
    @IBOutlet weak var eventDescription: UILabel!
    
    @IBOutlet weak var eventNumLikes: UILabel!
    
    @IBOutlet weak var eventNumComments: UILabel!
    
    // MARK: - Properties
    
    var event: Event! {
        didSet {
            if event != nil {
                eventTitle.text = event.title
                eventDescription.text = event.description
                eventNumLikes.text = String(event.likes.count)
                eventNumComments.text = String(event.comments.count)
            }
        }
    }
}
