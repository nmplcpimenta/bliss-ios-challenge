//
//  EmojisGateway.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation

protocol EmojisGatewayContract {
    
}

class EmojisGateway: EmojisGatewayContract {
    
    let githubRepository: GithubRepositoryContract
    let coreDataRepository: CoreDataRepositoryContract
    
    init(githubRepo: GithubRepositoryContract,
         coreDataRepo: CoreDataRepositoryContract) {
        
        self.githubRepository = githubRepo
        self.coreDataRepository = coreDataRepo
    }
}
