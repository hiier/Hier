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
   
    fileprivate var starButton: IconButton!
    fileprivate var nextButton: FlatButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkLogin()
   
//        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        if (!self.loginvalid){
            self.rtViewID = "LoginViewController"
            let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: self.rtViewID) as! LoginViewController

            self.setViewControllers([homeViewController], animated: false)


        }else{
            let homeViewController = mainStoryboard.instantiateViewController( withIdentifier: self.rtViewID) as! ProfileViewController
            self.setViewControllers([homeViewController], animated: false)
//            let nav = UINavigationController(rootViewController: homeViewController)
//            appdelegate.window!.rootViewController = nav
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareStarButton()
        prepareNavigationItem()

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
//                    self.performSegue(withIdentifier:"login", sender: self)
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

    
    func prepareStarButton() {
        starButton = IconButton(image: Icon.cm.star)
    }
    
    func prepareNavigationItem() {
        print("======")
        self.navigationItem.titleLabel.text = "Material"
        self.navigationItem.detailLabel.text = "Build Beautiful Software"
        
        
        self.navigationItem.rightViews = [starButton]
    }
    
}

extension ProfileLoginNavigationController {

}
