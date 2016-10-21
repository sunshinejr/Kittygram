//
//  KittyTableViewModelType.swift
//  Kittygram
//
//  Created by Lukasz Mroz on 22.10.2016.
//  Copyright © 2016 Sunshinejr. All rights reserved.
//

import RxSwift

protocol KittyTableViewModelType {
    var name: Observable<String> { get }
}
