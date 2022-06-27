//
//  RegistrationViewModel.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 23/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import UIKit
import Moya

class RegistrationViewModel: NSObject {
    //Properties
    var userTitle: String?
    var firstName: String?
    var lastName: String?
    var countryName: String?
    var mobileCode: String?
    var mobile: String?
    var email: String?
    var password: String?
    var confirmPassword: String?
    
    
    fileprivate let userService = MoyaProvider<UserService>()// service for api
    var error : DynamicValue<ErrorType?> = DynamicValue<ErrorType?>(nil)// error handler
    
    // MARK: - Validate user data
    func isValidInputsData() -> Bool {
        var isValid = [Bool]()
        if userTitle?.isBlank ?? true {
            isValid.append(false)
            error.value = .title
        }else{
            isValid.append(true)
        }
        
        if firstName?.isEmpty ?? false {
            error.value = .firstname
            isValid.append(false)
        } else {
            isValid.append(true)
        }
        
        if lastName?.isEmpty ?? false {
            error.value = .lastName
            isValid.append(false)
        } else {
            isValid.append(true)
        }
        
        if mobile?.isBlank ?? true   {
            error.value = .mobileEmpty
            isValid.append(false)
        } else if !Helper.isValidPhoneNumber(phoneNumber: mobileCode! + mobile!) {
            error.value = .mobileInvalid
            isValid.append(false)
        }else{
            isValid.append(true)
        }
        
        if email?.isEmpty ?? false {
            error.value = .emailEmpty
            isValid.append(false)
        } else if !(email?.isValidEmail() ?? false) {
            error.value = .emaiInvalid
            isValid.append(false)
        } else {
            isValid.append(true)
        }
        
        if password?.isBlank ?? true {
            error.value = .passwordEmpty
            isValid.append(false)
        }else if confirmPassword?.isBlank ?? true {
            error.value = .confirmPassowrd
            isValid.append(false)
        } else if password != confirmPassword {
            error.value = .passwordMismatch
            isValid.append(false)
        }else{
            isValid.append(true)
        }
        
        return !isValid.contains(false)
    }
    
    // MARK: - signup api
    func signUp(completion: @escaping (_ sucsses: Bool, _ message:String? ) -> Void)  {
        guard let mobileCode = mobileCode, let mobile = mobile, let title = userTitle, let firstName = firstName, let lastName = lastName, let email = email, let password = password else {
            return
        }
        let param = ApiConsts.Params.self
        let params = [param.title: title.trimmed(),
                      param.firstname: firstName.trimmed(),
                      param.lastname: lastName.trimmed(),
                      param.email: email.trimmed(),
                      param.mobileNumber: mobile.trimmed(),
                      param.countryCode: mobileCode.trimmed(),param.password: password] as [String : Any]
        
        userService.request(.signUp(parameters: params)) { result in
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
