//
//  EmojisGithubRepository.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol GithubRepositoryContract {
    
    func getEmojis() -> Single<[EmojiGithubModel]?>
    func getUser(username: String) -> Single<AvatarGithubModel?>
}

class GithubRepository: GithubRepositoryContract {
    
    func getEmojis() -> Single<[EmojiGithubModel]?> {
        return Single<[EmojiGithubModel]?>.create { single in
            
            _ = GithubProvider.instance.rx.request(.getEmojis).subscribe { event in
                switch event {
                case let .success(response):
                    do {
                        _ = try response.filterSuccessfulStatusCodes()
                        let emojisJSON = try response.mapJSON()
                        print(emojisJSON)
                        
                        if let emojisDict = emojisJSON as? [String: String] {
                            let emojisGithubList: [EmojiGithubModel] = emojisDict.map { name, url in
                                return EmojiGithubModel(name: name, url: url)
                            }
                            
                            print("Emoji server hit with " + String(emojisGithubList.count) + " results")
                            
                            single(.success(emojisGithubList))
                        } else {
                            print("Failure on parsing response")
                            single(.success(nil))
                        }
                    } catch {
                        print("Failure on parsing response")
                        single(.success(nil))
                    }
                case let .error(error):
                    // Error handling
                    single(.error(error))
                }
            }
            
            return Disposables.create()
        }
    }
    
    func getUser(username: String) -> Single<AvatarGithubModel?> {
        return Single<AvatarGithubModel?>.create { single in
            
            _ = GithubProvider.instance.rx.request(.getUser(username: username)).subscribe { event in
                switch event {
                case let .success(response):
                    do {
                        _ = try response.filterSuccessfulStatusCodes()
                        let userJSON = try response.mapJSON()
                        print(userJSON)
                        
                        do {
                            let user = try response.map(AvatarGithubModel.self)
                            
                            print(user.login)
                            
                            print("Avatar server hit with username = " + user.login)
                            
                            single(.success(user))
                            
                        } catch {
                            print("Failure on mapping AvatarGithubModel from response")
                            
                            single(.success(nil))
                        }
                    } catch {
                        print("Failure on mapping a JSON object from response")
                        
                        single(.success(nil))
                    }
                case let .error(error):
                    // Error handling
                    
                    single(.error(error))
                }
            }
            
            return Disposables.create()
        }
    }
}
