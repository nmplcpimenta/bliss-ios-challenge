//
//  AvatarsInteractor.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation

protocol AvatarsInteractorContract {
    
}

class AvatarsInteractor: AvatarsInteractorContract {
    
    let gateway: AvatarsGatewayContract
    
    init(gateway: AvatarsGatewayContract) {
        
        self.gateway = gateway
    }
}
