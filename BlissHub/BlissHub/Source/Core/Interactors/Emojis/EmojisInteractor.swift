//
//  EmojisInteractor.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import RxSwift

protocol EmojisInteractorContract {
    
    func getEmojis() -> Single<[EmojiModel]>
}

class EmojisInteractor: EmojisInteractorContract {
    
    let gateway: EmojisGatewayContract
    
    init(gateway: EmojisGatewayContract) {
        
        self.gateway = gateway
    }
    
    func getEmojis() -> Single<[EmojiModel]> {
        return Single<[EmojiModel]>.create { [unowned self] single in
            
            _ = self.gateway.getEmojis().subscribe(
                onSuccess: { emojiList in
                    
                    single(.success(emojiList))
            }, onError: { error in
                print(error.localizedDescription)
            })
            
            return Disposables.create()
        }
    }
}
