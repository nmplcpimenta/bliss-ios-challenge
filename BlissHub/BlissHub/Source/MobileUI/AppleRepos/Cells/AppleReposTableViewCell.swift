//
//  AppleReposTableViewCell.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 13/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import UIKit

class AppleReposTableViewCell: UITableViewCell {
    
    static let identifier: String = "AppleReposTableViewCell"
    
    @IBOutlet weak var repoName: UILabel!
    
    var appleRepo: AppleRepoViewModel? {
        didSet {
            if let appleRepo = appleRepo {
                self.repoName.text = appleRepo.fullName
            }
        }
    }
}
