//
//  AvatarsGateway.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import RxSwift

protocol AvatarsGatewayContract {
    
    func getUser(username: String) -> Single<Bool>
    func getAvatars() -> Single<[AvatarModel]>
    func deleteAvatar(avatar: AvatarModel) -> Completable
}

class AvatarsGateway: AvatarsGatewayContract {
    
    let githubRepository: GithubRepositoryContract
    let realmRepository: RealmRepositoryContract
    
    init(githubRepo: GithubRepositoryContract,
         realmRepo: RealmRepositoryContract) {
        
        self.githubRepository = githubRepo
        self.realmRepository = realmRepo
    }
    
    func getUser(username: String) -> Single<Bool> {
        return Single<Bool>.create { single in
            
            if self.realmRepository.hasAvatar(username: username) {
                single(.success(true))
            } else {
                _ = self.githubRepository.getUser(username: username).subscribe(
                    onSuccess: { avatarGithubModel in
                        
                        if let avatarGithubModel = avatarGithubModel {
                            let avatarModel = avatarGithubModel.toModel()
                            let avatarRealmModel = AvatarRealmModel(fromModel: avatarModel)
                            
                            _ = self.realmRepository.setAvatar(avatarRealmModel: avatarRealmModel).subscribe(
                                onCompleted: {
                                    single(.success(true))
                            }, onError: { error in
                                // Error handling
                                single(.error(error))
                            })
                        } else {
                            single(.success(false))
                        }
                }, onError: { error in
                    // Error handling
                    
                    single(.error(error))
                })
            }
            
            return Disposables.create()
        }
    }
    
    func getAvatars() -> Single<[AvatarModel]> {
        return Single<[AvatarModel]>.create { single in
            
            _ = self.realmRepository.getAvatars().subscribe(
                onSuccess: { avatarRealmList in
                    
                    let avatarList: [AvatarModel] = avatarRealmList.map { $0.toModel() }
                    
                    single(.success(avatarList))
            }, onError: { error in
                // Error handling
                
                single(.error(error))
            })
            
            return Disposables.create()
        }
    }
    
    func deleteAvatar(avatar: AvatarModel) -> Completable {
        return Completable.create { completable in
            
            let avatarRealmModel = AvatarRealmModel(fromModel: avatar)
            
            _ = self.realmRepository.deleteAvatar(avatarRealmModel: avatarRealmModel).subscribe(
                onCompleted: {
                    completable(.completed)
            }, onError: { error in
                completable(.error(error))
            })
            
            return Disposables.create()
        }
    }
}
