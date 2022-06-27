//
//  AppLanguageConstant.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 22/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//


import Foundation

enum AppLanguageConstants: String {
   
    case enterMobileNo
    case mobileNumber
    case emailAddress
    case password
    case login
    case forgotPassword
    case dontHaveAccount
    case registerNow
    case userTitle
    case firstName
    case lastName
    case enterEmail
    case chooseYourTitle
    case chooseYourCountryCode
    case enterPassword
    case confirmPassword
    case mrTitle = "Mr."
    case mrsTitle = "Mrs."
    case msTitle = "Miss"
    case drTitle = "Dr."
    case phoneDesc
    case passwordDesc
    case done
    case passwordConfirm
    case yes
    case no
    case ok
    case largeImageSize
    case tryAgainLater
    case noInternet
    case noCountryCode
    case noMobileNumber
    case validMobileNumber
    case noPassword
    case validPassword
    case noConfirmPassword
    case noMatchOnPasswords
    case noUserTitle
    case noFirstName
    case noLastName
    case noEmailAddress
    case validEmailAddress
    case home
    case logoutDesc
    
    
    
    
    
    
    
    
    
    func localized() -> String {
        let path = Bundle.main.path(forResource: "en", ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self.rawValue, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
   
}

