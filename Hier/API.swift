//
//  API.swift
//  Hier
//
//  Created by Yue Zhang on 9/19/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


struct Queries {
    struct User {
//        static let login = "http://127.0.0.1:5000/login/"
//        static let profile = "http://127.0.0.1:5000/user/"
//        static let register = "http://127.0.0.1:5000/signup/"
//        static let events = "http://127.0.0.1:5000/events"
        
        static let login = "https://erhi.herokuapp.com/login/"
        static let profile = "https://erhi.herokuapp.com/user/"
        static let register = "https://erhi.herokuapp.com/signup/"
        static let events = "https://erhi.herokuapp.com/events"
        
    }
}

// 1. get request and post request, url, request arguments, request headers and body as arguments
// 2. a constant map to hold all common requestes, e.g. user.profile -> /user?id=xxxxx
class API {
    static func getUserToken() -> String? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: "userToken") as? String
    }
    
    static func httpGet(url:String, parameters: Dictionary<String, Any>, requireAuthentication: Bool) -> DataRequest {
        var headers: HTTPHeaders = [:]
        if requireAuthentication {
            let userToken: String? = getUserToken()
            if userToken == nil {
                // what should be the return value?
            }
            if let authorizationHeader = Request.authorizationHeader(user: userToken!, password: "foo") {
                headers[authorizationHeader.key] = authorizationHeader.value
            }
        }
        return Alamofire.request(url, parameters: parameters, headers: headers)
    }
}
