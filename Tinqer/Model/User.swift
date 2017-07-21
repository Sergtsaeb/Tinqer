//
//  User.swift
//  Tinqer
//
//  Created by Sergelenbaatar Tsogtbaatar on 7/18/17.
//  Copyright © 2017 Sergtsaeb. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    
    dynamic var nameFirst: String? = nil
    dynamic var nameLast: String? = nil
    dynamic var likedBlooms: [Bloom] = []
    dynamic var ownedBlooms = [Bloom]()
    dynamic var favoritedBlooms = [Bloom]()
    dynamic var sharedBlooms = [Bloom]()
    
}
