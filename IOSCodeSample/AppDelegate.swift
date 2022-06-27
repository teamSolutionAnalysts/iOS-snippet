//
//  AppDelegate.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 20/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

let appDelegate = UIApplication.shared.delegate as? AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        doInitialSetUp()
        return true
    }

    //MARK:- Initial setup
    func doInitialSetUp(){
        //Set Root VC
        if !Helper.iOS13OrLater() {
            Navigator.shared.setRootVC(aWindow: window)
        }
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        Logger.shared.log("Current Env: \(Env.shared.environment)")
    }

    
}

