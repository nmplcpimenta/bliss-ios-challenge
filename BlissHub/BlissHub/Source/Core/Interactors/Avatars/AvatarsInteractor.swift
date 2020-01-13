//
//  AvatarsInteractor.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import RxSwift

protocol AvatarsInteractorContract {
    
    func getUser(username: String) -> Single<Bool>
    func getAvatars() -> Single<[AvatarModel]>
    func deleteAvatar(avatar: AvatarModel) -> Completable
}

class AvatarsInteractor: AvatarsInteractorContract {
    
    let gateway: AvatarsGatewayContract
    
    init(gateway: AvatarsGatewayContract) {
        
        self.gateway = gateway
    }
    
    func getUser(username: String) -> Single<Bool> {
        return gateway.getUser(username: username)
    }
    
    func getAvatars() -> Single<[AvatarModel]> {
        return gateway.getAvatars()
    }
    
    func deleteAvatar(avatar: AvatarModel) -> Completable {
        return gateway.deleteAvatar(avatar: avatar)
    }
}
