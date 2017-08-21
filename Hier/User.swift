//
//  User.swift
//  Hier
//
//  Created by Yang Zhao on 8/17/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import Foundation

class User {
    
    // MARK: Properties
    
    var id: Int
    var username: String
    var participated = [Event]()
    var created = [Event]()
    var liked = [Event]()
    
    // MARK: Initialization
    
    init?( id:Int, username: String) {
        if username.isEmpty {
            return nil
        }
        
        self.id = id
        self.username = username
    }
}
