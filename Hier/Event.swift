//
//  Event.swift
//  Hier
//
//  Created by P.R.K on 7/19/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit


class Event {
    
    //MARK: Properties
    
    var name: String
    var description: String
    var time: String
    var location: String
    
    
    //MARK: Initialization
    

    init?(name: String, description: String, time:String, location: String) {
        
        // Initialization should fail if there is no name or if the rating is negative.
        guard !name.isEmpty else {
            return nil
        }
        
        guard !description.isEmpty else {
            return nil
        }
    
        
        // Initialize stored properties.
        self.name = name
        self.description = description
        self.time = time
        self.location = location
        
        
        
        

        
    }
    

    
}


