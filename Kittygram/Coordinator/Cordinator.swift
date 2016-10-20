//
//  AppCordinator.swift
//  Kittygram
//
//  Created by Lukasz Mroz on 20.10.2016.
//  Copyright © 2016 Sunshinejr. All rights reserved.
//

import Foundation
import UIKit

class Coordinator {
    
    var childCoordinators: [Coordinator] = []
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}
