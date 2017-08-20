//
//  Comment.swift
//  Hier
//
//  Created by Yang Zhao on 8/16/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import Foundation

class Comment {
    
    // MARK: Properties
    
    var user: User
    var time: NSDate
    var content: String
    
    // MARK: Initialization
    
    init?(user: User, time: NSDate, content: String) {
        if content.isEmpty {
            return nil
        }
        
        self.user = user
        self.time = time
        self.content = content
    }
}
