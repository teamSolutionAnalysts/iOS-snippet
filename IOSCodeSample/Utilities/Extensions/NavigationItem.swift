//
//  NavigationItem.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 23/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UINavigationItem
extension UINavigationItem {
    
    func logoutButton(viewController: UIViewController? = nil, logoutAction: Selector? = nil) {
        ///Right BarButton Items
        let firstRightBarButtonItem = self.createUIBarButtonItem(targetVC: viewController,
                                                                 image: AppImages.logout,
                                                                 action: logoutAction,
                                                                 enableBadge: false,
                                                                 changeBadgePosition: true)
        
        self.setRightBarButtonItems([firstRightBarButtonItem], animated: true)
    }
    
    ///To create a barbutton with the help of UIButton and it's custom type
    func createUIBarButtonItem(targetVC: UIViewController? = nil,
                               image: UIImage?, title: String? = nil,
                               action: Selector? = nil,
                               contentHorizontalAlignment: UIControl.ContentHorizontalAlignment = .center,
                               enableBadge: Bool = false,
                               changeBadgePosition: Bool = false,
                               count: Int =  0, size: CGSize = CGSize(width: 40, height: 40)) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        button.addConstraint(NSLayoutConstraint(item: button,
                                                attribute: NSLayoutConstraint.Attribute.width,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                multiplier: 1,
                                                constant: size.width))
        button.addConstraint(NSLayoutConstraint(item: button,
                                                attribute: NSLayoutConstraint.Attribute.height,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                multiplier: 1,
                                                constant: size.height))
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.setTitle(title != nil ? title : "", for: .normal)
        button.titleLabel?.font = AppFonts.Regular.font(size: FontSize.description)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(AppColors.appPrimaryColor, for: .normal)
        button.alignVertical(spacing: 4.0)
        button.sizeToFit()
        if enableBadge {
            let badgeViewX =  changeBadgePosition ? -3 : button.frame.maxX
            let badgeWidth:CGFloat = count > 99 ? 25.0 : 18.0
            let badgeView = UIView(frame: CGRect(x: badgeViewX , y: 3, width: badgeWidth, height: 18))
            print(badgeView)
            badgeView.backgroundColor = AppColors.appPrimaryColor
            badgeView.layer.borderColor = UIColor.white.cgColor
            badgeView.layer.borderWidth = 1
            badgeView.layer.cornerRadius = badgeView.frame.height / 2
            
            let badgeCount = UILabel(frame: CGRect(x: 0, y: 0, width: badgeWidth, height: 18))
            badgeView.isHidden = !(count > 0)
            let strCount = count > 99 ? "99+" : String(count)
            badgeCount.setAppLabel(content: strCount,
                                   fontName: .Medium,
                                   fontSize: FontSize.description,
                                   fontColor: UIColor.white)
            badgeCount.textAlignment = .center
            badgeCount.adjustsFontSizeToFitWidth = true
            badgeCount.minimumScaleFactor = 0.8
            badgeView.isUserInteractionEnabled = false
            badgeCount.isUserInteractionEnabled = false
            badgeView.addSubview(badgeCount)
            button.addSubview(badgeView)
        }
        if let action = action {
            button.addTarget(targetVC, action: action, for: .touchUpInside)
        }
        button.contentHorizontalAlignment = contentHorizontalAlignment
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }
}
