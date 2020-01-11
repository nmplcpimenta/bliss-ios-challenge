//
//  Interactor.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation

internal enum Interactor {
    
    internal static var Emojis: EmojisInteractorContract {
        return EmojisInteractor(gateway: Gateway.Emojis)
    }
    
    internal static var Avatars: AvatarsInteractorContract {
        return AvatarsInteractor(gateway: Gateway.Avatars)
    }
    
    internal static var AppleRepos: AppleReposInteractorContract {
        return AppleReposInteractor(gateway: Gateway.AppleRepos)
    }
}
