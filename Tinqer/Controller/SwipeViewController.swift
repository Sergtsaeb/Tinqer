//
//  SwipeViewController.swift
//  Tinqer
//
//  Created by Sergelenbaatar Tsogtbaatar on 7/14/17.
//  Copyright © 2017 Sergtsaeb. All rights reserved.
//

import UIKit

class SwipeViewController: UIViewController {
    
    @IBOutlet weak var swipeImageView: UIImageView!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var actionButton: FloatingActionButton!
    @IBOutlet weak var bloomsButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    
    @IBOutlet weak var composeButton: UIButton!
    @IBOutlet weak var menuView: UIView!
    
    var divisor: CGFloat!

    @IBAction func composeVCButton(_ sender: Any) {
        if (composeButton) != nil {
            let storyboard = UIStoryboard(name: "ComposeVC", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "composeVC")
            self.present(controller, animated: true, completion: nil)
            
        }

    }
    
    @IBAction func categoryVCButton(_ sender: Any) {
    }
    
    @IBAction func personalVCButton(_ sender: Any) {
        if (bloomsButton) != nil {
            let storyboard = UIStoryboard(name: "PersonalVC", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "personalVC")
            self.present(controller, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func actionButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            
            if self.menuView.transform == .identity {
                self.menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            } else {
                self.menuView.transform = .identity
            }
        })
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
    }
    
    
    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        //get the pan gesture translation value and add it to be the new cener value for the view
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        
//        let scale = min(100/abs(xFromCenter), 1)
//        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor).scaledBy(x: scale, y: scale)
        
        if xFromCenter > 0 {
            //imageview
            swipeImageView.image = #imageLiteral(resourceName: "ic_thumb_up")
//            swipeImageView.tintColor = UIColor.green
            
        } else {
            //dislike image view
            swipeImageView.image = #imageLiteral(resourceName: "ic_thumb_down")
//            swipeImageView.tintColor = UIColor.red
        }
        
        swipeImageView.alpha = abs(xFromCenter) / view.center.x
        
        /*
         maybe a switch statement to try this?
         if the Y coordinate is not at center, lock in X to center, to swipe along the axis.
         if the X coordinate is not at center, lock in Y to center, to swipe along the axis
         */
        
        //swipe up
        if point.y <= (view.center.y / -2) {
            //            print("\(point.y) swiped up \(card.center.y)")
            print("\(point.y) swiped up \(view.center.y)")
        }
        
        //swipe down
        if point.y >= (view.center.y / 2) {
            print("\(point.y) swiped down \(view.center.y)")
        }
        
        //swipe Left
        if point.x <= (view.center.x / -2) {
            print("\(point.x) swiped left \(view.center.x)")
        }
        
        //swipe Right
        if point.x >= (view.center.x / 2) {
            print("\(point.x) swiped right \(view.center.x)")
        }
        
        
        
        if sender.state == UIGestureRecognizerState.ended {
            
            if card.center.x < 75 {
                //move to the left
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                    card.alpha = 0
                })
                return
                
            } else if card.center.x > (view.frame.width - 75) {
                //move to the right
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                    card.alpha = 0
                })
                return
            }
            
            resetCard()
        }
        
        
    }
    
    @IBAction func reset(_ sender: UIButton) {
        resetCard()
    }
    
    func resetCard() {
        //reset center to middle once the pan ends
        UIView.animate(withDuration: 0.2) {
            self.card.center = self.view.center
            self.swipeImageView.alpha = 0
            self.card.alpha = 1
        }
    }
    
    
}




