//
//  PlistHelper.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 20/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import Foundation

class PlistHelper {
    static let shared = PlistHelper()

    func getString(forKey key: ConfigPlistKey) -> String? {
        return Bundle.main.object(forInfoDictionaryKey: key.rawValue) as? String
    }
}
