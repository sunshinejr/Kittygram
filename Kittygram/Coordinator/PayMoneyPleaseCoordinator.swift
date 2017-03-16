//
//  PayMoneyPleaseCoordinator.swift
//  Kittygram
//
//  Created by Lukasz Mroz on 22.10.2016.
//  Copyright © 2016 Sunshinejr. All rights reserved.
//

import UIKit

final class PayMoneyPleaseCoordinator: Coordinator {
    
    var appCoordinator: AppCoordinator?
    
    convenience init(navigationController: UINavigationController?, appCoordinator: AppCoordinator?) {
        self.init(navigationController: navigationController)
        
        self.appCoordinator = appCoordinator
    }
    
    func start() {
        let viewController = PayMoneyPleaseViewController()
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func stop() {
        _ = navigationController?.popViewController(animated: true)
        appCoordinator?.payMoneyPleaseCoordinatorCompleted(coordinator: self)
    }
}
