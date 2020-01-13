//
//  AvatarsCollectionViewCell.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 12/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class AvatarsCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "AvatarsCollectionViewCell"
    
    @IBOutlet weak var imageAvatar: UIImageView!
    
    var avatar: AvatarViewModel? {
        didSet {
            if let avatar = avatar {
                let url = URL(string: avatar.url)
                setImageURL(url: url)
            }
        }
    }
    
    func setImageURL(url: URL?) {
        imageAvatar.kf.setImage(with: url)
    }
}
