//
//  HomeViewController.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 23/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    //MARK: View Cycle
    override func viewDidLoad() {
        intitialSetup()
        super.viewDidLoad()
        
    }
    
    //MARK: setup UI
    func intitialSetup(){
        backgroundView = view
        titleText = AppLanguageConstants.home.localized()
        self.navigationItem.logoutButton(viewController: self, logoutAction: #selector(self.logoutButtonTapped))
    }
    
    //MARK: Button Action 
    @objc func logoutButtonTapped() {
        AlertView.shared.displayCustomAlertWithTwoButtons(message: AppLanguageConstants.logoutDesc.localized(),
                                                          btnDoneTapped: {
            
        }, btnCancelTapped: {
            let loginVC: LoginViewController = UIStoryboard(storyboard: .auth).instantiate()
            Navigator.shared.changeRootVC(UINavigationController(rootViewController: loginVC))
        })
    }
}
