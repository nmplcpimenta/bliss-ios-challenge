//
//  AvatarsViewController.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import UIKit

class AvatarsViewController: UIViewController {
    
    var presenter: AvatarsPresenterContract?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let pre = Scene.avatars.configure() as? AvatarsPresenterContract {
            presenter = pre
        } else {
            fatalError("Unable to initialize presenter for Avatars module")
        }
    }
}
