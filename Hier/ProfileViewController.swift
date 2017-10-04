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
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    fileprivate var buttons = [TabItem]()
    fileprivate var tabBar: TabBar!
    fileprivate let tabFontSize: CGFloat = 14
    
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
        setUpProfilePic()
        prepareButtons()
        prepareTabBar()
    }
    
    func setUpProfilePic() {
        //round image
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


extension ProfileViewController {
    fileprivate func prepareButtons() {
        let btn1 = TabItem(title: "Upcoming", titleColor: Color.blueGrey.base)
        btn1.pulseAnimation = .none
        btn1.titleLabel!.font =  btn1.titleLabel!.font.withSize(tabFontSize)
        buttons.append(btn1)
        
        let btn2 = TabItem(title: "Attended", titleColor: Color.blueGrey.base)
        btn2.pulseAnimation = .none
        btn2.titleLabel!.font =  btn1.titleLabel!.font.withSize(tabFontSize)
        buttons.append(btn2)
        
        let btn3 = TabItem(title: "My Events", titleColor: Color.blueGrey.base)
        btn3.pulseAnimation = .none
        btn3.titleLabel!.font =  btn1.titleLabel!.font.withSize(tabFontSize)
        buttons.append(btn3)
        
        let btn4 = TabItem(title: "Saved", titleColor: Color.blueGrey.base)
        btn4.pulseAnimation = .none
        btn4.titleLabel!.font =  btn1.titleLabel!.font.withSize(tabFontSize)
        buttons.append(btn4)
    }
    
    fileprivate func prepareTabBar() {
        tabBar = TabBar()
        tabBar.delegate = self
        
        tabBar.dividerColor = Color.grey.lighten2
        tabBar.dividerAlignment = .top
        
        tabBar.lineColor = Color.cyan.base
        tabBar.lineAlignment = .bottom
        
        tabBar.backgroundColor = Color.grey.lighten5
        tabBar.tabItems = buttons
    
        view.layout(tabBar).horizontally().center(offsetY: -40)
    }
}

extension ProfileViewController: TabBarDelegate {
    func tabBar(tabBar: TabBar, willSelect button: UIButton) {
        print("will select")
    }
    
    func tabBar(tabBar: TabBar, didSelect button: UIButton) {
        print("did select")
    }
}
