//
//  EmojisCollectionViewCell.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class EmojisCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageEmoji: UIImageView!
    
    var emoji: EmojiViewModel? {
        didSet {
            if let emoji = emoji {
                let url = URL(string: emoji.url)
                setImageURL(url: url)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setImageURL(url: URL?) {
        imageEmoji.kf.setImage(with: url)
    }
}
