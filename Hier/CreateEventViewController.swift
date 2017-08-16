//
//  CreateEventViewController.swift
//  Hier
//
//  Created by P.R.K on 8/9/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import ImageRow
import Eureka



class CreateEventViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("Event")
            <<< TextRow(){ row in
                row.title = "Event"
                row.placeholder = "Title"
            }
            <<< ImageRow() {
                $0.title = "Picture"
                $0.sourceTypes = [.PhotoLibrary, .SavedPhotosAlbum]
                $0.clearAction = .yes(style: .default)
            }
        
            +++ Section("Details")
            
            <<< DateTimeRow(){
                $0.title = "Time"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
            <<< TextRow(){ row in
                row.title = "Description"
                row.placeholder = "More info"
            }
            <<< LocationRow() {
                $0.title = "Location"
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
