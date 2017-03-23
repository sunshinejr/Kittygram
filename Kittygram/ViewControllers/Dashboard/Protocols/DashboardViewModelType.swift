//
//  DashboardViewModelType.swift
//  Kittygram
//
//  Created by Lukasz Mroz on 22.10.2016.
//  Copyright © 2016 Sunshinejr. All rights reserved.
//

import RxSwift

protocol DashboardViewModelType {
    var errorObservable: Observable<String> { get }
    var reposObservable: Observable<[KittyTableViewModelType]> { get }
    var itemSelected: PublishSubject<IndexPath> { get }
}
