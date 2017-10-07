//
//  DetailedEventTableViewController.swift
//  Hier
//
//  Created by Yang Zhao on 9/20/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import MapKit
import ReadMoreTextView

class DetailedEventTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var eventTitle: UILabel!
    
    @IBOutlet weak var eventDescription: UILabel!
    
    @IBOutlet weak var eventPhoto: UIImageView!
    
    @IBOutlet weak var eventTime: UILabel!
    
    @IBOutlet weak var eventLocation: UILabel!
    
    @IBOutlet weak var eventNumLikes: UILabel!
    
    @IBOutlet weak var eventNumComments: UILabel!
    
    @IBOutlet weak var eventJoinButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func like(_ sender: UIButton) {
    }
    
    @IBAction func comment(_ sender: UIButton) {
    }
    
    @IBAction func join(_ sender: UIButton) {
    }
    
    // MARK: - Properties
    
    var event: Event!
    var dataMgr: DataMgr = DataMgr.getSingletonInstance()
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
        eventTitle.text = event.title
        
        eventDescription.text = event.description ?? "There's no description yet."
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        eventTime.text = dateFormatter.string(from: event.time)
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(event.location) { (placemarks, error) in
            if let placemark = placemarks?.first {
                self.eventLocation.text = Helpers.parseAddress(selectedItem: placemark)
            }
        }
        
        eventNumLikes.text = "\(event.likes.count)"
        eventNumComments.text = "\(event.comments.count)"
        
        if let maxNumParticipants = event.maxNumParticipants {
            if event.participants.count >= maxNumParticipants {
                eventJoinButton.isEnabled = false
                eventJoinButton.alpha = 0.5
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
