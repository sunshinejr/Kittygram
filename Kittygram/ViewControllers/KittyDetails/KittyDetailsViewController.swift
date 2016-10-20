//
//  KittyDetailsViewController.swift
//  Kittygram
//
//  Created by Lukasz Mroz on 21.10.2016.
//  Copyright © 2016 Sunshinejr. All rights reserved.
//

import UIKit

class KittyDetailsViewController: UIViewController {

    var kitty: Repository!
    
    convenience init(kitty: Repository) {
        self.init()
        
        self.kitty = kitty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
