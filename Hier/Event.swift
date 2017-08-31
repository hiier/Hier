//
//  Event.swift
//  Hier
//
//  Created by P.R.K on 7/19/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import Foundation


class Event {
    
    // MARK: Properties
    
    var title: String
    var description: String
    var time: NSDate
    var location: String
    var likes = [Like]()
    var comments = [Comment]()
    var tags = [Tag]()
    
    // MARK: Initialization
    

    init?(name: String, description: String, time: NSDate, location: String) {
        // Initialization should fail if there is no name or description
        if name.isEmpty || description.isEmpty {
            return nil
        }

        self.title = name
        self.description = description
        self.time = time
        self.location = location
    }
}


