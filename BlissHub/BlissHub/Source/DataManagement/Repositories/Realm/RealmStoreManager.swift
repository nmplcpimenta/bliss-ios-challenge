//
//  RealmStoreManager.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 12/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

protocol RealmStoreManagerContract {
    
    func hasEmojis() -> Bool
    func getEmojis() -> Single<[Emoji]>
    func setEmojis(emojis: [Emoji]) -> Completable
    
    func hasAvatar(username: String) -> Bool
    func getAvatars() -> Single<[Avatar]>
    func setAvatar(avatar: Avatar) -> Completable
    func deleteAvatar(avatar: Avatar) -> Completable
}

class RealmStoreManager: RealmStoreManagerContract {
    
    private let database: Realm
    
    static let sharedInstance: RealmStoreManagerContract = RealmStoreManager()
    
    private init() {
        
        do {
            database = try Realm()
        } catch {
            fatalError(AppStrings.realmInitError)
        }
    }
}

extension RealmStoreManager {
    
    func hasEmojis() -> Bool {
        
        return database.objects(Emoji.self).count > 0
    }
    
    func getEmojis() -> Single<[Emoji]> {
        return Single<[Emoji]>.create { single in
            
            let emojis: [Emoji] = self.database.objects(Emoji.self).map { $0 }
            
            single(.success(emojis))
            
            return Disposables.create()
        }
    }
    
    func setEmojis(emojis: [Emoji]) -> Completable {
        return Completable.create { [unowned self] completable in
            
            do {
                try self.database.write {
                    self.database.add(emojis)
                    
                    completable(.completed)
                }
            } catch {
                // Error handling
                print("Error inserting emojis into Realm")
                
                completable(.completed)
            }
            
            return Disposables.create()
        }
    }
}

extension RealmStoreManager {
    
    func hasAvatar(username: String) -> Bool {
        
        return self.database.object(ofType: Avatar.self, forPrimaryKey: username) != nil
    }
    
    func getAvatars() -> Single<[Avatar]> {
        return Single<[Avatar]>.create { single in
            
            let avatars: [Avatar] = self.database.objects(Avatar.self).map { $0 }
            
            single(.success(avatars))
            
            return Disposables.create()
        }
    }
    
    func setAvatar(avatar: Avatar) -> Completable {
        return Completable.create { [unowned self] completable in
            
            do {
                try self.database.write {
                    self.database.add(avatar)
                }
                
                completable(.completed)
            } catch {
                // Error handling
                print("Error inserting avatar into Realm")
                
                completable(.completed)
            }
            
            return Disposables.create()
        }
    }
    
    func deleteAvatar(avatar: Avatar) -> Completable {
        return Completable.create { [unowned self] completable in
            
            let avatarFound = self.database.object(ofType: Avatar.self, forPrimaryKey: avatar.username)
            
            if let avatarFound = avatarFound {
                do {
                     try self.database.write {
                         
                         self.database.delete(avatarFound)
                     }
                     
                     completable(.completed)
                 } catch {
                    // Error handling
                    print("Error deleting avatar from Realm")
                    
                    completable(.completed)
                }
            } else {
                completable(.completed)
            }
            
            return Disposables.create()
        }
    }
}
