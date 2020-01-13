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
    case getUser(username: String)
    case getAppleRepos(page: Int, size: Int)
}

extension GithubService: TargetType {
    var baseURL: URL {
        return URL(string: AppStrings.githubAPIURLBase)!
    }
    
    var path: String {
        switch self {
        case .getEmojis:
            return AppStrings.githubAPIURLEmojis
        case .getUser(let username):
            return AppStrings.githubAPIURLAvatars + username
        case .getAppleRepos:
            return AppStrings.githubAPIURLAppleRepos
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getEmojis, .getUser, .getAppleRepos:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getEmojis, .getUser:// Send no parameters
            return .requestPlain
        case .getAppleRepos(let page, let size):
            return .requestParameters(parameters:
                [AppStrings.githubAPIURLAppleReposArgPage: String(page),
                 AppStrings.githubAPIURLAppleReposArgPerPage: String(size)],
              encoding: URLEncoding.queryString)
        }
    }
    
    var sampleData: Data {
        return AppStrings.githubAPIURLSampleData.utf8Encoded
    }
    
    var headers: [String: String]? {
        return [AppStrings.githubAPIURLContentTypeKey: AppStrings.githubAPIURLContentTypeAppJSON]
    }
}

class GithubProvider {
    static let instance: MoyaProvider<GithubService> = MoyaProvider<GithubService>(plugins: [NetworkLoggerPlugin()])
}
