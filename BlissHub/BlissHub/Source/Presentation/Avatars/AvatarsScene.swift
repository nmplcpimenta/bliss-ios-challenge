//
//  AvatarsScene.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation

class AvatarsScene: SceneContract {
    
    func configure() -> PresenterContract {
        
        let presenter = AvatarsPresenter(interactor: Interactor.Avatars)
        
        return presenter
    }
}
