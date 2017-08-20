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
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
