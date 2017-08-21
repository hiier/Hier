//
//  EventMgr.swift
//  Hier
//
//  Created by Yang Zhao on 8/17/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import Foundation
import Alamofire

class EventMgr {
    
    private var users = [User]()
    private var likes = [Like]()
    private var comments = [Comment]()
    
    
    // MARK: Properties
    
    var events = [Event]()
        
    // MARK: Methods
    
    init() {
        users = [
            User(id: 0, username: "Amy")!,
            User(id: 1, username: "Bob")!,
            User(id: 2, username: "Chris")!,
            User(id: 3, username: "David")!,
            User(id: 4, username: "Eva")!
        ]
        
        for user in users {
            likes.append(Like(user: user, time: NSDate())!)
            comments.append(Comment(user: user, time: NSDate(), content: "\(user.username): Nice")!)
        }
    }
    
    func update() {
        for _ in 0..<5 {
            if let event = createDummyEvent() {
                events.append(event)
            }
        }
//        Alamofire.request("http://127.0.0.1:5000/events", method: .get).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let valueArray = (value as! NSArray) as Array
//                
//                for eventvalue in valueArray{
//                    var thestring = eventvalue as! String
//                    if let dataFromString = thestring.data(using: .utf8){
//                        var eventJson = JSON(data: dataFromString)
//                        if let evt = Event(name: eventJson["title"].stringValue, description: eventJson["description"].stringValue, time: eventJson["time"]["$date"].stringValue, location: eventJson["location"]["coordinates"].stringValue)  {
//                            self.events.append(evt)
//                        }
//                        
//                        
//                    } else{
//                        fatalError("Unable to instantiate event")
//                        
//                    }
//                    
//                    
//                }
//                
//                
//            case .failure(let error):
//                print(error)
//            }
//            
//        }
    }
    
    private func createDummyEvent() -> Event? {
        let event = Event(name: "Dining", description: "Let's go eating at Xi'an Kitchen!", time: NSDate(), location: "300 Barber Ct, Milpitas, CA 95035")!
        event.likes = [likes[0], likes[2], likes[4]]
        event.comments = [comments[1], comments[3]]
        return event
    }
}
