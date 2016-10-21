//
//  KittyTableViewModel.swift
//  Kittygram
//
//  Created by Lukasz Mroz on 22.10.2016.
//  Copyright © 2016 Sunshinejr. All rights reserved.
//

import RxSwift

final class KittyTableViewModel: KittyTableViewModelType {
    
    let name: Observable<String>
    
    init(kitty: Repository) {
        name = .just(kitty.name ?? "no-name 😢")
    }
}
