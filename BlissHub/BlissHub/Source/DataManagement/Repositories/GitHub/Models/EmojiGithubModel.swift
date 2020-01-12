//
//  EmojiGithubModel.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation

struct EmojiGithubModel {
    
    var name: String
    var url: String
    
    func toModel() -> EmojiModel {
        
        return EmojiModel(name: name, url: url)
    }
}
