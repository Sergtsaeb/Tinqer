//
//  Bloom.swift
//  Tinqer
//
//  Created by Sergelenbaatar Tsogtbaatar on 7/18/17.
//  Copyright © 2017 Sergtsaeb. All rights reserved.
//

import Foundation
import RealmSwift

class Bloom: Object {
    dynamic var category = [Category]()
    dynamic var text: String?
}
