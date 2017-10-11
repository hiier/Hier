//
//  Tag.swift
//  Hier
//
//  Created by Yang Zhao on 8/22/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import Foundation

class Tag {
    
    // MARK: - Properties
    
    var name: String
    var description: String?
    var icon: Data
    
    // MARK: - Methods
    
    init?(name: String, description: String?, icon: Data) {
        guard Tag.isValidName(name) else {
            return nil
        }
        
        self.name = name
        self.description = description
        self.icon = icon
    }
    
    public static func isValidName(_ name: String) -> Bool {
        return !name.isEmpty
    }
}
