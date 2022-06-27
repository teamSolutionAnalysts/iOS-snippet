//
//  AppConfigConstants.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 22/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit


enum AppConfigConstants {
    //App country picker default country
    static let appDefaultCountry = "IN"
    static let appDefaultCountryCode = "+91"
    static let appDefaultMobileFormate = "9XXXX XXXXX"
    //Buttons
    static let appButtonDefaultFontName = AppFonts.Medium
    static let appButtonDefaultColor = AppColors.textThemeColor
    static let appButtonDefaultFontColor = AppColors.appWhite
    static let appButtonDefaultFontSize: CGFloat = 16.0
    static let appButtonDefaultCornerRadius: CGFloat = 6.0
    static let appDisableButtonDefaultColor = AppColors.textLightColor
    static let appEnableButtonShadowDefaultColor = AppColors.shadowAzure
    static let appDisableButtonShadowDefaultColor = AppColors.shadowGreyish
    
    //Radio Buttons
    static let appRadioDefaultFontName = AppFonts.Regular
    static let appRadioDefaultFontColor = AppColors.textThemeColor
    static let appRadioDefaultFontSize = FontSize.additionInfoDescription
    static let appRadioDefaulttextAndImageSpace: CGFloat = 7.0
    

    //Labels
    static let appLabelDefaultFontName = AppFonts.Regular
    static let appLabelsDefaultFontColor = AppColors.textThemeColor
    static let appLabelDefaultFontSize: CGFloat = 13.0

    //TextFields
    static let appTextFieldDefaultFontName = AppFonts.Regular
    static let appTextFieldDefaultFontColor = AppColors.textThemeColor
    static let appTextFieldDefaultPlaceholderColor = AppColors.viewThemeColor
    static let appTextFieldDefaultFontSize: CGFloat = 13.0

    //SearchBar searchTextField
    static let appSearchBarDefaultFontName = AppFonts.Regular
    static let appSearchBarDefaultFontColor = UIColor.black
    static let appSearchBarDefaultPlaceholderColor = AppColors.cloudyBlue
    static let appSearchBarDefaultFontSize: CGFloat = 13.0

    //Navigation bar title
    static let appNavDefaultFontName = AppFonts.Regular
    static let appNavDefaultFontColor = AppColors.textThemeColor
    static let appNavDefaultFontSize = FontSize.navigation


    //Menu blurview
    static let appMenuBlurViewDefaultColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alphaComponent: 0.09)

    
}
