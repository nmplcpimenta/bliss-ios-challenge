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
    func setEmojis(emojiRealmList: [EmojiRealmModel]) -> Completable
    
    func hasAvatar(username: String) -> Bool
    func getAvatars() -> Single<[AvatarRealmModel]>
    func setAvatar(avatarRealmModel: AvatarRealmModel) -> Completable
    func deleteAvatar(avatarRealmModel: AvatarRealmModel) -> Completable
}

class RealmRepository: RealmRepositoryContract {
    
    func hasEmojis() -> Bool {
        return RealmStoreManager.sharedInstance.hasEmojis()
    }
    
    func getEmojis() -> Single<[EmojiRealmModel]> {
        return Single<[EmojiRealmModel]>.create { single in
            
            _ = RealmStoreManager.sharedInstance.getEmojis().subscribe(
                onSuccess: { emojis in
                    let emojiRealmList = emojis.map { EmojiRealmModel(fromRealmObject: $0) }
                    
                    print("Emoji cache hit with " + String(emojiRealmList.count) + " results")
                    
                    single(.success(emojiRealmList))
            }, onError: { error in
                // Error handling
                single(.error(error))
            })
            
            return Disposables.create()
        }
    }
    
    func setEmojis(emojiRealmList: [EmojiRealmModel]) -> Completable {
        return Completable.create { completable in
            
            let emojis: [Emoji] = emojiRealmList.map { $0.toRealmObject() }
            
            _ = RealmStoreManager.sharedInstance.setEmojis(emojis: emojis).subscribe(
                onCompleted: {
                    completable(.completed)
            }, onError: { error in
                // Error handling
                completable(.error(error))
            })
            
            return Disposables.create()
        }
    }
}

extension RealmRepository {
    
    func hasAvatar(username: String) -> Bool {
        
        let result = RealmStoreManager.sharedInstance.hasAvatar(username: username)
        
        if result {
            print("Avatar cache hit with username = " + username)
        }
        
        return result
    }
    
    func getAvatars() -> Single<[AvatarRealmModel]> {
        return Single<[AvatarRealmModel]>.create { single in
            
            _ = RealmStoreManager.sharedInstance.getAvatars().subscribe(
                onSuccess: { avatars in
                    let avatarRealmList = avatars.map { AvatarRealmModel(fromRealmObject: $0) }
                    
                    print("Avatar cache hit with " + String(avatarRealmList.count) + " results")
                    
                    single(.success(avatarRealmList))
            }, onError: { error in
                // Error handling
                single(.error(error))
            })
            
            return Disposables.create()
        }
    }
    
    func setAvatar(avatarRealmModel: AvatarRealmModel) -> Completable {
        return Completable.create { completable in
            
            let avatarRealmObject: Avatar = avatarRealmModel.toRealmObject()
            
            _ = RealmStoreManager.sharedInstance.setAvatar(avatar: avatarRealmObject).subscribe(
                onCompleted: {
                    completable(.completed)
            }, onError: { error in
                // Error handling
                completable(.error(error))
            })
            
            return Disposables.create()
        }
    }
    
    func deleteAvatar(avatarRealmModel: AvatarRealmModel) -> Completable {
        return Completable.create { completable in
            
            let avatarRealmObject: Avatar = avatarRealmModel.toRealmObject()
            
            _ = RealmStoreManager.sharedInstance.deleteAvatar(avatar: avatarRealmObject).subscribe(
                onCompleted: {
                    completable(.completed)
            }, onError: { error in
                // Error handling
                completable(.error(error))
            })
            
            return Disposables.create()
        }
    }
}
