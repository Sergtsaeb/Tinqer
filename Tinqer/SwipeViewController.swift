//
//  SwipeViewController.swift
//  Tinqer
//
//  Created by Sergelenbaatar Tsogtbaatar on 7/14/17.
//  Copyright © 2017 Sergtsaeb. All rights reserved.
//

import UIKit

class SwipeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        //get the pan gesture translation value and add it to be the new cener value for the view
        let card = sender.view!
        let point = sender.translation(in: view)
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        
        if sender.state == UIGestureRecognizerState.ended {
            //reset center to middle once the pan ends
            UIView.animate(withDuration: 0.2) {
                card.center = self.view.center
            }
        }
        
        
        
    }
    
}
