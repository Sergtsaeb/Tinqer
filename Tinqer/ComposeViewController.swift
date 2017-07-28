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
        labelSetUp(for: categoryLabel, color: UIColor.orange)
        labelSetUp(for: attachLabel, color: UIColor.blue)
        
        //make the keyboard appear immediately. right into composing [first responder]
        bloomField.becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
//            bloomField.frame.origin.y = keyboardHeight - bloomField.frame.height - attachLabel.frame.height
//            print(keyboardHeight / self.view.frame.height)
//            print(bloomField.frame.origin.y)
            
        }
    }
    
    // PRAGMA MARK: OUTLETS
    // Outlets
    @IBOutlet weak var bloomField: UITextView!
    @IBOutlet weak var characterCountLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var attachLabel: UILabel!
    
    // PRAGMA MARK: LABEL SETUP
    func labelSetUp(for label:UILabel, color:UIColor) {
        label.backgroundColor = color
    }
    
    // PRAGMA MARK: TEXTVIEW DELEGATES
    
    // function to count characters and limit composer
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = 140 - Int(newText.characters.count)
        //        let countRemain = 140 - Int(numberOfChars)
        self.characterCountLabel.text = "\(numberOfChars)"
        return numberOfChars < 140 // if the desire is to STOP the user from going past 140, remove "140 - Int(... from numberOfChars and uncomment coutnRemain"
    }
    
    /*
     func textViewDidBeginEditing(_ textView: UITextView) {
        if bloomField.textColor == UIColor.black {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        print("keyboard working")
        
        return true
    }
    */
    
    
    /* TO BE DONE
     word count
     pull down on category (dismiss keyboard) (open respective page)
     pull up on attach (dismiss keyboard) (open respective page)
     */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


