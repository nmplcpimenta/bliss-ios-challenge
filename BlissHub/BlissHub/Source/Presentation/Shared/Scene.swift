//
//  Scene.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation

protocol SceneContract {
    
    func configure() -> PresenterContract
}

enum Scene: SceneContract {
    case emojis
    case avatars
    case appleRepos
    
    func configure() -> PresenterContract {
        
        switch self {
        case .emojis:
            let scene = EmojisScene()
            return scene.configure()
        case .avatars:
            let scene = AvatarsScene()
            return scene.configure()
        case .appleRepos:
            let scene = AppleReposScene()
            return scene.configure()
        }
    }
}
