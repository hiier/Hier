//
//  CommentTableViewCell.swift
//  Hier
//
//  Created by Yang Zhao on 9/26/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var userPhoto: UIImageView!
    
    @IBOutlet weak var userComment: UILabel!
    
    // MARK: - Properties
    
    var comment: Comment! {
        didSet {
            if let photo = comment.user.photo {
                userPhoto.image = UIImage(data: photo)
            }
            userComment.text = comment.content
        }
    }
}
