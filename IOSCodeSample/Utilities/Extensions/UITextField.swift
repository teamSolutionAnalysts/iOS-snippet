//
//  UITextField.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 22/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func fixCaretPosition() {
        let beginning = beginningOfDocument
        selectedTextRange = textRange(from: beginning, to: beginning)
        let end = endOfDocument
        selectedTextRange = textRange(from: end, to: end)
    }

    var isEmpty: Bool {
        return getText().isEmpty
    }

    func getText() -> String {
        text = (text ?? "").trimmingCharacters(in: .whitespaces)
        return text ?? ""
    }

    func placeholderColor(_ color: UIColor) {
        var placeholderText = ""
        if self.placeholder != nil {
            placeholderText = self.placeholder!
        }
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: color])
    }

    //Set TextFiled with the default values for the application
    func setAppTextField(placeholder: String = "",
                         content: String = "",
                         fontName: AppFonts = AppConfigConstants.appTextFieldDefaultFontName,
                         fontSize: FontSize = FontSize.common,
                         placeholderColor: UIColor = AppConfigConstants.appTextFieldDefaultPlaceholderColor,
                         fontColor: UIColor = AppConfigConstants.appTextFieldDefaultFontColor) {
        self.placeholder = placeholder
        self.text = content
        self.font = fontName.font(size: fontSize)
        self.textColor = AppColors.textThemeColor
        self.placeholderColor(placeholderColor)
    }

    func setAppSearchBarTextField(placeholder: String = "",
                                  fontName: AppFonts = AppConfigConstants.appSearchBarDefaultFontName,
                                  fontSize: FontSize = FontSize.navigationButton,
                                  placeholderColor: UIColor = AppConfigConstants.appSearchBarDefaultFontColor,
                                  fontColor: UIColor = AppConfigConstants.appSearchBarDefaultFontColor,
                                  isWithSercIcon: Bool = true) {
        self.placeholder = placeholder
        self.font = fontName.font(size: fontSize)
        self.textColor = fontColor
        self.placeholderColor(placeholderColor)
        self.backgroundColor = .clear
        if isWithSercIcon {
            let imageView = UIImageView(image: AppImages.search)
            self.leftView = nil
            self.rightView = imageView
            self.rightViewMode = .always
        }
    }
}

