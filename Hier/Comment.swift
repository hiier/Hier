//
//  Comment.swift
//  Hier
//
//  Created by Yang Zhao on 8/16/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import Foundation

class Comment {
    
    // MARK: - Properties
    
    var user: User
    var time: Date
    var content: String
    
    // MARK: - Methods
    
    init?(user: User, time: Date, content: String) {
        guard Comment.isValidContent(content) else {
            return nil
        }
        
        self.user = user
        self.time = time
        self.content = content
    }
    
    public static func isValidContent(_ content: String) -> Bool {
        return !content.isEmpty
    }
}
