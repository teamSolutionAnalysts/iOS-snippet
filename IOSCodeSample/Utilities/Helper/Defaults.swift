//
//  Defaults.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 22/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

enum DefaultsKey: String, CaseIterable {
    case user
}

class UDManager {
    static let shared = UDManager()
    let defaults = UserDefaults.standard
    var user: User?

    func setValue(for key: DefaultsKey, value: Any) {
        defaults.set(value, forKey: key.rawValue)
        defaults.synchronize()
    }
    func getValue(for key: DefaultsKey)-> Any {
        return defaults.value(forKey: key.rawValue) as Any
    }
    func getString(for key: DefaultsKey) -> String? {
        return defaults.string(forKey: key.rawValue)
    }
    
    func getInt(for key: DefaultsKey) -> Int? {
        let int = defaults.integer(forKey: key.rawValue)
        return int > 0 ? int : nil
    }
    
    func getBool(for key: DefaultsKey) -> Bool {
        return defaults.bool(forKey: key.rawValue)
    }
    
    func getDate(for key: DefaultsKey) -> Date? {
        return defaults.value(forKey: key.rawValue) as? Date
    }
    
    func setUserData(json: JSON) {
        do {
            let userData = try json.rawData()
            self.user = try JSONDecoder().decode(User.self, from: userData)
            setValue(for: .user, value: userData)
            
        } catch {
            Logger.shared.log(error.localizedDescription)
        }
        
    }
    
    func getUserData() {
        if let userData = defaults.value(forKey: DefaultsKey.user.rawValue) as? Data {
            do {
                self.user = try JSONDecoder().decode(User.self, from: userData)
            } catch {
                Logger.shared.log("error-->" + error.localizedDescription)
            }
        }
    }
    
    
    
    func updateUserData() {
        do {
            let userData = try JSONEncoder().encode(user)
            defaults.set(userData, forKey: DefaultsKey.user.rawValue)
            defaults.synchronize()
        } catch {
            Logger.shared.log(error.localizedDescription)
        }
    }
    

    func removeAllValues(_ exceptKeys: [DefaultsKey] = []) {
        DefaultsKey.allCases.forEach { key in
            if !exceptKeys.contains(key) {
                defaults.removeObject(forKey: key.rawValue)
            }
        }
    }
    
   
}
