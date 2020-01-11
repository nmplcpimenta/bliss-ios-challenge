//
//  EmojisViewController.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 10/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import UIKit

class EmojisViewController: UIViewController {

    var presenter: EmojisPresenterContract?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let pre = Scene.emojis.configure() as? EmojisPresenterContract {
            presenter = pre
        } else {
            fatalError("Unable to initialize presenter for Emojis module")
        }
    }
}
