//
//  CategoryViewController.swift
//  Tinqer
//
//  Created by JD Leonard on 7/30/17.
//  Copyright © 2017 Sergtsaeb. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("category page loaded")
        
        labelSetUp(for: categoryLabel, color: UIColor.orange)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipedToLeft))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        categoryLabel.addGestureRecognizer(swipeLeft)
        categoryLabel.isUserInteractionEnabled = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // PRAGMA MARK: OUTLETS
    @IBOutlet weak var categoryLabel: UILabel!
    
    //PRAGMA MARK: LABEL SETUP
    //maybe just make into one line in ViewDidLoad
    func labelSetUp(for label:UILabel, color:UIColor) {
        label.backgroundColor = color
    }
    
    
    
    
    // PRAGMA MARK: SWIPES
    
    func swipedToLeft() {
        print("user swiped left")
        // work in segue from top
        let storyboard = UIStoryboard(name: "CategoryVC", bundle: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: "categoryVC")
        self.present(controller, animated: true, completion: nil)
        
    }
    
    func swipedDown() {
        //Do stuff when swiping down is recognised
        print("User swiped down")
        
        /*self.categoryLabel.alpha = 0;
         
         [UIView animateWithDuration:0.2
         delay:0
         options:UIViewAnimationOptionCurveEaseIn
         animations:^{
         // moves label down 100 units in the y axis
         self.caegoryLabel.transform = CGAffineTransformMakeTranslate(0, 100);
         // fade label in
         self.categoryLabel.alpha = 1;
         }
         completion:^(BOOL finished) {
         [UIView animateWithDuration:0.2
         delay:0
         options:UIViewAnimationOptionCurveEaseOut
         animations:^{
         // move label down further by 100 units
         self.categoryLabel.transform = CGAffineTransformMakeTranslate(0,1000);
         // fade label out
         self.categoryLabel.alpha = 0;
         }
         completion:nil];
         }];
         */
    }
    
    // PRAGMA MARK: ANIMATED

    var animator:UIDynamicAnimator!
    var container:UICollisionBehavior!
    var snap:UISnapBehavior!
    var dynamicItem:UIDynamicItemBehavior!
    var gravity:UIGravityBehavior!
    
    var panGestureRecognizer:UIPanGestureRecognizer!
    
    
    func setup () {
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(CategoryViewController.handlePan(_:)))
        panGestureRecognizer.cancelsTouchesInView = false
        
        self.view.addGestureRecognizer(panGestureRecognizer)
        
        animator = UIDynamicAnimator(referenceView: self.view.superview!)
        dynamicItem = UIDynamicItemBehavior(items: [self.view])
        dynamicItem.allowsRotation = false
        dynamicItem.elasticity = 0
        
        gravity = UIGravityBehavior(items: [self.view])
        gravity.gravityDirection = CGVector(dx: 0, dy: -1)
        
        container = UICollisionBehavior(items: [self.view])
        
        configureContainer()
        
        animator.addBehavior(gravity)
        animator.addBehavior(dynamicItem)
        animator.addBehavior(container)
        
    }
    
    func configureContainer (){
        let boundaryWidth = UIScreen.main.bounds.size.width
        container.addBoundary(withIdentifier: "upper" as NSCopying, from: CGPoint(x: 0, y: -self.view.frame.size.height + 66), to: CGPoint(x: boundaryWidth, y: -self.view.frame.size.height + 66))
        
        let boundaryHeight = UIScreen.main.bounds.size.height
        container.addBoundary(withIdentifier: "lower" as NSCopying, from: CGPoint(x: 0, y: boundaryHeight), to: CGPoint(x: boundaryWidth, y: boundaryHeight))
        
        
    }
    
    func handlePan (_ pan:UIPanGestureRecognizer){
        let velocity = pan.velocity(in: self.view.superview).y
        
        var movement = self.view.frame
        movement.origin.x = 0
        movement.origin.y = movement.origin.y + (velocity * 0.05)
        
        if pan.state == .ended {
            panGestureEnded()
        }else if pan.state == .began {
            snapToBottom()
        }else{
            animator.removeBehavior(snap)
            snap = UISnapBehavior(item: self.view, snapTo: CGPoint(x: movement.midX, y: movement.midY))
            animator.addBehavior(snap)
        }
        
    }
    
    func panGestureEnded () {
        animator.removeBehavior(snap)
        
        let velocity = dynamicItem.linearVelocity(for: self.view)
        
        if fabsf(Float(velocity.y)) > 250 {
            if velocity.y < 0 {
                snapToTop()
            }else{
                snapToBottom()
            }
        }else{
            if let superViewHeigt = self.view.superview?.bounds.size.height {
                if self.view.frame.origin.y > superViewHeigt / 2 {
                    snapToBottom()
                }else{
                    snapToTop()
                }
            }
        }
        
    }
    
    func snapToBottom() {
        gravity.gravityDirection = CGVector(dx: 0, dy: 2.5)
    }
    
    func snapToTop(){
        gravity.gravityDirection = CGVector(dx: 0, dy: -2.5)
    }
    
    
     // this is what is causing crash
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    //    self.view.tintColor = UIColor.clear
        
    }
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
}

