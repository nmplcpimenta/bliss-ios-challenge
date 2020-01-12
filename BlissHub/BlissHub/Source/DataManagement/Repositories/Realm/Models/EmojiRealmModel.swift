//
//  EmojiRealmModel.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 12/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation

struct EmojiRealmModel {
    
    var name: String
    var url: String
    
    func toModel() -> EmojiModel {
        
        return EmojiModel(name: name, url: url)
    }
}
