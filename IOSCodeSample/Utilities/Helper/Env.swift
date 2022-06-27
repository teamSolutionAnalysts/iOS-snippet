//
//  Env.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 20/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import Foundation

enum Environment {
    case development
    case staging
    case production
}

class Env {
    static let shared = Env()
    lazy var environment: Environment = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: ConfigPlistKey.configuration.rawValue) as? String {
            if configuration.contains("Dev") {
                return Environment.development
            } else if configuration.contains("Production") {
                return Environment.production
            } else if configuration.contains("Stage") {
                return Environment.staging
            }
        }
        return Environment.production
    }()
}
