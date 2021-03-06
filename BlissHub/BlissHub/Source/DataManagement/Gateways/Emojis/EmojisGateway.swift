//
//  EmojisGateway.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import RxSwift

protocol EmojisGatewayContract {
    
    func getEmojis() -> Single<[EmojiModel]?>
}

class EmojisGateway: EmojisGatewayContract {
    
    let githubRepository: GithubRepositoryContract
    let realmRepository: RealmRepositoryContract
    
    init(githubRepo: GithubRepositoryContract,
         realmRepo: RealmRepositoryContract) {
        
        self.githubRepository = githubRepo
        self.realmRepository = realmRepo
    }
    
    func getEmojis() -> Single<[EmojiModel]?> {
        return Single<[EmojiModel]?>.create { [unowned self] single in
            
            if self.realmRepository.hasEmojis() {
                _ = self.realmRepository.getEmojis().subscribe(
                    onSuccess: { emojisRealmList in
                        
                        let emojiList: [EmojiModel] = emojisRealmList.map { $0.toModel() }
                        
                        single(.success(emojiList))
                }, onError: { error in
                    single(.error(error))
                })
            } else {
                _ = self.githubRepository.getEmojis().subscribe(
                    onSuccess: { [unowned self] emojisGithubList in
                        
                        if let emojisGithubList = emojisGithubList {
                            let emojiList: [EmojiModel] = emojisGithubList.map { $0.toModel() }
                            let emojiRealmList: [EmojiRealmModel] = emojiList.map { EmojiRealmModel(fromModel: $0) }
                            
                            _ = self.realmRepository.setEmojis(emojiRealmList: emojiRealmList).subscribe(
                                onCompleted: {
                                    single(.success(emojiList))
                            }, onError: { error in
                                // Error handling
                                single(.error(error))
                            })
                        } else {
                            single(.success(nil))
                        }
                }, onError: { error in
                    single(.error(error))
                })
            }
            
            return Disposables.create()
        }
    }
}
