//
//  ComposeViewController.swift
//  Tinqer
//
//  Created by JD Leonard on 7/18/17.
//  Copyright © 2017 Sergtsaeb. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextFieldDelegate {
    
    // Outlets
    @IBOutlet weak var bloomField: UITextField!
    @IBOutlet weak var characterCountLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var attachLabel: UILabel!
    
    // Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("The ComposeVC opened!")
        //make the keyboard appear immediately. right into composing
        super.viewDidLoad()
        bloomField.delegate = self
        self.characterCountLabel.text = "140"
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        let length = text.characters.count + string.characters.count - range.length
        
        // create an Integer of 55 - the length of your TextField.text to count down
        let count = 140 - length
        
        // set the .text property of your UILabel to the live created String
        characterCountLabel.text =  String(count)
        
        // if you want to limit to 55 charakters
        // you need to return true and <= 55
        
        return length <= 140 // To just allow up to 55 characters
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func becomeFirstResponder() -> Bool {
        print("keyboard working")
        return true
    }
    
    /* TO BE DONE
     word count
     pull down on category (dismiss keyboard)
     pull up on attach (dismiss keyboard)
     */
}

