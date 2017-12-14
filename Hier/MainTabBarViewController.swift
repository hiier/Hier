//
//  MainTabBarViewController.swift
//  Hier
//
//  Created by Yang Zhao on 8/17/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainTabBarViewController: UITabBarController {
    var loginvalid = true
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkLogin()
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //        let eventsTableViewController = EventsTableViewController()
        let eventsTableViewController = mainStoryboard.instantiateViewController(withIdentifier: "eventsTableViewController") as! EventsTableViewController
        
        
        eventsTableViewController.tabBarItem = UITabBarItem(title
            :"Home", image:UIImage(named:"home"), tag:0 )
        //
        //        let profileViewController = ProfileViewController()
        var profileViewController = mainStoryboard.instantiateViewController(withIdentifier: "ProfileViewController")
//        var profileViewController = mainStoryboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        
        
        if (!self.loginvalid){
            profileViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
        
        }
        
        profileViewController.tabBarItem = UITabBarItem(title
            :"Profile", image:UIImage(named:"profile"), tag:1 )
        
        let notificationViewController = NotificationTableViewController()
        notificationViewController.tabBarItem = UITabBarItem(title
            :"Notice", image:UIImage(named:"messaging"), tag:2 )
        
        
        
        
        
        
//        let viewControllerList = [ UINavigationController(rootViewController:eventsTableViewController), profileLoginNavigationController ]
//        viewControllers = viewControllerList
        
        
         let viewControllerList = [eventsTableViewController, profileViewController, notificationViewController  ]
                viewControllers = viewControllerList.map { UINavigationController(rootViewController: $0) }
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
}
