//
//  ProfileViewController.swift
//  Hier
//
//  Created by P.R.K on 7/11/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MaterialComponents

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    let URL_USER = "http://127.0.0.1:5000/user/"
    var userinfo = User(id: "0", email: "yangzhao1012@gmail.com", username:"")
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        if (defaults.object(forKey: "UserName") != nil && defaults.object(forKey: "UserConfToken") != nil ){
            let user = defaults.object(forKey: "UserName") as! String
            let savedinfo = defaults.object(forKey: "UserConfToken") as! String
            let parameters: Parameters = ["username": user]
            
            var headers: HTTPHeaders = [:]
            if let authorizationHeader = Request.authorizationHeader(user: savedinfo, password: "foo") {
                headers[authorizationHeader.key] = authorizationHeader.value
            }
            Alamofire.request(URL_USER,  parameters: parameters).responseJSON{
                
                response in
                
                print(response)
                
                let statusCode = (response.response?.statusCode)
                
                if( statusCode == 200){
                    let user_json = JSON(response.result.value)
                    self.userName.text = "Your Name"
                    
                    let userinfo = User(id: "0", email: "yangzhao1012@gmail.com", username : user_json["username"].stringValue)
                    self.userName.text = user_json["username"].stringValue
                    
                    
                }
                
            }
            
        
        }else{
            self.performSegue(withIdentifier:"logintemp", sender: self)
        }
        
        

        // Do any additional setup after loading the view.
        
        self.profilePic.layer.borderWidth = 1
        self.profilePic.layer.masksToBounds = false
        self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width/2
        self.profilePic.clipsToBounds = true
        
        
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_:)))
        
        self.profilePic.addGestureRecognizer(pictureTap)
        self.profilePic.isUserInteractionEnabled = true
        
        

    }
    
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
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
