//
//  Gateway.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation

internal enum Gateway {
    
    internal static var Emojis: EmojisGatewayContract {
        return EmojisGateway(
            githubRepo: Repository.Github,
            realmRepo: Repository.Realm)
    }
    
    internal static var Avatars: AvatarsGatewayContract {
        return AvatarsGateway(
            githubRepo: Repository.Github,
            realmRepo: Repository.Realm)
    }
    
    internal static var AppleRepos: AppleReposGatewayContract {
        return AppleReposGateway(
            githubRepo: Repository.Github,
            realmRepo: Repository.Realm)
    }
}
