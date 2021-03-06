//
//  profilePicEditingViewController.swift
//  Hier
//
//  Created by P.R.K on 10/24/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import Material
import SwiftyJSON
import Alamofire


class ProfilePicEditingViewController: UIViewController {

    var settingName = String()
    var profilePic = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.title = settingName

        // Do any additional setup after loading the view.
        prepareNavigationItem()
        profilePic = UIImageView(image:UIImage(named:"defaultProfile")!)
        profilePic.contentMode = .scaleAspectFit
        profilePic.setWidth( width : 200 )
        profilePic.setHeight( height: 200 )
        view.layout(profilePic).center()
        
        
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

extension ProfilePicEditingViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func getPhoto() {
        let camera = DSCameraHandler(delegate_: self)
        let optionMenu = UIAlertController(title: "Choose camera or photo library", message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { (alert : UIAlertAction!) in
            camera.getCameraOn(self, canEdit: true)
        }
        let sharePhoto = UIAlertAction(title: "Photo Library", style: .default) { (alert : UIAlertAction!) in
            camera.getPhotoLibraryOn(self, canEdit: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        optionMenu.addAction(takePhoto)
        optionMenu.addAction(sharePhoto)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        
        // image is our desired image
        profilePic.image = image
        
        
        let paramDict: [String: String] = [
            "fname": "test",
            "ftype": "png"
        ]
        
        let dataRequst = API.httpGet(url: Queries.User.photos, parameters: paramDict, requireAuthentication: true)
        dataRequst.responseJSON { response in
            print(response)
            let json = JSON(response.result.value)
            print(json["data"]["fields"]["signature"])
            
            self.uploadImage( s3Data:json["data"], url: json["url"].string! )
            
           
            
        }
        

        
        
        picker.dismiss(animated: true, completion: nil)
    }
}

fileprivate extension ProfilePicEditingViewController{
    
    func uploadImage(s3Data:JSON, url:String ){
        var param : Dictionary<String, Any>
        param = [:]
        for (key,value):(String, JSON) in s3Data["fields"] {
            param[key] = value.string
        }
        let imageData = UIImagePNGRepresentation(profilePic.image!)
        param["file"] = imageData
        
        print(param)
        
        var headers: HTTPHeaders = [:]
      
        let userToken: String? = API.getUserToken()
            if userToken == nil {
                // what should be the return value?
            }
            if let authorizationHeader = Request.authorizationHeader(user: userToken!, password: "foo") {
                headers[authorizationHeader.key] = authorizationHeader.value
            }
        headers["Content-Type"] = "png"
        
        let dataRequest = Alamofire.request(url, method: .post,parameters: param, headers: headers)
      
        dataRequest.response { response in
            print(response)
        }
        
        
    }
    
    
    func prepareNavigationItem() {

        let navigationBar = navigationController!.navigationBar
        navigationBar.tintColor = Constants.LightGreen
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Constants.LightGreen]
        
        
        let button = UIButton.init(type: .custom)
        //set image for button
        button.setImage(Icon.cm.add, for: UIControlState.normal)
        //add function for button
        button.addTarget(self, action: #selector(getPhoto), for: UIControlEvents.touchUpInside)
        //set frame
        button.frame = CGRect(x: 10, y: 10, width: 35, height: 35)
        
        let rightButton = UIBarButtonItem(customView: button)
        
        navigationItem.rightBarButtonItem = rightButton
    }
    
}

