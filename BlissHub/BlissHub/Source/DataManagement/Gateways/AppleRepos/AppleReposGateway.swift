//
//  AppleReposGateway.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import RxSwift

protocol AppleReposGatewayContract {
    
    func getAppleReposPage(page: Int, size: Int) -> Single<[AppleRepoModel]?>
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

extension AppleReposGateway {
    
    func getAppleReposPage(page: Int, size: Int) -> Single<[AppleRepoModel]?> {
        return Single<[AppleRepoModel]?>.create { single in
            
            _ = self.githubRepository.getAppleReposPage(page: page, size: size).subscribe(
                onSuccess: { appleRepoGithubModelList in
                    
                    if let appleRepoGithubModelList = appleRepoGithubModelList {
                        let appleRepoModelList = appleRepoGithubModelList.map { $0.toModel() }
                        
                        single(.success(appleRepoModelList))
                    } else {
                        single(.success(nil))
                    }
            }, onError: { error in
                single(.error(error))
            })
            
            return Disposables.create()
        }
    }
}
