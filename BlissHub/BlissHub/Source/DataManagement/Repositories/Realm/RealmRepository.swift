//
//  RealmRepository.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import RxSwift

protocol RealmRepositoryContract {
    
    func hasEmojis() -> Bool
    func getEmojis() -> Single<[EmojiRealmModel]>
    func setEmojis(emojis: [EmojiRealmModel]) -> Single<Bool>
}

class RealmRepository: RealmRepositoryContract {
    
    func hasEmojis() -> Bool {
        return false
    }
    
    func getEmojis() -> Single<[EmojiRealmModel]> {
        return Single<[EmojiRealmModel]>.create { single in
            single(.success([]))
            
            return Disposables.create()
        }
    }
    
    func setEmojis(emojis: [EmojiRealmModel]) -> Single<Bool> {
        return Single<Bool>.create { single in
            single(.success(true))
            
            return Disposables.create()
        }
    }
}
