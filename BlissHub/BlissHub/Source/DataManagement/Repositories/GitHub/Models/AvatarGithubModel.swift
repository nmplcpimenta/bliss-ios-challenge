//
//  AvatarGithubModel.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 12/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation

struct AvatarGithubModel: Codable {
    
    // swiftlint:disable identifier_name
    var id: Int
    var login: String
    var avatar_url: String
    
    func toModel() -> AvatarModel {
        
        return AvatarModel(githubId: String(id), username: login, url: avatar_url)
    }
}
