//
//  PersonalViewController.swift
//  Tinqer
//
//  Created by Sergelenbaatar Tsogtbaatar on 7/18/17.
//  Copyright © 2017 Sergtsaeb. All rights reserved.
//

import UIKit
import RealmSwift

class PersonalViewController: UIViewController, UITableViewDataSource {
    var blooms = [Bloom]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = blooms[indexPath.row].text
        return cell
    }

}
