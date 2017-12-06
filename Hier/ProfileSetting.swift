//
//  ProfileSetting.swift
//  Hier
//
//  Created by P.R.K on 10/15/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import Material

class ProfileSetting: UITableViewController {

//    fileprivate var tableView: TableView!

    var names = [" ":["Log Out"], "Profile":["Profile Photo", "Reset Password"] ]
    var sectionNames = ["Profile", " "]
    
    struct Objects {
        
        var sectionName : String!
        var sectionObjects : [String]!
    }
    
    var objectArray = [Objects]()
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.grey.lighten5
        
        prepareNavigationItem()
        prepareSwitch()
        
//        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.register(cell.self )
        
        for key in sectionNames {
            let values = names[key]
            objectArray.append(Objects(sectionName: key, sectionObjects: values))
            
        }
        
        tableView.tableFooterView = UIView()
    }
    

    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return objectArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray[section].sectionObjects.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        // Configure the cell...
        cell.textLabel?.text = objectArray[indexPath.section].sectionObjects[indexPath.row]
        if(cell.textLabel?.text == "Log Out"){
            cell.textLabel?.textAlignment =  .center
            cell.textLabel?.textColor =  Color.deepOrange.base
            
            
        }else if(cell.textLabel?.text == "Profile Photo")
        {
            let sidePic = UIImageView(image:UIImage(named:"defaultProfile")!)
            sidePic.setWidth(width:60);
            sidePic.setHeight(height:60);
            sidePic.layer.cornerRadius = Constants.CornerRadius
            sidePic.clipsToBounds = true
            cell.accessoryView = sidePic;
            
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            
        }
        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return objectArray[section].sectionName
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("button pressed")
        print(objectArray[indexPath.section].sectionObjects[indexPath.row])

        
        let settingName = objectArray[indexPath.section].sectionObjects[indexPath.row]
        
        if(settingName == "Log Out"){
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "userToken")
            defaults.synchronize()
                        
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            vc.tabBarItem = UITabBarItem(title
                    :"Profile", image:UIImage(named:"profile"), tag:1 )
            self.navigationController?.setViewControllers([vc], animated: false)
            

        }
        else if(settingName == "Profile Photo"){
            
            let vc = ProfilePicEditingViewController()
            vc.settingName  = settingName
            self.navigationController?.pushViewController(vc, animated:true)
        }
        else if(settingName == "Reset Password")
        {
            let vc = ResetPasswordViewController()
            vc.settingName  = settingName
            self.navigationController?.pushViewController(vc, animated:true)
        }
        else{
            let vc = DetailSettingViewController()
            vc.settingName  = settingName
            self.navigationController?.pushViewController(vc, animated:true)
        }
    }
    
    
    
      override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat  {
        let section = indexPath.section
        let row = indexPath.row
        if section == 0 && row == 0{
            return 85.0
        }
        return 40.0
    }
    
    
//    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if  segue.identifier == detailSettingSegueIdentifier,
//            let destination = segue.destination as? DetailSettingViewController,
//            let indexPath = self.tableView.indexPathForSelectedRow
//           
//        {
//            destination.settingName = objectArray[indexPath.section].sectionObjects[indexPath.row]
//        }
//    }

}

extension ProfileSetting {
    
    fileprivate func prepareNavigationItem() {
        self.title = "Settings"
        
    }
    
    fileprivate func prepareSwitch() {
        let control = Switch(state: .off, style: .light, size: .medium)
        control.delegate = self
        
        view.layout(control).center(offsetY: +150)
    }
}

extension ProfileSetting: SwitchDelegate {
    func switchDidChangeState(control: Switch, state: SwitchState) {
        if(.on == state){
            self.navigationController?.setViewControllers([LoginViewController()], animated: false)
//            self.present(LoginViewController(), animated: true, completion: nil)
        
        }
        
    }
}
