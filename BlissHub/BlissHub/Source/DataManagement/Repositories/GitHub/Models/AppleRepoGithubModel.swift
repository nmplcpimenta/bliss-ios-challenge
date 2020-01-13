//
//  AppleRepoGithubModel.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 13/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation

struct AppleRepoGithubModel: Codable {
    
    // swiftlint:disable identifier_name
    var id: Int
    var full_name: String
    var `private`: Bool
    
    func toModel() -> AppleRepoModel {
        
        return AppleRepoModel(repoId: String(id), fullName: full_name, isPrivate: self.private)
    }
}
