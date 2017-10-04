//
//  ViewController.swift
//  Hier
//
//  Created by P.R.K on 6/20/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import Alamofire
import SwiftLocation
import SwiftyJSON
import Material

class SignupViewController: UIViewController{
    
    fileprivate var emailField: ErrorTextField!
    fileprivate var passwordField: TextField!
    fileprivate var confirmPasswordField: TextField!
    fileprivate var lbl: UILabel!
    
    /// A constant to layout the textFields.
    fileprivate let constant: CGFloat = 32

    override func viewDidLoad() {
        super.viewDidLoad()
        //trackLocation()
        
        preparePasswordField()
        prepareEmailField()
        prepareConfirmPasswordField()
        prepareSignUpResponderButton()
        prepareNotif()
        
    }
    
    
    /// Prepares the sign up responder button.
    fileprivate func prepareSignUpResponderButton() {
        let btn = RaisedButton(title: "Sign Up", titleColor: Color.cyan.base)
        btn.addTarget(self, action: #selector(signUp(button:)), for: .touchUpInside)
        
        view.layout(btn).width(150).height(constant).center(offsetY: +passwordField.height + 100)
        
    }
    
    @objc
    internal func signUp(button: UIButton){
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let isMatched = NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: passwordField.text)
        if(!isMatched){
            lbl.text = "The Password should contain at least an upperCase letter, a digit, or a speical character"
        }else if( passwordField.text != confirmPasswordField.text){
            lbl.text = "Please make sure you are entering same passwords!"
        }else{
            //creating parameters for the post request
            let parameters: Parameters=[
                "email":emailField.text!,
                "password":passwordField.text!
            ]
            
            //Sending http post request
            Alamofire.request(Queries.User.register , method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                //printing response
                print(response)
                
                let statusCode = (response.response?.statusCode)
                
                if( statusCode == 200){
                    //switching the screen
                    self.performSegue(withIdentifier:"signup2signin", sender: self)
                }else{
                    //error message in case of invalid credential
                    self.confirmPasswordField.detail = "Sorry, your sign up did not succeed. "
                    self.confirmPasswordField.detailColor = Color.pink.base
                }
            }
        }
    }
    
    func trackLocation(){
        Location.getLocation(accuracy: .city, frequency: .continuous, success: { (_, location) in
            print("A new update of location is available: \(location)")
        }) { (request, last, error) in
            request.cancel() // stop continous location monitoring on error
            print("Location monitoring failed due to an error \(error)")
        }

        Alamofire.request(Queries.User.events).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result

            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }

            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
}



extension SignupViewController {
    
    func prepareNotif(){
        lbl = UILabel()
//        lbl.backgroundColor = UIColor.blue
        lbl.text = ""
        lbl.textColor = UIColor.black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        lbl.font = lbl.font.withSize(12)
        
        view.layout(lbl).center(offsetY: passwordField.height + 165)
      
        let widthConstraint = NSLayoutConstraint(item: lbl, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 200)
        let heightConstraint = NSLayoutConstraint(item: lbl, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 90)
        var constraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[superview]-(<=1)-[label]",
            options: NSLayoutFormatOptions.alignAllCenterX,
            metrics: nil,
            views: ["superview":view, "label":lbl])
        
        view.addConstraints(constraints)
        
//        // Center vertically
//        constraints = NSLayoutConstraint.constraints(
//            withVisualFormat: "H:[superview]-(<=1)-[label]",
//            options: NSLayoutFormatOptions.alignAllCenterY,
//            metrics: nil,
//            views: ["superview":view, "label":lbl])
//        
//        view.addConstraints(constraints)
        view.addConstraints([ widthConstraint, heightConstraint])
    }
    
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
        
        view.layout(emailField).center(offsetY: -passwordField.height - 60).left(20).right(20)
    }
    
    fileprivate func preparePasswordField() {
        passwordField = TextField()
        passwordField.placeholder = "Password"
        passwordField.detail = "at least an upperCase letter, a digit, or a speical character"
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
        
        view.layout(passwordField).center(offsetY: -30).left(20).right(20)
    }
    
    fileprivate func prepareConfirmPasswordField() {
        confirmPasswordField = TextField()
        confirmPasswordField.placeholder = "Confirm Password"
        confirmPasswordField.detail = ""
        confirmPasswordField.clearButtonMode = .whileEditing
        confirmPasswordField.isVisibilityIconButtonEnabled = true
        confirmPasswordField.isPlaceholderUppercasedWhenEditing = true
        
        confirmPasswordField.dividerActiveColor = Color.cyan.base
        confirmPasswordField.placeholderActiveColor = Color.pink.base
        
        let leftView = UIImageView()
        leftView.image = Icon.cm.pen
        confirmPasswordField.leftView = leftView
        
        confirmPasswordField.leftViewActiveColor = Color.cyan.base
        
        // Setting the visibilityIconButton color.
        confirmPasswordField.visibilityIconButton?.tintColor = Color.cyan.base.withAlphaComponent(passwordField.isSecureTextEntry ? 0.38 : 0.54)
        
        view.layout(confirmPasswordField).center(offsetY: +passwordField.height + 30).left(20).right(20)
    }
    
}


extension SignupViewController: TextFieldDelegate {
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



