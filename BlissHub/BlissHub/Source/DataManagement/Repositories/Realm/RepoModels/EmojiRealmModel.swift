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
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
    init(fromModel model: EmojiModel) {
        self.name = model.name
        self.url = model.url
    }
    
    init(fromRealmObject object: Emoji) {
        self.name = object.name
        self.url = object.url
    }
    
    func toModel() -> EmojiModel {
        
        return EmojiModel(name: name, url: url)
    }
    
    func toRealmObject() -> Emoji {
        
        let emoji: Emoji = Emoji()
        emoji.name = self.name
        emoji.url = self.url
        
        return emoji
    }
}
