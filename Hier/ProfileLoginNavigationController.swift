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
import Material

class ProfileLoginNavigationController: UINavigationController {
    
    var loginvalid = true
    var rtViewID = "ProfileViewController"
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        
        checkLogin()
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if (!self.loginvalid){
            self.rtViewID = "LoginViewController"
            let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: self.rtViewID) as! LoginViewController
            self.setViewControllers([homeViewController], animated: false)
//            self.viewControllers = [homeViewController]
        }else{
            let homeViewController = mainStoryboard.instantiateViewController( withIdentifier: self.rtViewID) as! ProfileViewController
            self.setViewControllers([homeViewController], animated: false)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func checkLogin() {
        let defaults = UserDefaults.standard
        if (defaults.object(forKey: "userToken") != nil){
            let savedinfo = defaults.object(forKey: "userToken") as! String
            
            var headers: HTTPHeaders = [:]
            if let authorizationHeader = Request.authorizationHeader(user: savedinfo, password: "foo") {
                headers[authorizationHeader.key] = authorizationHeader.value
            }
            Alamofire.request(Queries.User.login, headers: headers).responseJSON{
                
                response in
                let statusCode = (response.response?.statusCode)
                
                if( statusCode != 200){
                    //switching the screen
                    self.loginvalid = false
                }
            }
            
        }else{
            self.loginvalid = false
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

fileprivate extension ProfileLoginNavigationController{


    
}


