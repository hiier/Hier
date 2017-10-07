//
//  Image.swift
//  Hier
//
//  Created by P.R.K on 9/20/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import Foundation
import UIKit
import Material

public extension UIView {

    func zoomIn(_ duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        
        
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.superview?.layoutIfNeeded()
            self.frame = UIScreen.main.bounds
//            self.transform = CGAffineTransform(scaleX: 2, y: 2)
        }, completion: completion)  }
    
    
    

}
