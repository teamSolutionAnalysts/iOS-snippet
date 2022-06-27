//
//  UIButton.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 22/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIButton
public extension UIButton {
    ///To add the title of the button on the bottom side
    func alignTextBelow(spacing: CGFloat = 4.0) {
        if let image = self.imageView?.image {
            let imageSize: CGSize = image.size
            self.titleEdgeInsets = UIEdgeInsets(top: spacing,
                                                left: -imageSize.width,
                                                bottom: -(imageSize.height) + 2,
                                                right: 0.0)
            let labelString = NSString(string: self.titleLabel!.text!)
            let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: self.titleLabel!.font as Any])
            self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing),
                                                left: 0.0, bottom: 0.0,
                                                right: -titleSize.width)
        }
    }
    
    internal func alignVertical(spacing: CGFloat) {
        guard let imageSize = self.imageView?.image?.size,
            let text = self.titleLabel?.text,
            let font = self.titleLabel?.font
            else { return }
        let labelString = NSString(string: text)
        let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: font])
        
        let titleLeftInset: CGFloat =  -imageSize.width
        let titleRigtInset: CGFloat =  0.0
        let titleWidth = titleSize.width > self.bounds.width ? self.bounds.width : titleSize.width
        let imageLeftInset: CGFloat =  0.0
        let imageRightInset: CGFloat =  -titleWidth

        self.titleEdgeInsets = UIEdgeInsets(top: 0.0,
                                            left: titleLeftInset,
                                            bottom: -(imageSize.height + spacing),
                                            right: titleRigtInset)
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing),
                                            left: imageLeftInset,
                                            bottom: 0.0,
                                            right: imageRightInset)
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0
        self.contentEdgeInsets = UIEdgeInsets(top: edgeOffset,
                                              left: 0.0,
                                              bottom: edgeOffset,
                                              right: 0.0)
    }
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        let writingDirection = UIApplication.shared.userInterfaceLayoutDirection
        let factor: CGFloat = writingDirection == .leftToRight ? 1 : -1

        self.imageEdgeInsets = UIEdgeInsets(top: 3, left: -insetAmount*factor, bottom: 0, right: insetAmount*factor)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount*factor, bottom: 0, right: -insetAmount*factor)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }

    internal func setAppButton(title: String = "",
                               isEnabled: Bool = true,
                               bgColor: UIColor = AppConfigConstants.appButtonDefaultColor,
                               isBorder: Bool = false,
                               cornerRadius: CGFloat = AppConfigConstants.appButtonDefaultCornerRadius,
                               isShadow: Bool = true,
                               fontSize: FontSize = FontSize.common,
                               fontColor: UIColor = AppConfigConstants.appButtonDefaultFontColor,
                               fontName: AppFonts = AppConfigConstants.appButtonDefaultFontName,
                               borderColor: UIColor = AppColors.appPrimaryColor,
                               disablebgColor: UIColor? = nil) {
        self.setTitle(title, for: .normal)
        self.isUserInteractionEnabled = isEnabled
        self.backgroundColor = isEnabled ? (isBorder ? .white : bgColor) : (disablebgColor != nil) ? disablebgColor : AppConfigConstants.appDisableButtonDefaultColor
        self.layer.borderWidth = isBorder ? 1 : 0
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
        self.titleLabel?.font = fontName.font(size: fontSize)
        self.tintColor = isBorder ? borderColor : fontColor
        self.setTitleColor(isBorder ? AppColors.fieldDescriptionColor : fontColor, for: .normal)
        if isShadow {
            self.drawShadow(isEnabled: isEnabled)
        }
    }

    internal func drawShadow(isEnabled: Bool = true,
                             shadowColor: UIColor = AppConfigConstants.appEnableButtonShadowDefaultColor,
                             opacity: Float = 0.2,
                             offset: CGSize = CGSize(width: 0, height: 5),
                             radius: CGFloat = 5,
                             shouldRasterize: Bool = false) {
        self.layer.shadowColor = isEnabled ? shadowColor.cgColor : AppConfigConstants.appDisableButtonDefaultColor.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shouldRasterize = shouldRasterize
    }

    internal func buttonShadowWithColor(shadowColor: UIColor = AppConfigConstants.appEnableButtonShadowDefaultColor,
                                        opacity: Float = 1.0,
                                        offset: CGSize = CGSize(width: 0, height: 5),
                                        radius: CGFloat = 5,
                                        shouldRasterize: Bool = false) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shouldRasterize = shouldRasterize
    }
    
    internal func setAppRadioButton(title: String = "",
                                    fontName: AppFonts = AppConfigConstants.appRadioDefaultFontName,
                                    fontColor: UIColor = AppConfigConstants.appRadioDefaultFontColor,
                                    fontSize: FontSize = AppConfigConstants.appRadioDefaultFontSize,
                                    textAndImageSpace: CGFloat = AppConfigConstants.appRadioDefaulttextAndImageSpace) {
        self.setTitle(title, for: [])
        self.setTitleColor(fontColor, for: [])
        self.titleLabel?.font = fontName.font(size: fontSize)
        self.centerTextAndImage(spacing: textAndImageSpace)
    }
}

