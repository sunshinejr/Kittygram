//
//  GitHub.swift
//  Kittygram
//
//  Created by Lukasz Mroz on 20.10.2016.
//  Copyright © 2016 Sunshinejr. All rights reserved.
//

import Moya

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

enum GitHub {
    case zen
    case userProfile(String)
    case userRepositories(String)
    case userRepository(String)
}

extension GitHub: TargetType {
    
    var baseURL: URL { return URL(string: "https://api.github.com")! }
    
    var path: String {
        switch self {
        case .userRepositories(let name):
            return "/users/\(name.URLEscapedString)/repos"
        case .zen:
            return "/zen"
        case .userProfile(let name):
            return "/users/\(name.URLEscapedString)"
        case .userRepository(let name):
            return "/repos/\(name)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var headers: [String : String]? {
        return [
            "Accept": "application/json",
            "Accept-Language": "",
            "Content-Type": "application/json"
        ]
    }
    
    var sampleData: Data {
        switch self {
        case .userRepositories(_):
            return "{{\"id\": \"1\", \"language\": \"Swift\", \"url\": \"https://api.github.com/repos/mjacko/Router\"}}".data(using: .utf8)!
        case .zen:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        case .userProfile(let name):
            return "{\"login\": \"\(name)\", \"id\": 100}".data(using: String.Encoding.utf8)!
        case .userRepository(_):
            return "{\"id\": \"1\", \"language\": \"Swift\", \"url\": \"https://api.github.com/repos/mjacko/Router\", \"name\": \"Router\"}".data(using: .utf8)!
        }
    }
    
    var task: Task {
        return .requestPlain
    }
    
}
