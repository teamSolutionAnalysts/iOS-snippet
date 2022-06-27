//
//  AppFonts.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 22/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

enum AppFonts: String {
    //Helvetica Neue
    case HelveticaRegular         = "HelveticaNeue"
    case HelveticaMedium         = "HelveticaNeue-Medium"
    case HelveticaBold         = "HelveticaNeue-Bold"
    // Most Used
    case Bold               = "VolvoNovum-Bold"
    case Medium             = "VolvoNovum-Medium"
    case BoldSerif          = "VolvoSerifPro-Bold"
    case RegularSerif       = "VolvoSerifPro-Regular"
    case Regular            = "VolvoNovum-Regular"
    func font(size: FontSize) -> UIFont {
        return UIFont(name: self.rawValue, size: size.rawValue)!
    }
}

enum FontSize: CGFloat {
    case condition = 8
    case description = 10
    case service = 11
    case navigationButton = 12
    case title = 13
    case common = 16
    case navigation = 20
    case header = 22
    case vehicleAttribute = 14
    case additionInfoDescription = 18
    case largeHeader = 25
    case serviceNumber = 40
    case amountHeader = 28
    case odoMeter = 19
    case tierName = 33
}
