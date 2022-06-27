//
//  AlertView.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 22/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit
class AlertView {
    static let shared = AlertView()
    var currentCustomAlertView: CustomAlertView?

    // MARK: - Alert with TWO button
    func displayCustomAlertWithTwoButtons(title: String = PlistHelper.shared.getString(forKey: .appName) ?? "",
                                          message: String,
                                          buttonOneTitle: String = AppLanguageConstants.yes.localized(),
                                          buttonTwoTitle: String = AppLanguageConstants.no.localized(),
                                          showMultipleAlert: Bool = false,
                                          shouldDismissOne: Bool = true,
                                          shouldDismissTwo: Bool = true,
                                          btnDoneTapped: @escaping (() -> Void),
                                          btnCancelTapped: @escaping (() -> Void)) {
        let customeAlertView = loadFromNibNamed(NibNames.customAlertView.rawValue) as? CustomAlertView
        customeAlertView?.frame = UIScreen.main.bounds

        //Title & Message
        customeAlertView?.labelAlertTitle.text = title
        customeAlertView?.txtViewAlertMessage.text = message
        customeAlertView?.txtViewAlertMessage.textAlignment = .center
        //Alert Display Button Type
        customeAlertView?.alertButtonDisplayType(displayType: .doubleButton,
                                                 isWithBottomOptions: false,
                                                 shouldDismissOne: shouldDismissOne,
                                                 shouldDismissTwo: shouldDismissTwo)

        //Cancel Button Title & Closure
        customeAlertView?.btnCancel.setTitle(buttonOneTitle, for: UIControl.State())
        customeAlertView?.cancelButtonTapped = {
            btnCancelTapped()
        }

        //Done Button Title & Closure
        customeAlertView?.btnDone.setTitle(buttonTwoTitle, for: UIControl.State())
        customeAlertView?.doneButtonTapped = {
            btnDoneTapped()
        }

        customeAlertView?.checkAlertPopupHeightValidation()
        addViewOnTopViewController(customView: customeAlertView!, showMultipleAlert: showMultipleAlert)
    }

    // MARK: - Alert with ONE button
    func displayCustomAlertWithOneButton(title: String = PlistHelper.shared.getString(forKey: .appName) ?? "",
                                         message: String,
                                         btnTitle: String? = AppLanguageConstants.ok.localized(),
                                         showMultipleAlert: Bool = false,
                                         shouldDismiss: Bool = true,
                                         btnDismissTapped: @escaping (() -> Void)) {
        let customeAlertView = loadFromNibNamed(NibNames.customAlertView.rawValue) as? CustomAlertView
        customeAlertView?.frame = UIScreen.main.bounds

        //Title & Message
        
        customeAlertView?.labelAlertTitle.text = title
        customeAlertView?.txtViewAlertMessage.text = message
        customeAlertView?.txtViewAlertMessage.textAlignment = .center
        //Alert Display Button Type
        if let buttonTitle = btnTitle {
            customeAlertView?.alertButtonDisplayType(displayType: .singleButton,
                                                     isWithBottomOptions: false,
                                                     shouldDismiss: shouldDismiss,
                                                     singleButtonTitle: buttonTitle)
        } else {
            customeAlertView?.alertButtonDisplayType(displayType: .singleButton,
                                                     isWithBottomOptions: false,
                                                     shouldDismiss: shouldDismiss)
        }

        //Dismiss Button Title & Closure
        customeAlertView?.dismissButtonTapped = {
            btnDismissTapped()
        }

        customeAlertView?.checkAlertPopupHeightValidation()
        addViewOnTopViewController(customView: customeAlertView!, showMultipleAlert: showMultipleAlert)
    }

    // MARK: - Alert with ONE button and one/two bottom buttons
    func displayCustomAlertWithImageAndBottomOptions(title: String =
        PlistHelper.shared.getString(forKey: .appName) ?? "",
                                                     image: UIImage? = nil,
                                                     message: String,
                                                     titleDismiss: String = AppLanguageConstants.done.localized(),
                                                     titleOptionOne: String = "",
                                                     titleOptionTwo: String = "",optionTwoTitleColor:UIColor = AppColors.textThemeColor,
                                                     btnDismissTapped: @escaping (() -> Void),
                                                     btnOptionOneTapped: @escaping (() -> Void),
                                                     btnOptionTwoTapped: @escaping (() -> Void)) {
        let customeAlertView = loadFromNibNamed(NibNames.customAlertView.rawValue) as? CustomAlertView
        customeAlertView?.frame = UIScreen.main.bounds
        currentCustomAlertView = customeAlertView

        //Title & Message & Image
        customeAlertView?.labelAlertTitle.text = title
        customeAlertView?.txtViewAlertMessage.text = message
        customeAlertView?.imageSuperViewConstraint.constant = (image != nil) ? 80 : 30
        customeAlertView?.imageAlert.image = image
        customeAlertView?.txtViewAlertMessage.textAlignment = .center
        //Alert Display Button Type
        customeAlertView?.alertButtonDisplayType(displayType: .singleButton,
                                                 isWithBottomOptions: true,
                                                 singleButtonTitle: titleDismiss)

        //Dismiss Button Closure
        customeAlertView?.dismissButtonTapped = {
            btnDismissTapped()
        }

        //Bottom Options 1 Button Title & Closure
        customeAlertView?.buttonOptionOne.setAppButton(title: titleOptionOne,
                                                       bgColor: .clear,
                                                       isBorder: false,
                                                       cornerRadius: 0.0,
                                                       isShadow: false,
                                                       fontSize: FontSize.title,
                                                       fontColor: AppColors.textThemeColor)
        customeAlertView?.optionOneButtonTapped = {
            btnOptionOneTapped()
        }

        //Bottom Options 2 Button Title & Closure
        customeAlertView?.buttonOptionTwo.setAppButton(title: titleOptionTwo,
                                                       bgColor: .clear,
                                                       isBorder: false,
                                                       cornerRadius: 0.0,
                                                       isShadow: false,
                                                       fontSize: FontSize.title,
                                                       fontColor: optionTwoTitleColor)
        customeAlertView?.optionTwoButtonTapped = {
            btnOptionTwoTapped()
        }

        customeAlertView?.checkAlertPopupHeightValidation()
        addViewOnTopViewController(customView: customeAlertView!)
    }
    func displayCustomAlertWithImageAndBottomOptionsOnWindow(title: String =
        PlistHelper.shared.getString(forKey: .appName) ?? "",
                                                     image: UIImage? = nil,
                                                     message: String,
                                                     titleDismiss: String = AppLanguageConstants.done.localized(),
                                                     titleOptionOne: String = "",
                                                     titleOptionTwo: String = "",optionTwoTitleColor:UIColor = AppColors.textThemeColor,
                                                     btnDismissTapped: @escaping (() -> Void),
                                                     btnOptionOneTapped: @escaping (() -> Void),
                                                     btnOptionTwoTapped: @escaping (() -> Void)) {
        let customeAlertView = loadFromNibNamed(NibNames.customAlertView.rawValue) as? CustomAlertView
        customeAlertView?.frame = UIScreen.main.bounds
        currentCustomAlertView = customeAlertView

        //Title & Message & Image
        customeAlertView?.labelAlertTitle.text = title
        customeAlertView?.txtViewAlertMessage.text = message
        customeAlertView?.imageSuperViewConstraint.constant = (image != nil) ? 80 : 30
        customeAlertView?.imageAlert.image = image
        customeAlertView?.txtViewAlertMessage.textAlignment = .center
        //Alert Display Button Type
        customeAlertView?.alertButtonDisplayType(displayType: .singleButton,
                                                 isWithBottomOptions: true,
                                                 singleButtonTitle: titleDismiss)

        //Dismiss Button Closure
        customeAlertView?.dismissButtonTapped = {
            btnDismissTapped()
        }

        //Bottom Options 1 Button Title & Closure
        customeAlertView?.buttonOptionOne.setAppButton(title: titleOptionOne,
                                                       bgColor: .clear,
                                                       isBorder: false,
                                                       cornerRadius: 0.0,
                                                       isShadow: false,
                                                       fontSize: FontSize.title,
                                                       fontColor: AppColors.textThemeColor)
        customeAlertView?.optionOneButtonTapped = {
            btnOptionOneTapped()
        }

        //Bottom Options 2 Button Title & Closure
        customeAlertView?.buttonOptionTwo.setAppButton(title: titleOptionTwo,
                                                       bgColor: .clear,
                                                       isBorder: false,
                                                       cornerRadius: 0.0,
                                                       isShadow: false,
                                                       fontSize: FontSize.title,
                                                       fontColor: optionTwoTitleColor)
        customeAlertView?.optionTwoButtonTapped = {
            btnOptionTwoTapped()
        }

        customeAlertView?.checkAlertPopupHeightValidation()
        addViewOnTopWindow(customView: customeAlertView!, showMultipleAlert: true)
    }
    func loadFromNibNamed(_ nibNamed: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(nibName: nibNamed, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }

    func addViewOnTopViewController(customView: UIView, showMultipleAlert: Bool = false) {
        DispatchQueue.main.async(execute: {
            guard let navVC = UIApplication.shared.windows.first?.rootViewController as? UINavigationController,
                !(navVC.topViewController?.presentedViewController?.isKind(of: UIViewController.self) ?? false)
                else { return }
            customView.alpha = 0.0
            customView.tag = 98

            if let addedView = UIApplication.topViewController()?.navigationController?.view.viewWithTag(98), !showMultipleAlert {
                addedView.removeFromSuperview()
            }
            UIApplication.topViewController()?.navigationController?.view.addSubview(customView)
            UIApplication.topViewController()?.navigationController?.view.bringSubviewToFront(customView)

            UIView.animate(withDuration: 0.3, delay: 0.0, options: .transitionCurlUp, animations: {
                UIApplication.shared.statusBarView?.backgroundColor = UIColor(white: 0.35, alpha: 0.0)
                customView.transform = CGAffineTransform(scaleX: 1, y: 1)
                customView.alpha = 1.0
            }, completion: { animate in
            })
        })
    }
    func displayCustomAlertWithOneButtonOnTopOfWindow(title: String = PlistHelper.shared.getString(forKey: .appName) ?? "",
                                         message: String,
                                         btnTitle: String? = AppLanguageConstants.ok.localized(),
                                         showMultipleAlert: Bool = false,
                                         shouldDismiss: Bool = true,
                                         btnDismissTapped: @escaping (() -> Void)) {
        let customeAlertView = loadFromNibNamed(NibNames.customAlertView.rawValue) as? CustomAlertView
        customeAlertView?.frame = UIScreen.main.bounds

        //Title & Message
        
        customeAlertView?.labelAlertTitle.text = title
        customeAlertView?.txtViewAlertMessage.text = message
        customeAlertView?.txtViewAlertMessage.textAlignment = .center
        //Alert Display Button Type
        if let buttonTitle = btnTitle {
            customeAlertView?.alertButtonDisplayType(displayType: .singleButton,
                                                     isWithBottomOptions: false,
                                                     shouldDismiss: shouldDismiss,
                                                     singleButtonTitle: buttonTitle)
        } else {
            customeAlertView?.alertButtonDisplayType(displayType: .singleButton,
                                                     isWithBottomOptions: false,
                                                     shouldDismiss: shouldDismiss)
        }

        //Dismiss Button Title & Closure
        customeAlertView?.dismissButtonTapped = {
            btnDismissTapped()
        }

        customeAlertView?.checkAlertPopupHeightValidation()
        addViewOnTopWindow(customView: customeAlertView!, showMultipleAlert: showMultipleAlert)
    }
    func addViewOnTopWindow(customView: UIView, showMultipleAlert: Bool = false) {
        DispatchQueue.main.async(execute: {
            guard let navVC = UIApplication.shared.windows.first?.rootViewController as? UINavigationController,
                !(navVC.topViewController?.presentedViewController?.isKind(of: UIViewController.self) ?? false)
                else { return }
            customView.alpha = 0.0
            customView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            customView.tag = 98
            let viewFrameY = UIApplication.topViewController()?.view.frame.origin.y ?? 0
            if viewFrameY > CGFloat(0) {
                customView.frame.origin.y = -(viewFrameY)
            }
            if let addedView = UIApplication.topViewController()?.navigationController?.view.viewWithTag(98), !showMultipleAlert {
                addedView.removeFromSuperview()
            }
            if  let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as? SceneDelegate, let baseWindow = sceneDelegate.window {
                
                baseWindow.addSubview(customView)
                baseWindow.bringSubviewToFront(customView)
            }
            

            UIView.animate(withDuration: 0.3, delay: 0.0, options: .transitionCurlUp, animations: {
                UIApplication.shared.statusBarView?.backgroundColor = UIColor(white: 0.35, alpha: 0.0)
                customView.transform = CGAffineTransform(scaleX: 1, y: 1)
                customView.alpha = 1.0
            }, completion: { animate in
            })
        })
    }
}
