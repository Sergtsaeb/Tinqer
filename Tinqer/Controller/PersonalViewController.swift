//
//  PersonalViewController.swift
//  Tinqer
//
//  Created by Sergelenbaatar Tsogtbaatar on 7/18/17.
//  Copyright © 2017 Sergtsaeb. All rights reserved.
//

import UIKit
import RealmSwift

class PersonalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var blooms = [Bloom]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        queryBlooms()
    }
    
    func queryBlooms() {
        let realm = try! Realm()
        let blooms = realm.objects(Bloom.self)
        
        for bloom in blooms {
            self.blooms.append(bloom)
            self.tableView.reloadData()
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = blooms[indexPath.row].text
        return cell
    }

}
