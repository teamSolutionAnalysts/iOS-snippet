//
//  User.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 22/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import Foundation

// MARK: - User Data Model
class User: NSObject, Codable {
    var id: Int?
    var title: String?
    var firstname: String?
    var lastname: String?
    var mobileNumber: String?
    var email: String?
    var profileImage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case firstname
        case lastname
        case mobileNumber
        case email
        case profileImage
    }
}
