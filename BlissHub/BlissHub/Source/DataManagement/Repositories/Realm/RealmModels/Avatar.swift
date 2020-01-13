//
//  Avatar.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 12/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import RealmSwift

class Avatar: Object {
    
    @objc dynamic var githubId: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var url: String = ""
    
    override static func primaryKey() -> String? { return "username" }
}
