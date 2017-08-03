//
//  CategoryView.swift
//  Tinqer
//
//  Created by JD Leonard on 7/31/17.
//  Copyright © 2017 Sergtsaeb. All rights reserved.
//

import UIKit

class CategoryView: UIView, UITableViewDelegate {
//, UITableViewDataSource {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryList: UITableView!
    
    var composeVC:ComposeViewController!
    var keyboardShowing:Bool!
    
    // PRAGMA MARK: ANIMATED VARIABLES
    var animator:UIDynamicAnimator!
    var container:UICollisionBehavior!
    var snap:UISnapBehavior?
    var dynamicItem:UIDynamicItemBehavior!
    var gravity:UIGravityBehavior!
    var panGestureRecognizer:UIPanGestureRecognizer!
    
    
    
    // PRAGMA MARK: SETUP
    
    func setup () {
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(CategoryView.handlePan(_:)))
        panGestureRecognizer.cancelsTouchesInView = false
        
        self.addGestureRecognizer(panGestureRecognizer)
        
        animator = UIDynamicAnimator(referenceView: self.superview!)
        dynamicItem = UIDynamicItemBehavior(items: [self])
        dynamicItem.allowsRotation = false
        dynamicItem.elasticity = 0
        
        gravity = UIGravityBehavior(items: [self])
        gravity.gravityDirection = CGVector(dx: 0, dy: -1)
        
        container = UICollisionBehavior(items: [self])
        
        configureContainer()
        
        animator.addBehavior(gravity)
        animator.addBehavior(dynamicItem)
        animator.addBehavior(container)
        
        // animations added. now load on tableview and label
        viewLoaded()
        
    }
    
    func viewLoaded() {
        self.backgroundColor = UIColor.red

        self.categoryLabel.text = "CATEGORY"
        labelSetUp(for: self.categoryLabel, color: UIColor.blue)
        keyboardShowing = true
        
        categoryList.delegate = self
//        categoryList.dataSource = self
    }
    
    func labelSetUp(for label:UILabel, color:UIColor) {
        label.backgroundColor = color
    }
    
    func configureContainer (){
        let boundaryWidth = UIScreen.main.bounds.size.width
        let boundaryHeight = UIScreen.main.bounds.size.height

        container.addBoundary(withIdentifier: "upper" as NSCopying, from: CGPoint(x: 0, y: -boundaryHeight * 11/12), to: CGPoint(x: boundaryWidth, y: -boundaryHeight * 11/12))
        
        container.addBoundary(withIdentifier: "lower" as NSCopying, from: CGPoint(x: 0, y: boundaryHeight), to: CGPoint(x: boundaryWidth, y: boundaryHeight))
        
        
    }
    
    
    // PRAGMA MARK: TABLEVIEW
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("asking for numbers")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return 1
    }
 */
    
    // PRAGMA MARK: HANDLING
    
    func handlePan (_ pan:UIPanGestureRecognizer){
        let velocity = pan.velocity(in: self.superview).y
        
        var movement = self.frame
        movement.origin.x = 0
        movement.origin.y = movement.origin.y + (velocity * 0.05)
        
        if pan.state == .ended {
            panGestureEnded()
        }else if pan.state == .began {
            snapToBottom()
        }else{
            if var snap = snap {
                animator.removeBehavior(snap)
                snap = UISnapBehavior(item: self, snapTo: CGPoint(x: movement.midX, y: movement.midY))
                animator.addBehavior(snap)
            }
        }
    }
    
    func panGestureEnded () {
        
        let velocity = dynamicItem.linearVelocity(for: self)
        
        if fabsf(Float(velocity.y)) > 250 {
            if velocity.y < 0 {
                snapToTop()
            }else{
                snapToBottom()
            }
        }else{
            if let superViewHeigt = self.superview?.bounds.size.height {
                if self.frame.origin.y > superViewHeigt / 2 {
                    snapToBottom()
                }else{
                    snapToTop()
                }
            }
        }
        
        // not sure if this is helping or not
        guard let snap = snap else { return }
        animator.removeBehavior(snap)
        
    }
    
    
    // maybe using BOOL, make into just one notifcation center function called with parameter of notif
    func snapToBottom() {
        gravity.gravityDirection = CGVector(dx: 0, dy: 2.5)
        
        if keyboardShowing == true {
            let myNotificationKey = "byeByeKeyboard"
            NotificationCenter.default.post(
                name: Notification.Name(
                    rawValue: myNotificationKey), object: self)
            keyboardShowing = false
        }
    }
    
    func snapToTop(){
        gravity.gravityDirection = CGVector(dx: 0, dy: -2.5)
        
        if keyboardShowing == false {
            let myNotificationKey = "helloKeyboard"
            NotificationCenter.default.post(
                name: Notification.Name(
                    rawValue: myNotificationKey), object: self)
            keyboardShowing = true
        }
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //        self.tintColor = UIColor.clear
        
    }
    
}
