//
//  AppleReposGateway.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation

protocol AppleReposGatewayContract {
    
}

class AppleReposGateway: AppleReposGatewayContract {
    
    let githubRepository: GithubRepositoryContract
    let realmRepository: RealmRepositoryContract
    
    init(githubRepo: GithubRepositoryContract,
         realmRepo: RealmRepositoryContract) {
        
        self.githubRepository = githubRepo
        self.realmRepository = realmRepo
    }
}
