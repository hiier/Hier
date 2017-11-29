//
//  Constants.swift
//  Hier
//
//  Created by Yang Zhao on 8/19/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let LightGreen = UIColor(red: 112/255, green: 192/255, blue: 178/255, alpha: 1.0)
    static let Orange = UIColor(red: 255/255, green: 180/255, blue: 0/255, alpha: 1.0)
    static let LightBlue = UIColor(red: 112/255, green: 192/255, blue: 178/255, alpha: 1.0)
    static let PlaceholderColor = UIColor(red: 199/255, green: 199/255, blue: 205/255, alpha: 1.0)
    static let DefaultFont = UIFont(name: "Avenir Next", size: 20.0)!
    static let TitleFont = UIFont.systemFont(ofSize: 18, weight: UIFontWeightRegular)
    static let NavigationTitleFont = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
    static let DefaultTextFont = UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)
    static let ThemeColor = UIColor(red: 74/255, green: 198/255, blue: 181/255, alpha: 1.0)
    static let CornerRadius:CGFloat = 6
    static let MapZoomInLatitudeRange = 0.05
    static let MapZoomInLongtudeRange = 0.05
    static let tabFontSize: CGFloat = 14
    static let DefaultMargin: CGFloat = 8
    static let DefaultTableViewCellHeight: CGFloat = 44
    
    // Detailed event text options, used in feed and detailed event page
    static let DetailedEventTitltFont = UIFont(descriptor: UIFontDescriptor(fontAttributes: [
        UIFontDescriptorNameAttribute: "Avenir Next",
        UIFontDescriptorTraitsAttribute: [UIFontWeightTrait: UIFontWeightBold]
        ]), size: 18)
    static let DetailedEventAttributeFont = UIFont(descriptor: UIFontDescriptor(fontAttributes: [
        UIFontDescriptorNameAttribute: "Avenir Next",
        UIFontDescriptorTraitsAttribute: [UIFontWeightTrait: UIFontWeightRegular]
        ]), size: 16)
    static let DetailedEventDescriptionFont = UIFont(descriptor: UIFontDescriptor(fontAttributes: [
        UIFontDescriptorNameAttribute: "Avenir Next",
        UIFontDescriptorTraitsAttribute: [UIFontWeightTrait: UIFontWeightRegular]
        ]), size: 14)
    static let DetailedEventDefaultTextColor = UIColor(red: 0/255, green: 75/255, blue: 102/255, alpha: 1.0)
    
    
    // Image names
    static let Like = "like"
    static let Comment = "comment"
    static let Calendar = "calendar"
    static let Pin = "pin"
    static let Group = "group"
    static let AddPhoto = "add_photo"
    static let DefaultPhoto = "defaultPhoto"
}
