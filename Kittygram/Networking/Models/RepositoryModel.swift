//
//  RepositoryModel.swift
//  Kittygram
//
//  Created by Lukasz Mroz on 20.10.2016.
//  Copyright © 2016 Sunshinejr. All rights reserved.
//

import Mapper

struct Repository: Mappable {
    
    let identifier: Int?
    let language: String?
    let name: String?
    let url: String?
    
    init(map: Mapper) throws {
        identifier = map.optionalFrom("id")
        name = map.optionalFrom("name")
        language = map.optionalFrom("language")
        url = map.optionalFrom("url")
    }
}
