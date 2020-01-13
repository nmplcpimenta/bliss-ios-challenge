//
//  Emoji.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 12/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import RealmSwift

class Emoji: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""
    
    override static func primaryKey() -> String? { return "name" }
}
