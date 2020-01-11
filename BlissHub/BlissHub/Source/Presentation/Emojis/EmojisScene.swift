//
//  EmojisScene.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation

class EmojisScene: SceneContract {
    
    func configure() -> PresenterContract {
        
        let presenter = EmojisPresenter(interactor: Interactor.Emojis)
        
        return presenter
    }
}
