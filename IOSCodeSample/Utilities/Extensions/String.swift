//
//  String.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 22/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    public func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isNumber: Bool {
        guard !self.isEmpty else { return false }
        let decimalsRegex = AppConstants.decimalsRegex
        let decimalPredicate = NSPredicate(format: "SELF MATCHES %@", decimalsRegex)
        return decimalPredicate.evaluate(with: self.stringWithoutWhitespaces)
    }
    
    var stringWithoutWhitespaces: String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    var isNumeric: Bool {
        guard !self.isEmpty else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
    func isValidEmail() -> Bool {
        let emailRegex = AppConstants.emailRegex
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    
    func isValidPassword() -> Bool {
        let passwordRegex = AppConstants.passwordRegex
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
    func countryCodeValidator() -> String {
        var countryCode: String = self
        if self.filter({$0 == "+"}).count > 1 {
            let code = self.components(separatedBy: "+").last ?? AppConfigConstants.appDefaultCountryCode
            if !code.contains("+") {
                countryCode = "+" + code
            } else {
                countryCode = code
            }
        }
        return countryCode
    }
    
    func onlyNumbers() -> [NSNumber] {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let charset = CharacterSet(charactersIn: " ,")
        return matches(for: "[+-]?([0-9]+([., ][0-9]*)*|[.][0-9]+)").compactMap { string in
            return formatter.number(from: string.trimmingCharacters(in: charset))
        }
    }
    
    func matches(for regex: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: [.caseInsensitive]) else { return [] }
        let matches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
        return matches.compactMap { match in
            guard let range = Range(match.range, in: self) else { return nil }
            return String(self[range])
        }
    }
    
    func fetchUnit() -> String? {
        let beginningOfLetters = (self as NSString).rangeOfCharacter(from: CharacterSet.letters)
        if beginningOfLetters.location == NSNotFound {
            return nil
        }
        return (self as NSString).substring(from: beginningOfLetters.location)
    }
    
    ///Returns an empty string when there is no path.
    func substring(from left: String, to right: String) -> String {
        if let match = range(of: "(?<=\(left))[^\(right)]+", options: .regularExpression) {
            return String(self[match])
        }
        return ""
    }
    
    func addSubString(_ text: String) -> String {
        return self.replacingOccurrences(of: "$", with: text)
    }
    
    func addAppNameString(_ text: String) -> String {
        return self.replacingOccurrences(of: "#", with: text)
    }
    
    func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return boundingBox.height
    }
    
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
   
    
    func localized() -> String {
        let path = Bundle.main.path(forResource: "en", ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
    private static let formatter = NumberFormatter()

    func clippingCharacters(in characterSet: CharacterSet) -> String {
        components(separatedBy: characterSet).joined()
    }

    func containsOnlyLetters() -> Bool {
       for chr in self {
          if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
             return false
          }
       }
       return true
    }
    
    func isDate() -> Bool {
        guard self.trimmed().count > 0 else { return false }
        var detector: NSDataDetector?
        let detectorType: NSTextCheckingResult.CheckingType = [.date]
        detector = try? NSDataDetector(types: detectorType.rawValue)
        let matches = detector?.matches(in: self.trimmed(), options: [], range: NSRange(location: 0, length: self.trimmed().count))
        for match in matches ?? [] {
            if match.resultType == .date {
                return true
            }
        }
        return false
    }
    
    var isLowercase: Bool {
        return self == self.lowercased()
    }
    
    var isUppercase: Bool {
        return self == self.uppercased()
    }
    func underLined() -> NSAttributedString{
        let underlineAttriString = NSAttributedString(string: self,
                                                  attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        return underlineAttriString
    }
    func htmlAttributedString() -> NSMutableAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        return html
    }
    func removeFormateFromCurrancy() -> String {
        return self.replacingOccurrences(of: ",", with: "")
    }
}
