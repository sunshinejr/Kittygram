//
//  UserModel.swift
//  Kittygram
//
//  Created by Lukasz Mroz on 20.10.2016.
//  Copyright © 2016 Sunshinejr. All rights reserved.
//

import Mapper

struct User: Mappable {
    
    let login: String
    
    init(map: Mapper) throws {
        try login = map.from("login")
    }
}
