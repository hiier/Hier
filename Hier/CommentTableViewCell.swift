//
//  swift
//  Hier
//
//  Created by Yang Zhao on 11/22/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    private let PhotoSize: CGFloat = 36
    private let MaxCommentLines: Int = 10
    private let NameFont = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
    private let ContentFont = UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)

    
    // MARK: - Outlets
    
    private var userPhoto: UIImageView!
    private var userName: UILabel!
    private var userComment: UILabel!
    
    // MARK: - Properties

    public var comment: Comment! {
        didSet {
            updateOutlets()
        }
    }
    
    // MARK: - Initializer
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        userPhoto = UIImageView(image: UIImage(named: Constants.Profile))
        userPhoto.contentMode = .scaleAspectFill
        userPhoto.clipsToBounds = true
        userPhoto.layer.cornerRadius = Constants.CornerRadius
        
        userName = Helpers.getLabel(text: "Name", textColor: .black, font: NameFont)
        userName.numberOfLines = 1
        
        userComment = Helpers.getLabel(text: "Comment", textColor: .black, font: ContentFont)
        userComment.numberOfLines = MaxCommentLines
        
        contentView.addSubview(userPhoto)
        contentView.addSubview(userName)
        contentView.addSubview(userComment)
        userPhoto.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top).offset(Constants.DefaultMargin)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.DefaultMargin)
            make.width.equalTo(PhotoSize)
            make.height.equalTo(PhotoSize)
        }
        userName.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(userPhoto.snp.top)
            make.leading.equalTo(userPhoto.snp.trailing).offset(Constants.DefaultMargin)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Constants.DefaultMargin)
        }
        userComment.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(userName.snp.bottom).offset(Constants.DefaultMargin)
            make.leading.equalTo(userName.snp.leading)
            make.bottom.equalTo(contentView.snp.bottom).offset(-Constants.DefaultMargin)
            make.trailing.equalTo(userName.snp.trailing)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func updateOutlets() {
        if let photo = comment.user.photo {
            userPhoto.image = UIImage(data: photo)
        }
        userName.text = comment.user.username
        userComment.text = comment.content
    }
}
