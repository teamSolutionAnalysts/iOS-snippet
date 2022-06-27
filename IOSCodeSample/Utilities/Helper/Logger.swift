//
//  Logger.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 20/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import Foundation

class Logger {
    static let shared = Logger()

    func log(_ value: Any) {
        if Env.shared.environment == .development || Env.shared.environment == .staging {
            print("-->", value)
        }
    }
} 
