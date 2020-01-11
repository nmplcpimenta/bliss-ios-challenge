//
//  AppleReposInteractor.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation

protocol AppleReposInteractorContract {
    
}

class AppleReposInteractor: AppleReposInteractorContract {
    
    let gateway: AppleReposGatewayContract
    
    init(gateway: AppleReposGatewayContract) {
        
        self.gateway = gateway
    }
}
