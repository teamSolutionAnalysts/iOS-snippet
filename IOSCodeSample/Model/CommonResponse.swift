//
//  CommonResponse.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 22/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

//MARK: Common Response model
struct CommonResponse: Codable {
    let error: String?
    let message: String?
    let data: JSON?
    let code: Int?
}
