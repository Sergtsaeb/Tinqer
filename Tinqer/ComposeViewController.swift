//
//  ComposeViewController.swift
//  Tinqer
//
//  Created by JD Leonard on 7/18/17.
//  Copyright © 2017 Sergtsaeb. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    // PRAGMA MARK: OUTLETS
    
    // Outlets
    @IBOutlet weak var bloomField: UITextView!
    @IBOutlet weak var characterCountLabel: UILabel!
    
    
    @IBOutlet weak var attachLabel: UILabel!
    var placeholderLabel : UILabel!
    
    var categories:CategoryView!
    
    // PRAGMA MARK: SETUP PAGE
    
    
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
        
        let myNotificationKey = "byeByeKeyboard"
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(dismissKeyboard),
                                               name: NSNotification.Name(rawValue: myNotificationKey),
                                               object: nil)
        let myNotificationKeyS = "helloKeyboard"
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showKeyboard),
                                               name: NSNotification.Name(rawValue: myNotificationKeyS),
                                               object: nil)
    }
    
    func categoryLabelPage() {
        categories = Bundle.main.loadNibNamed("CategoryVC", owner: self, options: nil)?.last as! CategoryView
        categories.frame = CGRect(x: 0, y: -self.view.frame.size.height + 66, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.addSubview(categories)
        
        categories.setup()
    }
    
    // PRAGMA MARK: LABEL & PLACEHOLDER SETUP
    /*
     func labelSetUp(for label:UILabel, color:UIColor) {
     label.backgroundColor = color
     }
     */
    
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
    
    
    //using BOOL, make into one function
    func dismissKeyboard() {
        print("keyboard is being called to dismiss")
        bloomField.resignFirstResponder()
    }
    
    func showKeyboard() {
        print("keyboard is being called to show")
        bloomField.becomeFirstResponder()
    }
    
    
    
    
    /* TO BE DONE
     pull up on attach (dismiss keyboard) (open respective page)
     */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


