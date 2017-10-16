//
//  ProfileSetting.swift
//  Hier
//
//  Created by P.R.K on 10/15/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import Material

class ProfileSetting: UIViewController {

    fileprivate var tableView: TableView!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.grey.lighten5
        
        prepareNavigationItem()
        prepareSwitch()
    }
    
    

}

extension ProfileSetting {
    
    fileprivate func prepareNavigationItem() {
        self.title = "Settings"
        
    }
    
    fileprivate func prepareSwitch() {
        let control = Switch(state: .off, style: .light, size: .medium)
        control.delegate = self
        
        view.layout(control).center()
    }
}

extension ProfileSetting: SwitchDelegate {
    func switchDidChangeState(control: Switch, state: SwitchState) {
        if(.on == state){
            
            self.present(LoginViewController(), animated: true, completion: nil)
        
        }
        
    }
}
