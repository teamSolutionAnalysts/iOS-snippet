//
//  Navigator.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 23/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import UIKit

class Navigator{
    
    static let shared = Navigator()
    
    func setRootVC(aWindow: UIWindow?) {
        let aWindow = aWindow ?? appDelegate?.window
        let loginVC: LoginViewController = UIStoryboard(storyboard: .auth).instantiate()
        if #available(iOS 13.0, *) {
            guard let aScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return
            }
            aWindow?.windowScene = aScene
        }
        aWindow?.rootViewController = UINavigationController(rootViewController: loginVC)
        aWindow?.makeKeyAndVisible()
    }
    
    func changeRootVC( _ viewController: UIViewController) {
        DispatchQueue.main.async {
            if #available(iOS 13.0, *) {
                let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as? SceneDelegate
                sceneDelegate?.window!.rootViewController = viewController
            } else { // iOS12 or earlier
                UIApplication.shared.windows.first?.rootViewController = viewController
            }
        }
    }
}
