//
//  Helpers.swift
//  Hier
//
//  Created by Yang Zhao on 10/17/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class Helpers {
    public static func parseAddress(selectedItem: MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
    
    public static func layoutSingleOutlet(outlet: UIView, cell: UITableViewCell, inset: UIEdgeInsets) {
        cell.contentView.addSubview(outlet)
        outlet.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(cell).inset(inset)
        }
    }
    
    public static func layoutIconAndField(iconName: String, iconSize: CGFloat, field: UIView, cell: UITableViewCell) {
        let icon = getIconAsImage(name: iconName, size: iconSize)
        cell.contentView.addSubview(icon)
        cell.contentView.addSubview(field)
        icon.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(cell.contentView.snp.leading).offset(16)
            make.top.equalTo(cell.contentView.snp.top).offset(8)
        }
        field.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(icon.snp.trailing).offset(8)
            make.top.equalTo(icon.snp.top)
            make.bottom.equalTo(icon.snp.bottom)
            make.trailing.equalTo(cell.contentView.snp.trailing).offset(-8)
        }
    }
    
    public static func getIconAsImage(name: String, size: CGFloat) -> UIImageView {
        let icon = UIImageView(image: UIImage(named: name))
        icon.contentMode = .scaleAspectFit
        icon.clipsToBounds = true
        icon.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(size)
            make.height.equalTo(size)
        }
        return icon
    }
    
    public static func getIconAsButton(name: String, size: CGFloat) -> UIButton {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: name), for: .normal)
        button.isUserInteractionEnabled = true
        button.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(size)
            make.height.equalTo(size)
        }
        return button
    }
    
    public static func getLabel(text: String?, textColor: UIColor?, font: UIFont?) -> UILabel {
        let label = UILabel()
        if let labelText = text {
            label.text = labelText
        }
        if let labelTextColor = textColor {
            label.textColor = labelTextColor
        }
        if let labelFont = font {
            label.font = labelFont
        }
        return label
    }
}
