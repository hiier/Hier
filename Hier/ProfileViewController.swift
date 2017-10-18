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
import Material 

class ProfileViewController: UIViewController, UIScrollViewDelegate {
    // user object id
    var id: String?
    var profilePic : UIImageView!
    var profilePicOuter : UIView!
    var userName : UILabel!
    var userDesc : UILabel!
    var userLoc : UILabel!
    var locationPic : UIImageView!
    
    var imageView : UIImageView!
    
    
    fileprivate var starButton: IconButton!
    fileprivate var nextButton: FlatButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpProfileInfo()
        setUpProfilePic()
        
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

//        prepareSubTableView()
        

        prepareStarButton()
        prepareNavigationItem()
        prepareSubTableView()
        
        
    }
    
    func setUpProfileInfo(){
        self.userName = UILabel()
        self.userName.text = "Hier"
        self.userName.frame =  CGRect(x: 100, y: 138, width: 121, height: 16)
        self.userName.textColor = UIColor(red: 10/255, green: 186/255, blue: 181/255, alpha: 1.00)
        self.userName.font = self.userName.font.withSize(14)
        self.userName.textAlignment = .center
//        self.view.addSubview(self.userName)
        
        self.userDesc = UILabel()
        self.userDesc.text = "An Explorer"
        self.userDesc.frame =  CGRect(x: 100, y: 155, width: 121, height: 13)
        self.userDesc.textColor = UIColor(red: 10/255, green: 186/255, blue: 181/255, alpha: 1.00)
        self.userDesc.font = self.userDesc.font.withSize(12)
        self.userDesc.textAlignment = .center
        self.view.addSubview(self.userDesc)
        
        self.userLoc = UILabel()
        self.userLoc.text = "Sunnyvale, California"
        self.userLoc.frame =  CGRect(x: 100, y: 169, width: 121, height: 13)
        self.userLoc.textColor = UIColor(red: 10/255, green: 186/255, blue: 181/255, alpha: 1.00)
        self.userLoc.font = self.userLoc.font.withSize(12)
        self.userLoc.textAlignment = .center
        self.view.addSubview(self.userLoc)
        
        self.locationPic  = UIImageView(frame:CGRect(x:78, y:170, width:13, height:13))
        self.locationPic.image = UIImage(named:"pin")
        self.view.addSubview(self.locationPic)
    
    }
    
    func setUpProfilePic() {
        //round image
//        self.profilePic  = UIImageView(frame:CGRect(x:128, y:72, width:64, height:64));
        self.profilePicOuter = UIView(frame:CGRect(x:128, y:72, width:64, height:64));
        self.profilePic  = UIImageView(frame: profilePicOuter.bounds);
               let radius = self.profilePic.frame.size.width/2
        self.profilePic.image = UIImage(named:"defaultProfile")
        
//        self.profilePic.layer.borderWidth = 1
//        self.profilePic.layer.borderColor = UIColor(red: 10/255, green: 186/255, blue: 181/255, alpha: 1.00).cgColor
        self.profilePic.layer.masksToBounds = false
        self.profilePic.layer.cornerRadius = radius
        self.profilePic.clipsToBounds = true
        
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_:)))
        
        self.profilePic.addGestureRecognizer(pictureTap)
        self.profilePic.isUserInteractionEnabled = true
        
        //add shadow
        self.profilePicOuter.clipsToBounds = false
        self.profilePicOuter.layer.shadowColor = UIColor.black.cgColor
        self.profilePicOuter.layer.shadowOpacity = 0.8
        self.profilePicOuter.layer.shadowOffset = CGSize.zero
        self.profilePicOuter.layer.shadowRadius = 2
        self.profilePicOuter.layer.shadowPath = UIBezierPath(roundedRect: self.profilePic.bounds, cornerRadius: radius).cgPath
        
//        self.view.addSubview(self.profilePic)
        self.profilePicOuter.addSubview(self.profilePic)
        self.view.addSubview(self.profilePicOuter)
        
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
        newImageView.frame = self.profilePicOuter.frame
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        
        profilePicScrollView.addSubview(newImageView)
        profilePicScrollView.backgroundColor =  .black
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


extension ProfileViewController {
    
    fileprivate func prepareSubTableView(){
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "profileTabsController") as! profileTabsController
        
//        let controller = profileTabsController()
       
        self.addChildViewController(controller)
        controller.view.frame = CGRect(x: 0, y: 190, width: self.view.bounds.size.width, height: self.view.bounds.size.height*0.7)
        self.view.addSubview(controller.view)
        controller.didMove(toParentViewController: self)

    }
}

fileprivate extension ProfileViewController{
    
    
    func prepareStarButton() {
        starButton = IconButton(image: Icon.cm.star)
    }
    
    func prepareNavigationItem() {
        self.title = self.userName.text
        let navigationBar = navigationController!.navigationBar
        navigationBar.tintColor = Constants.LightGreen
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Constants.LightGreen]
    
        
        let button = UIButton.init(type: .custom)
        //set image for button
        button.setImage(Icon.settings, for: UIControlState.normal)
        //add function for button
        button.addTarget(self, action: #selector(ProfileViewController.rightButtonPressed), for: UIControlEvents.touchUpInside)
        //set frame
        button.frame = CGRect(x: 10, y: 10, width: 35, height: 35)
        
        let rightButton = UIBarButtonItem(customView: button)
     
        navigationItem.rightBarButtonItem = rightButton
    }
    
}

extension ProfileViewController {
    @objc
    fileprivate func rightButtonPressed() {
        navigationController?.pushViewController(ProfileSetting(), animated: true)
    }
}


