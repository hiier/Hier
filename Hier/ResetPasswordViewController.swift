//
//  ResetPasswordViewController.swift
//  Hier
//
//  Created by P.R.K on 11/21/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Material

class ResetPasswordViewController: UIViewController {

    var settingName = String()
    
    fileprivate var passwordField: TextField!
    fileprivate var confirmPasswordField: TextField!
    fileprivate var lbl: UILabel!
    
    fileprivate let constant: CGFloat = 32
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = settingName
        
        preparePasswordField()
        prepareConfirmPasswordField()
        prepareResetResponderButton()
        prepareNotif()
        
    }

    /// Prepares the sign up responder button.
    fileprivate func prepareResetResponderButton() {
        let btn = RaisedButton(title: "Reset", titleColor: Color.cyan.base)
        btn.addTarget(self, action: #selector(reset(button:)), for: .touchUpInside)
        
        view.layout(btn).width(150).height(constant).center(offsetY: +passwordField.height + 100)
        
    }
    
    @objc
    internal func reset(button: UIButton){
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let isMatched = NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: passwordField.text)
        if(!isMatched){
            lbl.text = "The Password should contain at least an upperCase letter, a digit, or a speical character"
        }else if( passwordField.text != confirmPasswordField.text){
            lbl.text = "Please make sure you are entering same passwords!"
        }else{
//            //creating parameters for the post request
//            let parameters: Parameters=[
//                "email":emailField.text!,
//                "password":passwordField.text!
//            ]
//            
//            //Sending http post request
//            Alamofire.request(Queries.User.register , method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
//                //printing response
//                print(response)
//                
//                let statusCode = (response.response?.statusCode)
//                
//                if( statusCode == 201){
//                    //switching the screen
//                    self.performSegue(withIdentifier:"signup2signin", sender: self)
//                }else{
//                    //error message in case of invalid credential
//                    self.confirmPasswordField.detail = "Sorry, your sign up did not succeed. "
//                    self.confirmPasswordField.detailColor = Color.pink.base
//                }
//            }
        }
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

extension ResetPasswordViewController{
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


extension ResetPasswordViewController: TextFieldDelegate {
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

