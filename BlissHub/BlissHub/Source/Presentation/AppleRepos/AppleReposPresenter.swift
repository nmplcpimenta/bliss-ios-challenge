//
//  AppleReposPresenter.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation

protocol AppleReposPresenterContract: PresenterContract {
    
}

class AppleReposPresenter: AppleReposPresenterContract {
    
    let interactor: AppleReposInteractorContract
    
    init(interactor: AppleReposInteractorContract) {
        
        self.interactor = interactor
    }
}
