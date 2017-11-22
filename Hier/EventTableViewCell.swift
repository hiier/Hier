//
//  EventTableViewCell.swift
//  Hier
//
//  Created by Yang Zhao on 8/16/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    // MARK: Constants
    
    private static let IconSize: CGFloat = 16
    private static let PhotoSize: CGFloat = 100
    private static let TitleHeight: CGFloat = 20
    private static let DescriptionHeight: CGFloat = 56
    private static let SmallTextWidth: CGFloat = 32
    public static let CellHeight: CGFloat = EventTableViewCell.PhotoSize + 2 * Constants.DefaultMargin
    
    // MARK: - Outlets
    
    private var eventPhoto: UIImageView!
    
    private var eventTitle: UILabel!
    
    private var eventDescription: UILabel!
    
    private var eventNumLikes: UILabel!
    
    private var eventNumComments: UILabel!
    
    // MARK: - Properties
    
    public var event: Event! {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - View controller lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        eventPhoto = UIImageView(image: UIImage(named: Constants.DefaultPhoto))
        eventPhoto.layer.cornerRadius = Constants.CornerRadius
        eventPhoto.clipsToBounds = true
        
        eventTitle = Helpers.getLabel(text: nil, textColor: Constants.DetailedEventDefaultTextColor, font: Constants.DetailedEventTitltFont)
        
        eventDescription = Helpers.getLabel(text: nil, textColor: Constants.DetailedEventDefaultTextColor, font: Constants.DetailedEventDescriptionFont)
        eventDescription.numberOfLines = 0
        
        let like = Helpers.getIconAsImage(name: Constants.Like, size: EventTableViewCell.IconSize)
        
        eventNumLikes = Helpers.getLabel(text: nil, textColor: Constants.DetailedEventDefaultTextColor, font: Constants.DetailedEventAttributeFont)
        
        let comment = Helpers.getIconAsImage(name: Constants.Comment, size: EventTableViewCell.IconSize)
        
        eventNumComments = Helpers.getLabel(text: nil, textColor: Constants.DetailedEventDefaultTextColor, font: Constants.DetailedEventAttributeFont)
        
        contentView.addSubview(eventPhoto)
        contentView.addSubview(eventTitle)
        contentView.addSubview(eventDescription)
        contentView.addSubview(like)
        contentView.addSubview(eventNumLikes)
        contentView.addSubview(comment)
        contentView.addSubview(eventNumComments)
        eventPhoto.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top).offset(Constants.DefaultMargin)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Constants.DefaultMargin)
            make.width.equalTo(EventTableViewCell.PhotoSize)
            make.height.equalTo(EventTableViewCell.PhotoSize)
        }
        eventTitle.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(eventPhoto.snp.top)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.DefaultMargin)
            make.trailing.equalTo(eventPhoto.snp.leading).offset(-Constants.DefaultMargin)
            make.height.equalTo(EventTableViewCell.TitleHeight)
        }
        eventDescription.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(eventTitle.snp.bottom)
            make.leading.equalTo(eventTitle.snp.leading)
            make.trailing.equalTo(eventTitle.snp.trailing)
            make.height.equalTo(EventTableViewCell.DescriptionHeight)
        }
        like.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(eventDescription.snp.bottom).offset(Constants.DefaultMargin)
            make.leading.equalTo(eventDescription.snp.leading)
        }
        eventNumLikes.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(like.snp.top)
            make.leading.equalTo(like.snp.trailing).offset(Constants.DefaultMargin)
            make.bottom.equalTo(like.snp.bottom)
            make.width.equalTo(EventTableViewCell.SmallTextWidth)
        }
        comment.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(eventNumLikes.snp.top)
            make.leading.equalTo(eventNumLikes.snp.trailing).offset(Constants.DefaultMargin)
        }
        eventNumComments.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(comment.snp.top)
            make.leading.equalTo(comment.snp.trailing).offset(Constants.DefaultMargin)
            make.bottom.equalTo(comment.snp.bottom)
            make.width.equalTo(EventTableViewCell.SmallTextWidth)
        }
    }

    // MARK: - Custom methods
    
    private func updateUI() {
        eventTitle.text = event.title
        eventDescription.text = event.description
        eventNumLikes.text = "\(event.likes.count)"
        eventNumComments.text = "\(event.comments.count)"
    }
}
