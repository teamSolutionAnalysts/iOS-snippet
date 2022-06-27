//
//  AppConstants.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 20/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

//Storyboards 
enum Storyboard: String {
    case main                 = "main"
    case auth                 = "Auth"
    var filename: String {
        return rawValue
    }
}

//Nibs
enum NibNames: String {
    case customTextField                        = "CustomTextField"
    case customAlertView                        = "CustomAlertView"
}

enum AppConstants {
    //Arrays
    static let userTitleValues          = ["Mr.", "Mrs.", "Miss", "Dr."]
    
    //Others
    static let contentSize              = "contentSize"
    
    //Regex
    static let emailRegex               = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let passwordRegex            = "^(?=.*?[A-Z])(?=.*?[0-9]).{8,15}$"
    static let decimalsRegex            = "^([0-9]+)?(\\.([0-9]+)?)?$"
    
}

//Alert View Constant
enum AlertViewConsts: CGFloat {
    case alertLeadingTrailing = 88
    case alertTop = 36
    case alertBottom = 77
    case alertTextViewPadding = 18
    case alertMaxHeightMinusValue = 270
}

//Error Types
enum ErrorType{
    case mobileEmpty
    case mobileInvalid
    case passwordEmpty
    case passwordInvalid
    case emailEmpty
    case emaiInvalid
    case firstname
    case lastName
    case confirmPassowrd
    case passwordMismatch
    case title
}
