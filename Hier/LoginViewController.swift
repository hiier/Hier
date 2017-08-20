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



class LoginViewController: UIViewController {
    
    let URL_SIGNIN = "http://127.0.0.1:5000/login/"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
    }
    
    
    override func viewDidLoad() {
        let defaults = UserDefaults.standard
        let savedinfo = defaults.object(forKey: "UserConfToken") as! String
        
        
        var headers: HTTPHeaders = [:]
        if let authorizationHeader = Request.authorizationHeader(user: savedinfo, password: "foo") {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        Alamofire.request(URL_SIGNIN, headers: headers).responseJSON{
            
            response in
            let statusCode = (response.response?.statusCode)
            
            if( statusCode == 200){
                
                //switching the screen
                self.performSegue(withIdentifier:"welcome", sender: self)
                
            }
            
        }
        
        
        
        
        
        
        
        
        
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
        
        Alamofire.request(URL_SIGNIN, headers: headers).responseJSON{

                response in
                //printing response
                print("request : \(String(describing:response.request))")
                print("Response String: \(String(describing:response.result.value))")
                print(response)
                print(response.response?.allHeaderFields)
            
            
            
                let statusCode = (response.response?.statusCode)
                
                if( statusCode == 200){
                    
                    let res_json = JSON(response.result.value)
                    let token = res_json["token"].stringValue
                    
                    let defaults = UserDefaults.standard
                    defaults.set(token, forKey: "UserConfToken")
                    
                
                        //switching the screen
                    self.performSegue(withIdentifier:"welcome", sender: self)

                    }else{
                        //error message in case of invalid credential
                        self.notif.text = "Invalid username or password"
                    }
                
        }
  

        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
