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
    
    func getEmojis() -> Single<[EmojiGithubModel]>
}

class GithubRepository: GithubRepositoryContract {
    
    func getEmojis() -> Single<[EmojiGithubModel]> {
        return Single<[EmojiGithubModel]>.create { _ in
            
            _ = GithubProvider.instance.rx.request(.getEmojis).subscribe { event in
                switch event {
                case let .success(response):
                    do {
                        _ = try response.filterSuccessfulStatusCodes()
                        let data = try response.mapJSON()
                        print(data)
                    } catch {
                        print("Failure on parsing response")
                    }
                case let .error(error):
                    print(error)
                }
            }
            
            return Disposables.create()
        }
    }
}