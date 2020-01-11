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
            coreDataRepo: Repository.CoreData)
    }
    
    internal static var Avatars: AvatarsGatewayContract {
        return AvatarsGateway(
            githubRepo: Repository.Github,
            coreDataRepo: Repository.CoreData)
    }
    
    internal static var AppleRepos: AppleReposGatewayContract {
        return AppleReposGateway(
            githubRepo: Repository.Github,
            coreDataRepo: Repository.CoreData)
    }
}
