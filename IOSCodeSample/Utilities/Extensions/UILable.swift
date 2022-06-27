//
//  UILable.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 22/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//
import UIKit

extension UILabel {
    //Set label with the default values for the application
    func setAppLabel(content: String = "",
                     fontName: AppFonts = AppConfigConstants.appLabelDefaultFontName,
                     fontSize: FontSize = FontSize.title,
                     fontColor: UIColor = AppConfigConstants.appLabelsDefaultFontColor,
                     alignment: NSTextAlignment? = nil,
                     attributedText: NSMutableAttributedString? = nil) {
        self.font = fontName.font(size: fontSize)
        self.textColor = fontColor
        if let align = alignment {
            self.textAlignment = align
        }
        if let attributedString = attributedText {
            self.attributedText = attributedString
        } else {
            self.text = content
        }
    }
    
    
}
