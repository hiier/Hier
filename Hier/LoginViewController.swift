//
//  LoginViewController.swift
//  Hier
//
//  Created by P.R.K on 6/28/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import Alamofire
import FacebookLogin
import SwiftyJSON

import Material



class LoginViewController: UIViewController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
    }

    override func viewDidLoad() {
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
   }

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var notif: UILabel!

    @IBAction func login(_ sender: UIButton) {
        
//        let auth = "Basic " + username.text! + ":" + password.text!
//        
//        print(auth)
//        let headers :HTTPHeaders = [
//            "Authorization": auth,
//            "Accept": "text/html"
//        ]
        
        
//        Alamofire.request(URL_SIGNIN, method:.get,  encoding: URLEncoding.queryString, headers:headers ).responseString{
//         
        let user = username.text!
        let psw = password.text!
        
        var headers: HTTPHeaders = [:]
        if let authorizationHeader = Request.authorizationHeader(user: user, password: psw) {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        
        Alamofire.request(Queries.User.login, headers: headers).responseJSON{ response in
            //printing response
            print("request : \(String(describing:response.request))")
            print("Response String: \(String(describing:response.result.value))")
            print(response)
            print(response.response?.allHeaderFields)

            let statusCode = (response.response?.statusCode)
            
            if( statusCode == 200){
                
                let res_json = JSON(response.result.value)
                let token = res_json["token"].stringValue
                let userId = res_json["id"].stringValue
                
                let defaults = UserDefaults.standard
                defaults.set(token, forKey: "userToken")
                defaults.set(userId, forKey:"userId")
                //switching the screen
                self.performSegue(withIdentifier:"welcome", sender: self)
            }else{
                //error message in case of invalid credential
                self.notif.text = "Invalid username or password"
            }
        }
    }
}
