//
//  UnderLinedLabel.swift
//  Hier
//
//  Created by P.R.K on 12/5/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit


open class UnderlinedLabel: UILabel {
    
    override open var text: String? {
        didSet {
            guard let text = text else { return }
            let textRange = NSMakeRange(0, text.characters.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
            // Add other attributes if needed
            self.attributedText = attributedText
        }
    }
}
