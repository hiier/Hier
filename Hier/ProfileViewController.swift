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

class ProfileViewController: UIViewController, UIScrollViewDelegate {
    // user object id
    var id: String?
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard

        let token = defaults.object(forKey: "userToken") as? String
        let userId = defaults.object(forKey: "userId") as? String
        print("yz print token and user id");
        print(token);
        print(userId);
        if (token != nil && userId != nil) {
            let queryId = id == nil ? userId : id!

            let user: User? = User.getProfile(id: queryId!)
            if user != nil {
                self.userName.text = user!.username
            }
        }else{
            self.performSegue(withIdentifier:"ProfileToLogin", sender: self)
        }

        // Do any additional setup after loading the view.
        setUpView()
    }
    
    func setUpView() {
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
        
        
        let profilePicScrollView = UIScrollView(frame: UIScreen.main.bounds
)
        profilePicScrollView.minimumZoomScale = 1;
        profilePicScrollView.maximumZoomScale = 3.0;
        profilePicScrollView.delegate = self as! UIScrollViewDelegate;
        profilePicScrollView.translatesAutoresizingMaskIntoConstraints = true
        profilePicScrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                
//        newImageView.frame = UIScreen.main.bounds
        newImageView.frame = imageView.frame
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        
        profilePicScrollView.addSubview(newImageView)
        profilePicScrollView.backgroundColor = .black
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        profilePicScrollView.addGestureRecognizer(tap)
        
        self.view.addSubview(profilePicScrollView)
        profilePicScrollView.subviews[0].zoomIn()

        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    
    func viewForZooming(in profilePicScrollView: UIScrollView) -> UIView? {
        return profilePicScrollView.subviews[0]
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

}
