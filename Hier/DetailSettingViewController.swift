//
//  DetailSettingViewController.swift
//  Hier
//
//  Created by P.R.K on 10/17/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit

class DetailSettingViewController: UIViewController {
    
    var settingName = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = settingName

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

}
