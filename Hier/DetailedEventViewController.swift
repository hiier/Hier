//
//  DetailedEventViewController.swift
//  Hier
//
//  Created by Yang Zhao on 8/19/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit

class DetailedEventViewController: UIViewController {
    
    var event: Event? {
        didSet {
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func updateUI() {
        
    }
}
