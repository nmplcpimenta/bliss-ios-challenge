//
//  EmojisPresenter.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation

protocol EmojisPresenterContract: PresenterContract {
    
}

class EmojisPresenter: EmojisPresenterContract {
    
    let interactor: EmojisInteractorContract
    
    init(interactor: EmojisInteractorContract) {
        
        self.interactor = interactor
    }
}
