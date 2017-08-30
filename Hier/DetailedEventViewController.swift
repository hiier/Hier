//
//  DetailedEventViewController.swift
//  Hier
//
//  Created by Yang Zhao on 8/19/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit

class DetailedEventViewController: UIViewController {
    
    @IBOutlet weak var eventTitle: UILabel!
    
    
    var event: Event? {
        didSet {
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        if let unwrappedEvent = event {
            eventTitle?.text = unwrappedEvent.title
        }
    }
}
