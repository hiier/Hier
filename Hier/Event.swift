//
//  Event.swift
//  Hier
//
//  Created by P.R.K on 7/19/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import Foundation
import MapKit
import Material

class Event {
    
    // MARK: - Properties
    
    var id: String
    var title: String
    var description: String?
    var photo: NSData?
    var time: Date
    var location: CLPlacemark
    var contactPhone: String?
    var maxNumParticipants: Int?
    var creator: User
    
    var likes: [Like] = []
    var comments: [Comment] = []
    var tags: [Tag] = []
    var participants: [User] = []
    
    // MARK: - Methods
    
    init?(id: String, title: String, description: String?, photo: NSData?, time: Date, location: CLPlacemark, contactPhone: String?, maxNumParticipants: Int?, creator: User) {
        guard Event.isValidTitle(title) && Event.isValidDescription(description) && Event.isValidTime(time) else {
            return nil
        }
        
        self.id = id
        self.title = title
        self.description = description
        self.photo = photo
        self.time = time
        self.location = location
        self.contactPhone = contactPhone
        self.maxNumParticipants = maxNumParticipants
        self.creator = creator
    }
    
    public static func isValidTitle(_ title: String) -> Bool {
        return !title.isEmpty
    }
    
    public static func isValidDescription(_ description: String?) -> Bool {
        return description == nil || !description!.isEmpty
    }
    
    public static func isValidTime(_ time: Date) -> Bool {
        return true
    }
}


