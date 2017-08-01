//
//  ComposeViewController.swift
//  Tinqer
//
//  Created by JD Leonard on 7/18/17.
//  Copyright © 2017 Sergtsaeb. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("The ComposeVC opened!")
        super.viewDidLoad()
        bloomField.delegate = self
        self.characterCountLabel.text = "140"
        //make the keyboard appear immediately. right into composing [first responder]
        bloomField.becomeFirstResponder()
        placeHolderSetup()
        categoryLabelPage()
        /*
        // attach label - move when page is made
        labelSetUp(for: attachLabel, color: UIColor.blue)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipedToLeft))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        attachLabel.isUserInteractionEnabled = true
        attachLabel.addGestureRecognizer(swipeLeft)
        */
        
    }
    
    func categoryLabelPage() {
        categories = Bundle.main.loadNibNamed("CategoryVC", owner: self, options: nil)?.last as! CategoryView
        categories.frame = CGRect(x: 0, y: -self.view.frame.size.height + 66, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.addSubview(categories)
        
        categories.setup()
    }
    
    // PRAGMA MARK: _    Page SetUp and Swipes
    
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
    
    
    
    // PRAGMA MARK: OUTLETS
    
    // Outlets
    @IBOutlet weak var bloomField: UITextView!
    @IBOutlet weak var characterCountLabel: UILabel!
    
    
    @IBOutlet weak var attachLabel: UILabel!
    var placeholderLabel : UILabel!

    var categories:CategoryView!

    // PRAGMA MARK: LABEL & PLACEHOLDER SETUP
    func labelSetUp(for label:UILabel, color:UIColor) {
        label.backgroundColor = color
    }
    
    func placeHolderSetup() {
        placeholderLabel = UILabel()
        placeholderLabel.text = "What are you thinking about today?\n How will you change the world? Who will be impacted? How do you categorize your bloom?"
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (bloomField.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        placeholderLabel.lineBreakMode = NSLineBreakMode.byWordWrapping//byWordWrapping
        bloomField.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (bloomField.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !bloomField.text.isEmpty
        
    }
    
    // PRAGMA MARK: TEXTVIEW DELEGATES
    
    // function to count characters and limit composer
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        //        placeholderLabel.isHidden = !textView.text.isEmpty
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = 140 - Int(newText.characters.count)
        //        let countRemain = 140 - Int(numberOfChars)
        self.characterCountLabel.text = "\(numberOfChars)"
        // hide the placeholder when user has input, else show when empty
        if numberOfChars == 140 {
            print("its empty - place back holder and eliminate text")
            bloomField.text = ""
            placeholderLabel.isHidden = false
        }
        else {
            placeholderLabel.isHidden = true
        }
        return numberOfChars < 140 // if the desire is to STOP the user from going past 140, remove "140 - Int(... from numberOfChars and uncomment coutnRemain"
        
    }
    
    
    
    
    
    /* TO BE DONE
     pull down on category (dismiss keyboard) (open respective page)
     pull up on attach (dismiss keyboard) (open respective page)
     */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


