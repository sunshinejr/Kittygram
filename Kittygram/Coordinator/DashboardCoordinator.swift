//
//  DashboardCoordinator.swift
//  Kittygram
//
//  Created by Lukasz Mroz on 22.10.2016.
//  Copyright © 2016 Sunshinejr. All rights reserved.
//

import UIKit
import RxSwift

final class DashboardCoordinator: Coordinator {
    var kittySelected = PublishSubject<Repository>()
    let disposeBag = DisposeBag()
    
    override init(navigationController: UINavigationController?) {
        super.init(navigationController: navigationController)
        
        kittySelected
            .subscribe(onNext: { repo in
                if repo.name != "swift" {
                    let viewModelKitty = KittyDetailsViewModel(repository: repo)
                    let viewController = KittyDetailsViewController(viewModel: viewModelKitty)
                    self.navigationController?.pushViewController(viewController, animated: true)
                } else {
                    print("Unexpected behavior")
                }
            }).addDisposableTo(disposeBag)
    }
    
    func start() {
        let viewModel = DashboardViewModel()
        let viewController = DashboardViewController(viewModel: viewModel)
        
        viewModel.kittySelected.asObservable()
            .bindTo(kittySelected)
            .addDisposableTo(disposeBag)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

