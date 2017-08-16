//
//  MainEventsTableViewController.swift
//  Hier
//
//  Created by P.R.K on 7/18/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MaterialComponents.MaterialCollections

class MainEventsTableViewController: UITableViewController {
    //MARK: Properties
    var allevents = [Event]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(tabBarSystemItem:.bookmarks, tag: 0)
    }


    
    //MARK: Private Methods
    private func loadEvents() {
        
        
        
        Alamofire.request("http://127.0.0.1:5000/events", method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let valueArray = (value as! NSArray) as Array
                
                for eventvalue in valueArray{
                    var thestring = eventvalue as! String
                    if let dataFromString = thestring.data(using: .utf8){
                        var eventJson = JSON(data: dataFromString)
                        if let evt = Event(name: eventJson["title"].stringValue, description: eventJson["description"].stringValue, time: eventJson["time"]["$date"].stringValue, location: eventJson["location"]["coordinates"].stringValue)  {
                                self.allevents.append(evt)
                            }
                        
                        
                    } else{
                        fatalError("Unable to instantiate event")
                    
                    }
                    
                    
                }
                
              
            case .failure(let error):
                print(error)
            }

            self.tableView.reloadData()
        }
       
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        loadEvents()


    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return allevents.count
       
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "GeneralTableViewCell"
        
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? GeneralTableViewCell else{
            fatalError("The dequeued cell is not an instance of GeneralTableViewCell.")
        }

        let event = self.allevents[indexPath.row]
        
        print(event.name + event.description + event.time + event.location)
        
        cell.eventName.text = event.name
        

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
