//
//  AvatarRealmModel.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 12/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation

struct AvatarRealmModel {
    
    var githubId: String
    var username: String
    var url: String
    
    init(githubId: String, username: String, url: String) {
        self.githubId = githubId
        self.username = username
        self.url = url
    }
    
    init(fromModel model: AvatarModel) {
        self.githubId = model.githubId
        self.username = model.username
        self.url = model.url
    }
    
    init(fromRealmObject object: Avatar) {
        self.githubId = object.githubId
        self.username = object.username
        self.url = object.url
    }
    
    func toModel() -> AvatarModel {
        
        return AvatarModel(
            githubId: githubId,
            username: username,
            url: url)
    }
    
    func toRealmObject() -> Avatar {
        
        let avatar: Avatar = Avatar()
        avatar.githubId = githubId
        avatar.username = username
        avatar.url = url
        
        return avatar
    }
}
