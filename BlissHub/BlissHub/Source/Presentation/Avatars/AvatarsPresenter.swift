//
//  AvatarsPresenter.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation

protocol AvatarsPresenterContract: PresenterContract {
    
}

class AvatarsPresenter: AvatarsPresenterContract {
    
    let interactor: AvatarsInteractorContract
    
    init(interactor: AvatarsInteractorContract) {
        
        self.interactor = interactor
    }
}
