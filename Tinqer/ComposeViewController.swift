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
        //make the keyboard appear immediately. right into composing [first responder]
        super.viewDidLoad()
        bloomField.delegate = self
        self.characterCountLabel.text = "140"
    }

    // PRAGMA MARK: OUTLETS
    // Outlets
    @IBOutlet weak var bloomField: UITextView!
    @IBOutlet weak var characterCountLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var attachLabel: UILabel!
    
    
    
    // PRAGMA MARK: TEXTVIEW DELEGATES
    
    
    /*
 func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        let length = text.characters.count + string.characters.count - range.length
        
        // create an Integer of 55 - the length of your TextField.text to count down
        let count = 140 - length
        
        // set the .text property of your UILabel to the live created String
        characterCountLabel.text =  String(count)
        
        // if you want to limit to 55 characters
        // you need to return true and <= 55
        
        return length <= 140 // To just allow up to 55 characters
    }
 */
    // function to count characters and limit composer

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = 140 - Int(newText.characters.count)
//        let countRemain = 140 - Int(numberOfChars)
        self.characterCountLabel.text = "\(numberOfChars)"
        return numberOfChars < 140 // if the desire is to STOP the user from going past 140, remove "140 - Int(... from numberOfChars and uncomment coutnRemain"
    }
    
    override func becomeFirstResponder() -> Bool {
        print("keyboard working")
        
        return true
    }
    
    
    
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


