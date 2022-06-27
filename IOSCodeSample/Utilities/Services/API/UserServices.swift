//
//  UserServices.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 22/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import Foundation
import Moya
import NVActivityIndicatorView

let userService = MoyaProvider<UserService>()

enum UserService {
    case signUp(parameters:[String : Any])
    case signIn(countryCode: String, mobileNumber: String, password: String)
   
}

extension UserService: TargetType {
    var sampleData: Data {
        return Data()
    }

    var baseURL: URL {
        return URL(string: (PlistHelper.shared.getString(forKey: .baseUrl)!))!
    }

    var path: String {
        switch self {
        case .signUp:
            return ApiConsts.Path.UserService.signUp
        case .signIn:
            return ApiConsts.Path.UserService.signIn
        }
    }

    var method: Moya.Method {
        switch self {
        case .signUp, .signIn:
            return .post
        }
    }

    var task: Task {
        let param = ApiConsts.Params.self
        ApiServices.shared.showLoader()
        switch self {
    
        case .signUp(let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
           
        case .signIn(let countryCode, let mobileNumber, let password):
            return .requestParameters(parameters: [param.countryCode: countryCode.trimmed(),
                                                   param.mobileNumber: mobileNumber.trimmed(),
                                                   param.password: password.trimmed()], encoding: JSONEncoding.default)
       
        }
    }

    var headers: [String: String]? {
        return ApiServices.shared.authHeader
    }
}

