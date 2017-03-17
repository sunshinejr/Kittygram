//
//  DashboardCoordinator.swift
//  Kittygram
//
//  Created by Lukasz Mroz on 22.10.2016.
//  Copyright © 2016 Sunshinejr. All rights reserved.
//

import UIKit

final class DashboardCoordinator: Coordinator {
    
    func start() {
        let viewModel = DashboardViewModel(delegate: self)
        let viewController = DashboardViewController(viewModel: viewModel)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension DashboardCoordinator: DashboardViewControllerDelegate {
    func kittySelected(repo: Repository) {
        if repo.name != "swift" {
            let viewModelKitty = KittyDetailsViewModel(repository: repo)
            let viewController = KittyDetailsViewController(viewModel: viewModelKitty)
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            print("Unexpected behavior")
        }
    }
}
