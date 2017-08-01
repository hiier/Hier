//
//  GeneralTableViewCell.swift
//  Hier
//
//  Created by P.R.K on 7/18/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import Alamofire

class GeneralTableViewCell: UITableViewCell {
    
    
    //MARK: Properties
    @IBOutlet weak var eventName: UILabel!

    @IBOutlet weak var eventPhoto: UIImageView!
    
    @IBOutlet weak var rating: RatingControl!
    
    var allevents = [Event]()
    

    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
