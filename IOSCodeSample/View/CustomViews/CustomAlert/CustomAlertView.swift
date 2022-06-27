//
//  CustomAlertView.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 22/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//


import UIKit

enum CustomeAlertButtonDisplayType {
    case singleButton
    case doubleButton
}

class CustomAlertView: UIView {
    @IBOutlet weak var mainAreaView: UIView!
    @IBOutlet weak var alertAreaView: UIView!
    @IBOutlet weak var labelAlertTitle: UILabel!
    @IBOutlet weak var txtViewAlertMessage: UITextView!
    @IBOutlet weak var btnBackgroundView: UIView!
    @IBOutlet weak var horizontalStackView: UIStackView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnDismiss: UIButton!
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewBottomOptionsHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageAlert: UIImageView!
    @IBOutlet weak var imageSuperViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var buttonOptionOne: UIButton!
    @IBOutlet weak var buttonOptionTwo: UIButton!
    @IBOutlet weak var labelBottomOptionSeparator: UILabel!
    
    var doneButtonTapped : (() -> Void)?
    var cancelButtonTapped : (() -> Void)?
    var optionOneButtonTapped : (() -> Void)?
    var optionTwoButtonTapped : (() -> Void)?
    var dismissButtonTapped : (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialSetup()
    }
    
    func initialSetup() {
        self.backgroundColor = UIColor(red: 25 / 255, green: 40 / 255, blue: 62 / 255, alphaComponent: 0.50)
        self.mainAreaView.layer.cornerRadius = 8
        self.mainAreaView.layer.masksToBounds = true
        self.mainAreaView.backgroundColor = AppColors.appWhite
        self.mainAreaView.layer.borderWidth = 1
        self.mainAreaView.layer.borderColor = AppColors.dialogBoarderColor.cgColor
        setupBasicUIForElements()
        txtViewAlertMessage.textColor = AppColors.textThemeColor
    }
    
    func setupBasicUIForElements() {
        //Alert title and message
        self.labelAlertTitle.setAppLabel(fontSize: FontSize.additionInfoDescription, fontColor: AppColors.viewThemeColor)
        
        //Button bottom options
        self.buttonOptionOne.setAppButton(bgColor: UIColor.clear,
                                          isShadow: false,
                                          fontSize: FontSize.navigationButton,
                                          fontColor: AppColors.textThemeColor)
        self.buttonOptionTwo.setAppButton(bgColor: UIColor.clear,
                                          isShadow: false,
                                          fontSize: FontSize.navigationButton,
                                          fontColor: AppColors.textThemeColor)
        self.labelBottomOptionSeparator.backgroundColor = AppColors.separatorColor
        
        //Button dismiss, cancle and done
        self.btnDismiss.setAppButton(isShadow: true, fontSize: FontSize.vehicleAttribute)
        self.btnCancel.setAppButton(isShadow: true, fontSize: FontSize.vehicleAttribute)
        self.btnDone.setAppButton( isBorder: true, isShadow: true, fontSize: FontSize.vehicleAttribute)
    }
    
    func singleButtonInitialSetup(title: String, shouldDismiss: Bool) {
        DispatchQueue.main.async {
            self.btnDismiss.setAppButton(title: title, isShadow: true, fontSize: FontSize.vehicleAttribute)
            self.btnDismiss.tag = shouldDismiss ? 50 : 51
            self.btnDismiss.addTarget(self, action: #selector(self.btnDismissTapped(sender:)), for: .touchUpInside)
        }
    }
    
    func doubleButtonInitialSetup(shouldDismissOne: Bool, shouldDismissTwo: Bool) {
        self.btnDone.tag = shouldDismissOne ? 50 : 51
        self.btnDone.addTarget(self, action: #selector(self.btnDoneTapped), for: .touchUpInside)
        self.btnCancel.tag = shouldDismissTwo ? 50 : 51
        self.btnCancel.addTarget(self, action: #selector(self.btnCancelTapped), for: .touchUpInside)
    }
    
    func bottomOptionInitialSetUp(shouldDismiss: Bool) {
        self.buttonOptionOne.addTarget(self, action: #selector(self.btnOptionOneTapped), for: .touchUpInside)
        self.buttonOptionTwo.addTarget(self, action: #selector(self.btnOptionTwoTapped), for: .touchUpInside)
    }
    
    func addBlurEffect() {
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView.frame = self.bounds
        self.insertSubview(visualEffectView, belowSubview: mainAreaView)
    }
    
    func changeButtonOptionTwoTitle(title: String) {
        self.buttonOptionTwo.setAppButton(title: title,
                                          bgColor: .clear,
                                          isBorder: false,
                                          cornerRadius: 0.0,
                                          isShadow: false,
                                          fontSize: FontSize.title,
                                          fontColor: AppColors.textThemeColor)
    }
    
    func alertButtonDisplayType(displayType: CustomeAlertButtonDisplayType,
                                isWithBottomOptions: Bool,
                                shouldDismiss: Bool = true,
                                shouldDismissOne: Bool = true,
                                shouldDismissTwo: Bool = true,
                                singleButtonTitle: String = AppLanguageConstants.ok.localized()) {
        self.horizontalStackView.isHidden = displayType == .singleButton
        self.btnDismiss.isHidden = displayType == .doubleButton
        
        viewBottomOptionsHeightConstraint.constant = isWithBottomOptions ? 20 : 0
        
        if displayType == .singleButton {
            singleButtonInitialSetup(title: singleButtonTitle, shouldDismiss: shouldDismiss)
        } else {
            doubleButtonInitialSetup(shouldDismissOne: shouldDismissOne, shouldDismissTwo: shouldDismissTwo)
        }
        
        if isWithBottomOptions {
            bottomOptionInitialSetUp(shouldDismiss: shouldDismiss)
        }
    }
    
    func checkAlertPopupHeightValidation() {
        if let message = self.txtViewAlertMessage.text {
            let textViewWidth = UIScreen.main.bounds.width -
            AlertViewConsts.alertLeadingTrailing.rawValue //Leading + Trailing
            let topBottom: CGFloat = AlertViewConsts.alertTop.rawValue +
            AlertViewConsts.alertBottom.rawValue +
            imageSuperViewConstraint.constant +
            viewBottomOptionsHeightConstraint.constant //Top + Bottom To MainAreaView
            let textViewPadding: CGFloat = AlertViewConsts.alertTextViewPadding.rawValue
            
            let heightOfTxtView = message.heightWithConstrainedWidth(textViewWidth,
                                                                     font: self.txtViewAlertMessage.font!)
            
            let alertViewHeight = heightOfTxtView + topBottom + textViewPadding
            
            let maxHeight = UIScreen.main.bounds.height - AlertViewConsts.alertMaxHeightMinusValue.rawValue
            viewHeightConstraint.constant = min(alertViewHeight, maxHeight)
        }
    }
}

// MARK: - Button Selector Methods -
extension CustomAlertView {
    @objc
    func btnDoneTapped(sender: UIButton) {
        DispatchQueue.main.async(execute: {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: .transitionCurlUp, animations: {
                self.alpha = sender.tag == 50 ? 0.0 : 1.0
            }, completion: { _ in
                self.doneButtonTapped?()
                if sender.tag == 50 {
                    //self.removeFromSuperview()
                }
            })
        })
    }
    
    @objc
    func btnCancelTapped(sender: UIButton) {
        DispatchQueue.main.async(execute: {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: .transitionCurlUp, animations: {
                self.alpha = sender.tag == 50 ? 0.0 : 1.0
            }, completion: { _ in
                self.cancelButtonTapped?()
                if sender.tag == 50 {
                    //self.removeFromSuperview()
                }
            })
        })
    }
    
    @objc
    func btnDismissTapped(sender: UIButton) {
        DispatchQueue.main.async(execute: {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: .transitionCurlUp, animations: {
                self.alpha = sender.tag == 50 ? 0.0 : 1.0
            }, completion: { _ in
                self.dismissButtonTapped?()
                if sender.tag == 50 {
                    self.removeFromSuperview()
                }
            })
        })
    }
    
    @objc
    func btnOptionOneTapped() {
        DispatchQueue.main.async(execute: {
            self.optionOneButtonTapped?()
        })
    }
    
    @objc
    func btnOptionTwoTapped() {
        DispatchQueue.main.async(execute: {
            self.optionTwoButtonTapped?()
        })
    }
}
