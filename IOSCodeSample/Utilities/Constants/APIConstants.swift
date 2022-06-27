//
//  APIConstants.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 22/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

enum ApiConsts {
    enum Path {
        enum UserService {
            static let authEndPoint          = "auth/"
            
            static let signUp                = authEndPoint + "sign-up"
            static let signIn                = authEndPoint + "sign-in"
        }
    }
    
    enum Header {
        static let appJson: [String: String] = ["Content-Type": "application/json"]
        static let appJsonar: [String: String] = ["Content-Type": "application/json; charset=utf-8"]
    }
    
    enum Params {
        static let firstname                = "firstname"
        static let lastname                 = "lastname"
        static let email                    = "email"
        static let mobileNumber             = "mobileNumber"
        static let password                 = "password"
        static let title                    = "title"
        static let message                  = "message"
        static let country                  = "country"
        static let countryCode              = "countryCode"
    }
}
