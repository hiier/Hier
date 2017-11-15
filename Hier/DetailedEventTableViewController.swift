//
//  DetailedEventTableViewController.swift
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
    
    static let TitltFont = UIFont(descriptor: UIFontDescriptor(fontAttributes: [
        UIFontDescriptorNameAttribute: "Avenir Next",
        UIFontDescriptorTraitsAttribute: [UIFontWeightTrait: UIFontWeightBold]
        ]), size: 18)
    static let AttributeFont = UIFont(descriptor: UIFontDescriptor(fontAttributes: [
        UIFontDescriptorNameAttribute: "Avenir Next",
        UIFontDescriptorTraitsAttribute: [UIFontWeightTrait: UIFontWeightRegular]
        ]), size: 16)
    static let DescriptionFont = UIFont(descriptor: UIFontDescriptor(fontAttributes: [
        UIFontDescriptorNameAttribute: "Avenir Next",
        UIFontDescriptorTraitsAttribute: [UIFontWeightTrait: UIFontWeightRegular]
        ]), size: 14)

    static let DefaultTextColor = UIColor(red: 0/255, green: 75/255, blue: 102/255, alpha: 1.0)
    
    // MARK: - Properties
    
    public var event: Event!
    
    private var cells: [[UITableViewCell]] = [
        [UITableViewCell(), UITableViewCell(), UITableViewCell()]
    ]
    
    private let eventPhoto: UIImageView = {
        let image = UIImageView(image: UIImage(named: "defaultPhoto"))
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let eventTitle: UILabel = {
        let label = UILabel()
        label.textColor = DetailedEventTableViewController.DefaultTextColor
        label.font = DetailedEventTableViewController.TitltFont
        return label
    }()
    
    private let calendar: UIImageView = {
        let image = UIImageView(image: UIImage(named: "calendar"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let eventTime: UILabel = {
        let label = UILabel()
        label.textColor = DetailedEventTableViewController.DefaultTextColor
        label.font = DetailedEventTableViewController.AttributeFont
        return label
    }()
    
    private let pin: UIImageView = {
        let image = UIImageView(image: UIImage(named: "pin"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let eventLocation: UILabel = {
        let label = UILabel()
        label.textColor = DetailedEventTableViewController.DefaultTextColor
        label.font = DetailedEventTableViewController.AttributeFont
        return label
    }()
    
    private let eventDescription: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = DetailedEventTableViewController.DescriptionFont
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let like: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "like"), for: .normal)
        button.isUserInteractionEnabled = true
        return button

    }()
    
    private let eventNumLikes: UILabel = {
        let label = UILabel()
        label.textColor = DetailedEventTableViewController.DefaultTextColor
        label.font = DetailedEventTableViewController.AttributeFont
        return label
    }()
    
    private let comment: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "comment"), for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private let eventNumComments: UILabel = {
        let label = UILabel()
        label.textColor = DetailedEventTableViewController.DefaultTextColor
        label.font = DetailedEventTableViewController.AttributeFont
        return label
    }()
    
    private let joinEvent: UIButton = {
        let button = UIButton()
        button.setTitle("I'm going", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constants.ThemeColor
        button.isUserInteractionEnabled = true
        return button
    }()

    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set title
        title = "Event"
        
        // Set first cell content and constraints
        let firstCell = cells[0][0]
        firstCell.selectionStyle = .none
        
        eventTitle.text = event.title
        firstCell.addSubview(eventTitle)
        eventTitle.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(firstCell.contentView).offset(8)
            make.trailing.equalTo(firstCell.contentView).offset(8)
            make.top.equalTo(firstCell.contentView).offset(8)
        }
        
        firstCell.addSubview(calendar)
        calendar.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(firstCell.contentView).offset(8)
            make.top.equalTo(eventTitle.snp.bottom).offset(8)
            make.width.equalTo(28)
            make.height.equalTo(28)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        eventTime.text = dateFormatter.string(from: event.time)
        firstCell.addSubview(eventTime)
        eventTime.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(calendar.snp.trailing).offset(8)
            make.trailing.equalTo(firstCell.contentView).offset(-8)
            make.top.equalTo(calendar.snp.top)
        }
        
        firstCell.addSubview(pin)
        pin.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(firstCell.contentView).offset(8)
            make.top.equalTo(calendar.snp.bottom).offset(8)
            make.width.equalTo(28)
            make.height.equalTo(28)
        }
        
        eventLocation.text = "Location"
        firstCell.addSubview(eventLocation)
        eventLocation.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(pin.snp.trailing).offset(8)
            make.trailing.equalTo(firstCell.contentView).offset(-8)
            make.top.equalTo(pin.snp.top)
        }
        
        // Set second cell content and constraints
        let secondCell = cells[0][1]
        secondCell.selectionStyle = .none
        
        eventDescription.text = event.description
        secondCell.addSubview(eventDescription)
        eventDescription.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(secondCell.contentView).offset(8)
            make.trailing.equalTo(secondCell.contentView).offset(-8)
            make.top.equalTo(secondCell.contentView).offset(8)
            make.bottom.equalTo(secondCell.contentView).offset(-8)
        }
        
        // Set third cell content and constraints
        let thirdCell = cells[0][2]
        thirdCell.selectionStyle = .none
        
        thirdCell.addSubview(like)
        like.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(thirdCell.contentView).offset(8)
            make.top.equalTo(thirdCell.contentView).offset(8)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        eventNumLikes.text = "\(event.likes.count)"
        thirdCell.addSubview(eventNumLikes)
        eventNumLikes.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(like.snp.trailing).offset(8)
            make.top.equalTo(like.snp.top)
            make.bottom.equalTo(like.snp.bottom)
            make.width.equalTo(40)
        }
        
        thirdCell.addSubview(comment)
        comment.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(eventNumLikes.snp.trailing).offset(8)
            make.top.equalTo(eventNumLikes.snp.top)
            make.bottom.equalTo(eventNumLikes.snp.bottom)
            make.width.equalTo(24)
        }
        
        eventNumComments.text = "\(event.comments.count)"
        thirdCell.addSubview(eventNumComments)
        eventNumComments.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(comment.snp.trailing).offset(8)
            make.top.equalTo(comment.snp.top)
            make.bottom.equalTo(comment.snp.bottom)
            make.width.equalTo(40)
        }
        
        // Set separator style
        tableView.separatorColor = Constants.ThemeColor
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
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
                return 116
            case 1:
                return 160
            case 2:
                return 44
            default:
                return 0
            }
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return eventPhoto
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 180
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return joinEvent
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 44
        default:
            return 0
        }
    }
}
