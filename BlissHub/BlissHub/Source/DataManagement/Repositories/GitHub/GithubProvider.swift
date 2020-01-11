//
//  GithubProvider.swift
//  BlissHub
//
//  Created by Nuno Pimenta on 11/01/2020.
//  Copyright © 2020 Nuno Pimenta. All rights reserved.
//

import Foundation
import Moya

enum GithubService {
    
    case getEmojis
    case searchUser(username: String)
    case getAppleRepos(page: String, size: Int)
}

extension GithubService: TargetType {
    var baseURL: URL {
        return URL(string: "http://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .getEmojis:
            return "/emojis"
        case .searchUser(let username):
            return "/users/\(username)"
        case .getAppleRepos:
            return "/users/apple/repos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getEmojis, .searchUser, .getAppleRepos:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getEmojis, .searchUser:// Send no parameters
            return .requestPlain
        case .getAppleRepos(let page, let size):
            return .requestParameters(parameters: ["page": page, "size": String(size)], encoding: URLEncoding.queryString)
        }
    }
    
    var sampleData: Data {
        return "Half measures are as bad as nothing at all.".utf8Encoded
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

class GithubProvider {
    static let instance: MoyaProvider<GithubService> = MoyaProvider<GithubService>()
}
