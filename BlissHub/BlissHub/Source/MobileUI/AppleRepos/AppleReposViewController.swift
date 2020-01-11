//
//  AppleReposViewController.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import UIKit

class AppleReposViewController: UIViewController {
    
    var presenter: AppleReposPresenterContract?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let pre = Scene.appleRepos.configure() as? AppleReposPresenterContract {
            presenter = pre
        } else {
            fatalError("Unable to initialize presenter for AppleRepos module")
        }
    }
}
