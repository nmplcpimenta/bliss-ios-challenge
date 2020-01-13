//
//  AppleReposInteractor.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import RxSwift

protocol AppleReposInteractorContract {
    
    func getAppleReposPage(page: Int) -> Single<[AppleRepoModel]?>
}

class AppleReposInteractor: AppleReposInteractorContract {
    
    let gateway: AppleReposGatewayContract
    
    init(gateway: AppleReposGatewayContract) {
        
        self.gateway = gateway
    }
}

extension AppleReposInteractor {
    
    func getAppleReposPage(page: Int) -> Single<[AppleRepoModel]?> {
        return Single<[AppleRepoModel]?>.create { single in
            
            _ = self.gateway.getAppleReposPage(page: page, size: 10).subscribe(
                onSuccess: { appleRepoModelList in
                    
                    single(.success(appleRepoModelList))
            }, onError: { error in
                single(.error(error))
            })
            
            return Disposables.create()
        }
    }
}
