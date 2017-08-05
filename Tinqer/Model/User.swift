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
    let likedBlooms = List<Bloom>()
    let ownedBlooms = List<Bloom>()
    let favoritedBlooms = List<Bloom>()
    let sharedBlooms = List<Bloom>()
    
}
