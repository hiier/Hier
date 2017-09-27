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

import Material



class LoginViewController: UIViewController {
    
    let URL_SIGNIN = "http://127.0.0.1:5000/login/"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
    }
    
    
    override func viewDidLoad() {
        
//     FACEBOOK LOGIN
//        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
//        loginButton.center = view.center
//        view.addSubview(loginButton)
        
        preparePasswordField()
        prepareEmailField()
        prepareResignResponderButton()
        
           }


    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var notif: UILabel!
    
    fileprivate var emailField: ErrorTextField!
    fileprivate var passwordField: TextField!
    /// A constant to layout the textFields.
    fileprivate let constant: CGFloat = 32
    

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
        
        self.notif.text = self.emailField.text! + self.passwordField.text!
        print("here" + self.emailField.text! + self.passwordField.text!)
        
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
                    defaults.set(user, forKey:"UserName")
                    
                    
                
                        //switching the screen
                    self.performSegue(withIdentifier:"welcome", sender: self)

                    }else{
                        //error message in case of invalid credential
                        self.notif.text = "Invalid username or password"
                    }
                
        }
  

        
        
        
    }
    
    
    
    /// Prepares the resign responder button.
    fileprivate func prepareResignResponderButton() {
        let btn = RaisedButton(title: "Resign", titleColor: Color.blue.base)
        btn.addTarget(self, action: #selector(handleResignResponderButton(button:)), for: .touchUpInside)
        
        view.layout(btn).width(100).height(constant).top(60).right(20)    }
    
    /// Handle the resign responder button.
    @objc
    internal func handleResignResponderButton(button: UIButton) {
        emailField?.resignFirstResponder()
        passwordField?.resignFirstResponder()
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


extension LoginViewController {
    fileprivate func prepareEmailField() {
        emailField = ErrorTextField()
        emailField.placeholder = "Email"
        emailField.detail = "Error, incorrect email"
        emailField.isClearIconButtonEnabled = true
        emailField.delegate = self
        emailField.isPlaceholderUppercasedWhenEditing = true
        emailField.placeholderAnimation = .hidden
        
        // Set the colors for the emailField, different from the defaults.
        //        emailField.placeholderNormalColor = Color.amber.darken4
        //        emailField.placeholderActiveColor = Color.pink.base
        //        emailField.dividerNormalColor = Color.cyan.base
        //        emailField.dividerActiveColor = Color.green.base
        // Set the text inset
        //        emailField.textInset = 20
        
        
//        let leftView = UIImageView()
//        leftView.image = Icon.cm.audio
//        emailField.leftView = leftView
        
        view.layout(emailField).center(offsetY: -passwordField.height - 60).left(20).right(20)
    }
    
    fileprivate func preparePasswordField() {
        passwordField = TextField()
        passwordField.placeholder = "Password"
        passwordField.detail = "At least 8 characters"
        passwordField.clearButtonMode = .whileEditing
        passwordField.isVisibilityIconButtonEnabled = true
        
        // Setting the visibilityIconButton color.
        passwordField.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(passwordField.isSecureTextEntry ? 0.38 : 0.54)
        
        view.layout(passwordField).center().left(20).right(20)
    }
}


extension LoginViewController: TextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as? ErrorTextField)?.isErrorRevealed = false
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = false
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = true
        return true
    }
}
