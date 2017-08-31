//
//  Like.swift
//  Hier
//
//  Created by Yang Zhao on 8/16/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import Foundation

class Like {
    
    // MARK: - Properties
    
    var user: User
    var time: Date
    
    // MARK: - Methods
    
    init?(user: User, time: Date) {
        self.user = user
        self.time = time
    }
}
