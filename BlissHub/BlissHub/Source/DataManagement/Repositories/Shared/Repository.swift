//
//  Repository.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation

internal enum Repository {
    
    internal static var Realm: RealmRepositoryContract {
        return RealmRepository()
    }
    
    internal static var Github: GithubRepositoryContract {
        return GithubRepository()
    }
}
