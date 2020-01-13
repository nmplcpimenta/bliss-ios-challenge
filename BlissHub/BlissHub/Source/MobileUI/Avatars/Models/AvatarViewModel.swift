//
//  AvatarViewModel.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 12/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation

struct AvatarViewModel {
    
    let githubId: String
    let username: String
    let url: String
    
    init(fromModel model: AvatarModel) {
        self.githubId = model.githubId
        self.username = model.username
        self.url = model.url
    }
    
    func toModel() -> AvatarModel {
        return AvatarModel(githubId: githubId, username: username, url: url)
    }
}
