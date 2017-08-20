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
    var name: String
    var participated = [Event]()
    var created = [Event]()
    var liked = [Event]()
    
    // MARK: Initialization
    
    init?(id: Int, name: String) {
        if name.isEmpty {
            return nil
        }
        
        self.id = id
        self.name = name
    }
}
