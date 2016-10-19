//
//  PayMoneyPleaseViewController.swift
//  Kittygram
//
//  Created by Lukasz Mroz on 19.10.2016.
//  Copyright © 2016 Sunshinejr. All rights reserved.
//

import UIKit

class PayMoneyPleaseViewController: UIViewController {

    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Hey mate"
        descriptionLabel.text = "💰💸🤑Please pay me money if you want to use this app, thanks! 💰💸🤑"
    }
}
