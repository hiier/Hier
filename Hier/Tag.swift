//
//  Tag.swift
//  Hier
//
//  Created by Yang Zhao on 8/22/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import Foundation

class Tag {
    
    // MARK: Properties
    
    var name: String
    var description: String
    var icon: NSData
    
    // MARK: Initialization
    
    init?(name: String, description: String, icon: NSData) {
        if name.isEmpty {
            return nil
        }
        
        self.name = name
        self.description = description
        self.icon = icon
    }
}
