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
    
    fileprivate var emailField: ErrorTextField!
    fileprivate var passwordField: TextField!
    
    /// A constant to layout the textFields.
    fileprivate let constant: CGFloat = 32
    
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        // Initialize Tab Bar Item
//        tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
//    }

    override func viewDidLoad() {
        //FACEBOOK LOGIN
//        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
//        loginButton.center = view.center
//        
//        view.addSubview(loginButton)
        view.backgroundColor = .white
        preparePasswordField()
        prepareEmailField()
        prepareSignInResponderButton()
        prepareSignUpResponderButton()
   }

    /// Prepares the sign in responder button.
    fileprivate func prepareSignInResponderButton() {
        let btn = RaisedButton(title: "Sign In", titleColor: Color.cyan.base)
        btn.addTarget(self, action: #selector(signIn(button:)), for: .touchUpInside)
        
        view.layout(btn).width(150).height(constant).center(offsetY: +passwordField.height + 80)

    }
    
    /// Handle the sign in responder button.
    @objc
    internal func signIn(button: UIButton) {
        emailField?.resignFirstResponder()
        passwordField?.resignFirstResponder()
        
        let user = emailField.text!
        let psw = passwordField.text!
        
        var headers: HTTPHeaders = [:]
        if let authorizationHeader = Request.authorizationHeader(user: user, password: psw) {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        
        Alamofire.request(Queries.User.login, headers: headers).responseJSON{ response in
            //printing response
            print("request : \(String(describing:response.request))")
            print("Response String: \(String(describing:response.result.value))")
            print(response)
            print(response.response?.allHeaderFields)
            
            let statusCode = (response.response?.statusCode)
            
            if( statusCode == 200){
                
                let res_json = JSON(response.result.value)
                let token = res_json["token"].stringValue
                let userId = res_json["id"].stringValue
                
                let defaults = UserDefaults.standard
                defaults.set(token, forKey: "userToken")
                defaults.set(userId, forKey:"userId")
                //switching the screen
                self.performSegue(withIdentifier:"welcome", sender: self)
            }else{
                //error message in case of invalid credential
                self.passwordField.detail = "Invalid username or password"
                self.passwordField.detailColor = Color.pink.base
            }
        }
    }
    
    /// Prepares the sign up responder button.
    fileprivate func prepareSignUpResponderButton() {
        let btn_signup = RaisedButton(title: "Sign Up", titleColor: Color.lime.base)
        btn_signup.addTarget(self, action: #selector(signUp(button:)), for: .touchUpInside)
        
        view.layout(btn_signup).width(150).height(constant).center(offsetY: +passwordField.height + 80 + 40)
        
    }
    
    @objc
    internal func signUp(button: UIButton) {
        self.performSegue(withIdentifier:"signin2signup", sender: self)
    }

    
    
}


extension LoginViewController {
    func prepareEmailField() {
        emailField = ErrorTextField()
        emailField.placeholder = "Email"
        emailField.detail = "Error, incorrect email"
        emailField.isClearIconButtonEnabled = true
        emailField.delegate = self
        emailField.isPlaceholderUppercasedWhenEditing = true
        emailField.autocorrectionType = .no
        emailField.autocapitalizationType = .none;
        emailField.spellCheckingType = .no
//        emailField.placeholderAnimation = .hidden
        
        // Set the colors for the emailField, different from the defaults.
//        emailField.placeholderNormalColor = Color.amber.darken4
//        emailField.placeholderActiveColor = Color.pink.base
//        emailField.dividerNormalColor = Color.cyan.base
//        emailField.dividerActiveColor = Color.green.base
        emailField.dividerActiveColor = Color.cyan.base
        emailField.placeholderActiveColor = Color.pink.base
        
        // Set the text inset
        //        emailField.textInset = 20
        
        let leftView = UIImageView()
        leftView.image = Icon.email
        emailField.leftView = leftView
        
        emailField.leftViewActiveColor = Color.cyan.base
        
        view.layout(emailField).center(offsetY: -passwordField.height - 30).left(20).right(20)
    }
    
    fileprivate func preparePasswordField() {
        passwordField = TextField()
        passwordField.placeholder = "Password"
        passwordField.detail = "At least 8 characters"
        passwordField.clearButtonMode = .whileEditing
        passwordField.isVisibilityIconButtonEnabled = true
        passwordField.isPlaceholderUppercasedWhenEditing = true
        
        passwordField.dividerActiveColor = Color.cyan.base
        passwordField.placeholderActiveColor = Color.pink.base
        
        let leftView = UIImageView()
        leftView.image = Icon.cm.pen
        passwordField.leftView = leftView
        
        passwordField.leftViewActiveColor = Color.cyan.base
        
        // Setting the visibilityIconButton color.
        passwordField.visibilityIconButton?.tintColor = Color.cyan.base.withAlphaComponent(passwordField.isSecureTextEntry ? 0.38 : 0.54)
        
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

