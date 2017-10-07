//
//  DataMgr
//  Hier
//
//  Created by Yang Zhao on 8/17/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import Foundation
import MapKit

class DataMgr {
    
    // MARK: - Properties
    
    private var events: [Event] = []
    private var user: User?
    
    private static var dataMgr: DataMgr?
        
    // MARK: - Methods
    
    init() {
        createDummyUser()
        createDummyEvent()
    }
    
    private func createDummyUser() {
        self.user = User(id: "1234123", email: "yangzhao1012@gmail.com", username: "Vincent")
    }
    
    private func createDummyEvent() {
        let location = CLLocation(latitude: 37.423440, longitude: -121.917371)
        let event = Event(id: "1341324", title: "Dining", description: "Let's go eating at Xi'an Kitchen! Let's go eating at Xi'an Kitchen! Let's go eating at Xi'an Kitchen! Let's go eating at Xi'an Kitchen! Let's go eating at Xi'an Kitchen! Let's go eating at Xi'an Kitchen! Let's go eating at Xi'an Kitchen!", photo: nil, time: Date(), location: location, contactPhone: "6502857451", maxNumParticipants: 5, creator: self.user!)!
        self.events = [event]
    }
    
    public static func getSingletonInstance() -> DataMgr {
        if dataMgr == nil {
            dataMgr = DataMgr()
        }
        return dataMgr!
    }
    
    public func getEvents() -> [Event] {
        return events
    }
    
    public func createEvent(title: String, description: String, photo: NSData?, time: Date, location: MKPlacemark, contactPhone: String) {
    }
    
    public func updateEvent(id: String, title: String, description: String, photo: NSData?, time: Date, location: MKPlacemark, contactPhone: String) {
    }
    
    public func likeEvent(id: String) {
    }
    
    public func dislikeEvent(id: String) {
    }
    
    public func commentEvent(id: String, content: String) {
    }
    
    public func joinEvent(id: String) {
    }
    
    public func leaveEvent(id: String) {
    }
    
    public func createUser(email: String, username: String) {
    }
    
    public func updateUser(id: String, username: String) {
    }
}
