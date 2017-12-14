//
//  ForgetPassword.swift
//  Hier
//
//  Created by P.R.K on 12/5/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import Material

class ForgetPasswordViewController: UIViewController {
    
    fileprivate var emailField: ErrorTextField!
    fileprivate var logo: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Forget Password"
        
        prepareEmailField()
        prepareLogo()
        prepareResetResponderButton()
        // Do any additional setup after loading the view.
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
    
    fileprivate func prepareResetResponderButton() {
        let btn = RaisedButton(title: "Reset Password", titleColor: Constants.Orange)
        btn.addTarget(self, action: #selector(sendReset(button:)), for: .touchUpInside)
        
        view.layout(btn).width(150).height(32).center(offsetY: 80)
        
    }
    
    @objc
    internal func sendReset(button: UIButton){
        //TODO: call password reset API
    }
    
}

extension ForgetPasswordViewController {
    func prepareLogo() {
        logo = UIImageView(frame:CGRect(x:128, y:90, width:64, height:64))
        logo.image = UIImage(named:"Hier")
        view.addSubview(logo)
        
        
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

        emailField.dividerActiveColor = Constants.LightBlue
        emailField.placeholderActiveColor = Color.pink.base
        
        let leftView = UIImageView()
        leftView.image = Icon.email
        emailField.leftView = leftView
        
        emailField.leftViewActiveColor = Constants.LightBlue
        
        view.layout(emailField).center().left(20).right(20)
    }
    
}

extension  ForgetPasswordViewController: TextFieldDelegate {
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

