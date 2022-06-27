//
//  LoginViewModel.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 22/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import UIKit
import Moya

class LoginViewModel: NSObject {
    
    //Properties
    var mobile: String?
    var password: String?
    var mobileCode: String?
    
    fileprivate let userService = MoyaProvider<UserService>()// service for api
    var error : DynamicValue<ErrorType?> = DynamicValue<ErrorType?>(nil)// error handler
    
    // MARK: - Validate user data
    func isValidInputsData() -> Bool {
        if mobile?.isBlank ?? true {
            error.value = .mobileEmpty
            return false
        } else if !Helper.isValidPhoneNumber(phoneNumber: mobileCode! + mobile!) {
            error.value = .mobileInvalid
            return false
        } else  if password?.isBlank ?? true {
            error.value = .passwordEmpty
            return false
        }
        error.value = .none
        return true
    }
    
    // MARK: - Login api 
    func login(completion: @escaping (_ sucsses: Bool, _ message:String? ) -> Void)  {
        guard let mobileCode = mobileCode, let mobile = mobile, let password = password else {
            return
        }
        userService.request(.signIn(countryCode: mobileCode , mobileNumber: mobile, password: password)) { result in
            ApiServices.shared.handleServices(result: result) { success, error, response in
                if success, let responseJson = response {
                    let userDefaults = UDManager.shared
                    userDefaults.setUserData(json: responseJson)
                    completion(true,nil)
                }else{
                    completion(false,error)
                }
            }
        }
        
    }
}
