//
//  BaseViewController.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 23/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var backgroundView: UIView?// it will hold ViewController's main view or any view as background view which occupies entire screen , so we can set theme for all screen from here
    
    /* This will add custom screen title */
    var titleText: String?
    var titleColor = AppColors.appPrimaryColor
    
    //MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreenBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(.colouredNavigationType)
        setUpNavigationBarTitle()
    }
    
    
    //MARK: Setup background & Navigation
    func setupScreenBackground(){
        guard let bgView = self.backgroundView else { return }
        bgView.backgroundColor = .white
    }
    
    func setUpNavigationBarTitle() {
        if let titleValue = titleText, !titleValue.isEmpty {
            let labelView = UILabel()
            labelView.setAppLabel(content: titleValue, fontName: AppFonts.Bold,
                                  fontSize: FontSize.additionInfoDescription, fontColor: titleColor ,alignment: .center)
            labelView.numberOfLines = 2
            navigationItem.titleView = labelView
        }
    }
    
    
}
