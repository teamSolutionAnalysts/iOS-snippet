//
//  UIViewController.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 22/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

enum NavigationType: Int { case clearNavigationType = 0, colouredNavigationType = 1, none = 2}

extension UIViewController{
    
    // MARK: - Navigation Setup
    func setNavigationBar(_ typeNavigation: NavigationType) {
        if typeNavigation == NavigationType.clearNavigationType {
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.barStyle = UIBarStyle.default
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            self.navigationController?.navigationBar.tintColor = .black
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }else if typeNavigation == .colouredNavigationType{
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.barStyle = UIBarStyle.default
            self.navigationController?.navigationBar.barTintColor = .white
            self.navigationController?.navigationBar.tintColor = UIColor.black
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        } else if   typeNavigation == .none{
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        } else {
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.barStyle = UIBarStyle.default
            self.navigationController?.navigationBar.barTintColor = .white
            self.navigationController?.navigationBar.tintColor = .black
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }

        //Back icon custome
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_leftArrow")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ic_leftArrow")
        //removing title of back button
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
    }
    
    func setCounstraintsToPickers(toView: UIView, respectedView: UIAlertController) {
        toView.translatesAutoresizingMaskIntoConstraints = false
        toView.topAnchor.constraint(equalTo: respectedView.view.topAnchor, constant: 10).isActive = true
        toView.rightAnchor.constraint(equalTo: respectedView.view.rightAnchor, constant: -10).isActive = true
        toView.leftAnchor.constraint(equalTo: respectedView.view.leftAnchor, constant: 10).isActive = true
        toView.heightAnchor.constraint(equalToConstant: 215).isActive = true
        
        respectedView.view.translatesAutoresizingMaskIntoConstraints = false
        respectedView.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
}
