//
//  AppCoordinator.swift
//  Kittygram
//
//  Created by Lukasz Mroz on 21.10.2016.
//  Copyright © 2016 Sunshinejr. All rights reserved.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    
    func start() {
        if arc4random_uniform(3) % 2 == 0 {
            let coordinator = PayMoneyPleaseCoordinator(navigationController: navigationController, appCoordinator: self)
            coordinator.start()
            childCoordinators.append(coordinator)
        } else {
            let coordinator = DashboardCoordinator(navigationController: navigationController)
            coordinator.start()
            childCoordinators.append(coordinator)
        }
    }
    
    func payMoneyPleaseCoordinatorCompleted(coordinator: PayMoneyPleaseCoordinator) {
        // do some stuff before releasing
        if let index = childCoordinators.index(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
    
    func dashboardCoordinatorCompleted(coordinator: DashboardCoordinator) {
        // do some stuff before releasing
        if let index = childCoordinators.index(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}
