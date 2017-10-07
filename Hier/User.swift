//
//  User.swift
//  Hier
//
//  Created by Yang Zhao on 8/17/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import Foundation

class User {
    
    // MARK: - Properties
    
    var id: String
    var email: String
    var username: String
    var photo: Data?
    
    var participated: [Event] = []
    var created: [Event] = []
    var liked: [Event] = []
    
    // MARK: - Methods
    
    init?(id: String, email: String, username: String) {
        self.id = id
        self.email = email
        self.username = username
    }
}
