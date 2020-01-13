//
//  AppleRepoViewModel.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 13/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation

struct AppleRepoViewModel {
    
    let repoId: String
    let fullName: String
    let isPrivate: Bool
    
    init(fromModel model: AppleRepoModel) {
        self.repoId = model.repoId
        
        if model.fullName.hasPrefix(AppStrings.appleRepoFullnamePrefix) {
            self.fullName = String(model.fullName.dropFirst(AppStrings.appleRepoFullnamePrefix.count))
        } else {
            self.fullName = model.fullName
        }
        
        self.isPrivate = model.isPrivate
    }
    
    func toModel() -> AppleRepoModel {
        return AppleRepoModel(repoId: repoId, fullName: fullName, isPrivate: isPrivate)
    }
}
