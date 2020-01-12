//
//  EmojiViewModel.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 12/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation

struct EmojiViewModel {
    
    var name: String
    var url: String
    
    init(fromModel model: EmojiModel) {
        self.name = model.name
        self.url = model.url
    }
}
