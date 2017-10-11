//
//  User.swift
//  Hier
//
//  Created by Yang Zhao on 8/17/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import Foundation
import SwiftyJSON

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
    
    static func getProfile(id: String) -> User? {
        // pass in id and username, get token and do request in API, get json response and prepare data with json
        let paramDict: [String: String] = [
            "id": id
        ]
        let dataRequst = API.httpGet(url: Queries.User.profile, parameters: paramDict, requireAuthentication: true)

        dataRequst.responseJSON { response in
            print(response)
        }

        return User(id: "123", email: "deyomizy@gmail.com", username: "tryit")
    }
}
