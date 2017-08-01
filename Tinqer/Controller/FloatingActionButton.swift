//
//  FloatingActionButton.swift
//  Tinqer
//
//  Created by Sergelenbaatar Tsogtbaatar on 8/1/17.
//  Copyright © 2017 Sergtsaeb. All rights reserved.
//

import UIKit

class FloatingActionButton: UIButtonX {
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        
        UIView.animate(withDuration: 0.4, animations: {
            
            if self.transform == .identity {
                self.transform = CGAffineTransform(rotationAngle: 45 * (.pi / 180))
            } else {
                self.transform = .identity
            }
        })
        
        return super.beginTracking(touch, with: event)
        
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        
    }
    
}
