//
//  Helper.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 20/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import Foundation
import PhoneNumberKit

class Helper {
    static func getLocalizedString(localizedKey: String) -> String {
        return NSLocalizedString(localizedKey, comment: "")
    }
    
    //Validate phone number
    static func isValidPhoneNumber(phoneNumber: String = "") -> Bool {
        let phoneNumberKit = PhoneNumberKit()
        return phoneNumberKit.isValidPhoneNumber(phoneNumber)
    }
    
    static func iOS13OrLater() -> Bool {
        if #available(iOS 13, *) {
            return true
        }
        return false
    }
    
    
    static func openDeviceSetting(complete: @escaping () -> Void = {}) {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl) { success in
                complete()
            }
        }
    }
    
    static func isValidUrl(urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }
    
}

