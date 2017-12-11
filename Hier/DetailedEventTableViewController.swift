//
//  swift
//  Hier
//
//  Created by Yang Zhao on 9/11/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import SnapKit
import MapKit

class DetailedEventTableViewController: UITableViewController {
    
    // MARK: - Constants
    
    private let PhotoAspectRatio: CGFloat = 1.0 / 3.0
    private let LargeIconSize: CGFloat = 28
    private let SmallIconSize: CGFloat = 24
    private let SmallTextWidth: CGFloat = 40
    
    // MARK: - Outlets
    
    private var eventPhoto: UIImageView!
    private var eventTitle: UILabel!
    private var eventTime: UILabel!
    private var eventLocation: UILabel!
    private var eventDescription: UILabel!
    private var eventLikeButton: UIButton!
    private var eventNumLikes: UILabel!
    private var eventCommentButton: UIButton!
    private var eventNumComments: UILabel!
    private var eventJoinButton: UIButton!
    
    // MARK: - Properties
    
    public var event: Event!
    
    private var cells: [[UITableViewCell]] = [
        [UITableViewCell(), UITableViewCell(), UITableViewCell(), UITableViewCell()]
    ]
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set title
        title = "Event"
        
        /* Set 1st cell ************************/
        
        // Set event photo
        eventPhoto = UIImageView(image: UIImage(named: Constants.DefaultPhoto))
        eventPhoto.contentMode = .scaleAspectFill
        eventPhoto.clipsToBounds = true
        
        Helpers.layoutSingleOutlet(outlet: eventPhoto, cell: cells[0][0], inset: UIEdgeInsetsMake(0, 0, 0, 0))
        
        /* Set 2nd cell ************************/
        
        // Set event title
        eventTitle = Helpers.getLabel(text: event.title, textColor: Constants.DetailedEventDefaultTextColor, font: Constants.DetailedEventTitltFont)
        
        // Set calendar icon
        let calendar = Helpers.getIconAsImage(name: Constants.Calendar, size: LargeIconSize)
        
        // Set event time
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        eventTime = Helpers.getLabel(text: dateFormatter.string(from: event.time), textColor: Constants.DetailedEventDefaultTextColor, font: Constants.DetailedEventAttributeFont)
        
        // Set pin icon
        let pin = Helpers.getIconAsImage(name: Constants.Pin, size: LargeIconSize)
        
        // Set event location
        eventLocation = Helpers.getLabel(text: "Location", textColor: Constants.DetailedEventDefaultTextColor, font: Constants.DetailedEventAttributeFont)
        
        let secondCell = cells[0][1]
        secondCell.addSubview(eventTitle)
        secondCell.addSubview(calendar)
        secondCell.addSubview(eventTime)
        secondCell.addSubview(pin)
        secondCell.addSubview(eventLocation)
        eventTitle.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(secondCell.contentView).offset(Constants.DefaultMargin)
            make.trailing.equalTo(secondCell.contentView).offset(Constants.DefaultMargin)
            make.top.equalTo(secondCell.contentView).offset(Constants.DefaultMargin)
        }
        calendar.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(secondCell.contentView).offset(Constants.DefaultMargin)
            make.top.equalTo(eventTitle.snp.bottom).offset(Constants.DefaultMargin)
        }
        eventTime.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(calendar.snp.trailing).offset(Constants.DefaultMargin)
            make.trailing.equalTo(secondCell.contentView).offset(-Constants.DefaultMargin)
            make.top.equalTo(calendar.snp.top)
        }
        pin.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(secondCell.contentView).offset(Constants.DefaultMargin)
            make.top.equalTo(calendar.snp.bottom).offset(Constants.DefaultMargin)
        }
        eventLocation.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(pin.snp.trailing).offset(Constants.DefaultMargin)
            make.trailing.equalTo(secondCell.contentView).offset(-Constants.DefaultMargin)
            make.top.equalTo(pin.snp.top)
        }
        
        /* Set 3rd cell ************************/
        
        // Set event description
        eventDescription = Helpers.getLabel(text: event.description, textColor: Constants.DetailedEventDefaultTextColor, font: Constants.DetailedEventDescriptionFont)
        eventDescription.numberOfLines = 0
        eventDescription.lineBreakMode = .byWordWrapping
        eventDescription.sizeToFit()
        
        Helpers.layoutSingleOutlet(outlet: eventDescription, cell: cells[0][2], inset: UIEdgeInsetsMake(Constants.DefaultMargin, Constants.DefaultMargin, -Constants.DefaultMargin, -Constants.DefaultMargin))
        
        /* Set 4th cell ************************/
        
        // Set like button
        eventLikeButton = Helpers.getIconAsButton(name: Constants.Like, size: SmallIconSize)
        eventLikeButton.addTarget(self, action: #selector(like), for: .touchUpInside)
        
        // Set event #likes
        eventNumLikes = Helpers.getLabel(text: "\(event.likes.count)", textColor: Constants.DetailedEventDefaultTextColor, font: Constants.DetailedEventAttributeFont)
        
        // Set comment button
        eventCommentButton = Helpers.getIconAsButton(name: Constants.Comment, size: SmallIconSize)
        eventCommentButton.addTarget(self, action: #selector(comment), for: .touchUpInside)
        
        // Set event #comments
        eventNumComments = Helpers.getLabel(text: "\(event.comments.count)", textColor: Constants.DetailedEventDefaultTextColor, font: Constants.DetailedEventAttributeFont)
        
        let fourthCell = cells[0][3]
        fourthCell.addSubview(eventLikeButton)
        fourthCell.addSubview(eventNumLikes)
        fourthCell.addSubview(eventCommentButton)
        fourthCell.addSubview(eventNumComments)
        eventLikeButton.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(fourthCell.contentView).offset(Constants.DefaultMargin)
            make.top.equalTo(fourthCell.contentView).offset(Constants.DefaultMargin)
        }
        eventNumLikes.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(eventLikeButton.snp.trailing).offset(Constants.DefaultMargin)
            make.top.equalTo(eventLikeButton.snp.top)
            make.bottom.equalTo(eventLikeButton.snp.bottom)
            make.width.equalTo(SmallTextWidth)
        }
        eventCommentButton.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(eventNumLikes.snp.trailing).offset(Constants.DefaultMargin)
            make.top.equalTo(eventNumLikes.snp.top)
        }
        eventNumComments.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(eventCommentButton.snp.trailing).offset(Constants.DefaultMargin)
            make.top.equalTo(eventCommentButton.snp.top)
            make.bottom.equalTo(eventCommentButton.snp.bottom)
            make.width.equalTo(SmallTextWidth)
        }
        
        // Set join button
        eventJoinButton = UIButton()
        eventJoinButton.setTitle("I'm going", for: .normal)
        eventJoinButton.setTitleColor(.white, for: .normal)
        eventJoinButton.backgroundColor = Constants.ThemeColor
        eventJoinButton.isUserInteractionEnabled = true
        eventJoinButton.addTarget(self, action: #selector(join), for: .touchUpInside)
        
        // Set others
        for row in cells {
            for cell in row {
                cell.selectionStyle = .none
            }
        }
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tableView.separatorColor = Constants.ThemeColor
        tableView.separatorInset = UIEdgeInsets(top: 0, left: Constants.DefaultMargin, bottom: 0, right: Constants.DefaultMargin)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.section][indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return (tableView.width * PhotoAspectRatio)
            case 1:
                return 3 * LargeIconSize + 4 * Constants.DefaultMargin
            case 2:
                return UITableViewAutomaticDimension
            case 3:
                return Constants.DefaultTableViewCellHeight
            default:
                return 0
            }
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return eventJoinButton
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return Constants.DefaultTableViewCellHeight
        default:
            return 0
        }
    }
    
    // MARK: - Methods
    
    func like() {
        eventLikeButton.setBackgroundImage(UIImage(named: Constants.Liked), for: .normal)
    }
    
    func comment() {
//        if let ctvc = storyboard?.instantiateViewController(withIdentifier: "commentsTableViewController") as? CommentsTableViewController {
//            ctvc.comments = event.comments
//            navigationController?.pushViewController(ctvc, animated: true)
//        }
        let cvc = CommentsViewController()
        cvc.comments = event.comments
        navigationController?.pushViewController(cvc, animated: true)
    }
    
    func join() {
        navigationController?.popViewController(animated: true)
    }
}
