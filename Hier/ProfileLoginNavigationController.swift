//
//  ProfileLoginNavigationController.swift
//  Hier
//
//  Created by P.R.K on 8/20/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProfileLoginNavigationController: UINavigationController {
    
    let URL_SIGNIN = "http://127.0.0.1:5000/login/"

    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard
        
        if (defaults.object(forKey: "userToken") != nil){
            let savedinfo = defaults.object(forKey: "userToken") as! String
            
            var headers: HTTPHeaders = [:]
            if let authorizationHeader = Request.authorizationHeader(user: savedinfo, password: "foo") {
                headers[authorizationHeader.key] = authorizationHeader.value
            }
            Alamofire.request(URL_SIGNIN, headers: headers).responseJSON{
                
                response in
                let statusCode = (response.response?.statusCode)
                
                if( statusCode != 200){
                    //switching the screen
                    self.performSegue(withIdentifier:"login", sender: self)
                }
            }
        
        }else{
            self.performSegue(withIdentifier:"login", sender: self)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
