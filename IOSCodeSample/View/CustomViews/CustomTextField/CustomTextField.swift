//
//  CustomTextField.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 22/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import UIKit

@objc protocol CustomTextFieldDelegate {
    @objc optional func dropdownTap(sender: CustomTextField)
    @objc optional func rightIconTap(sender: CustomTextField, isSelected: Bool)
    @objc optional func rightFirstIconTap(sender: CustomTextField, isSelected: Bool)
    @objc optional func mainViewTap(sender: CustomTextField)
    @objc optional func textDidChanged(sender: CustomTextField)
}

class CustomTextField: UIView {
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var leftIcon: UIImageView!
    @IBOutlet weak var mandatory: UILabel!
    @IBOutlet weak var dropdownView: UIView!
    @IBOutlet weak var dropdownText: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var rightIcon: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var leftViewWidth: NSLayoutConstraint!
    @IBOutlet weak var dropdownWidth: NSLayoutConstraint!
    @IBOutlet weak var rightIconWidth: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var rightFirstIcon: UIImageView!
    @IBOutlet weak var rightFirstWidth: NSLayoutConstraint!
    @IBOutlet weak var dropDownIconImage: UIImageView!
    
    weak var delegate: CustomTextFieldDelegate?
    var isSelected = false
    
    // MARK: - View Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    func sharedInit() {
        nibSetup(nibName: NibNames.customTextField)
        updateErrorLabel()
        updateLeftIconView()
        updateRightIcon()
        updateColor()
        updateKeyboard()
        setFont()
    }
    
    func setFont() {
        self.textField.font = AppFonts.Regular.font(size: FontSize.title)
        self.errorLabel.font = AppFonts.Regular.font(size: FontSize.title)
        self.mandatory.textColor = AppColors.iconsTintColor
        dropdownText.font = AppFonts.Regular.font(size: FontSize.title)
        
    }
    
    func setPlaceHolderColor(newColor: UIColor, font: AppFonts) {
        self.textField.font = font.font(size: FontSize.title)
        self.textField.placeholderColor(newColor)
    }
    
    func setValues(delegate: CustomTextFieldDelegate,
                   textFieldPlaceholder: String = "",
                   textFieldText: String = "",
                   isError: Bool = false,
                   errorText: String = "",
                   showDropdownView: Bool = false,
                   dropdownValue: String = "",
                   leftIconImage: UIImage? = nil,
                   rightIconImage: UIImage? = nil,
                   isMandatory: Bool = true,
                   securedText: Bool = false,
                   isTextField: Bool = true,
                   keyboardType: KeyboardType = .defaultKeyboard,
                   onlyText: Bool = false,
                   isTopCornerRounded: Bool = false,
                   isBottomCornerRounded: Bool = false,
                   bgColor: UIColor = AppColors.appWhite,
                   descText: String? = nil,
                   enableCapitalization: Bool = false,
                   rightFirstImage: UIImage? = nil) {
        
        self.textFieldPlaceholder = textFieldPlaceholder
        self.delegate = delegate
        self.isError = isError
        self.errorText = errorText
        self.descText = descText
        self.showDropdownView = showDropdownView
        self.dropdownValue = dropdownValue
        self.leftIconImage = leftIconImage
        self.rightIconImage = rightIconImage
        self.isMandatory = isMandatory
        self.securedText = securedText
        self.isTextField = isTextField
        self.keyboardType = keyboardType
        self.onlyText = onlyText
        self.textFieldText = textFieldText
        self.isTopCornerRounded = isTopCornerRounded
        self.isBottomCornerRounded = isBottomCornerRounded
        self.bgColor = bgColor
        self.textField.autocapitalizationType = enableCapitalization ? .sentences : .none
        self.rightFirstIconImage = rightFirstImage
        self.dropdownText.textColor = AppColors.navigationColor
        topView.addLineToView(position: .bottom, color: AppColors.textfieldUnderlineDefault)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isTopCornerRounded {
            roundCorners(corners: [.topLeft, .topRight], radius: AppConfigConstants.appButtonDefaultCornerRadius)
            topConstraint.constant = 10
        }
        if isBottomCornerRounded {
            roundCorners(corners: [.bottomLeft, .bottomRight], radius: AppConfigConstants.appButtonDefaultCornerRadius)
        }
    }
    
    func setText(_ value: String?) {
        textField.text = value
    }
    
    func isErrorShown(_ value: Bool = false, _ text: String = "", tableView: UITableView) {
        isError = value
        errorText = text
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
    
    func isErrorShown(_ value: Bool = false, _ text: String = "") {
        isError = value
        errorText = text
    }
    
    // MARK: - Private setter helper
    func updateErrorLabel() {
        errorLabel.isHidden = !isError
        errorLabel.textAlignment = .natural
        errorLabel.text = errorText
    }
    
    func updateDescLabel() {
        descLabel.isHidden = descText == nil
        descLabel.text = descText
        descLabel.textAlignment = .natural
        
    }
    
    func updateDropdownView() {
        dropdownView.isHidden = !showDropdownView
        dropdownText.text = showDropdownView ? dropdownValue : ""
    }
    
    func updateRightIcon() {
        rightIcon.isHidden = rightIconImage == nil
        rightIcon.image = rightIconImage
    }
    
    func updateRightFirstIcon() {
        rightFirstIcon.isHidden = rightFirstIconImage == nil
        rightFirstIcon.image = rightFirstIconImage
    }
    
    func updateLeftIconView() {
        leftIcon.isHidden = leftIconImage == nil
        leftIcon.tintColor = AppColors.textFiledIconColour
        leftIcon.image = leftIconImage
        mandatory.text = isMandatory ? "*" : ""
        leftViewWidth.constant = leftIconImage == nil ? (isMandatory ? 8 : 8) : 23
    }
    
    func updateColor() {
        mainView.backgroundColor = bgColor
        descLabel.textColor = AppColors.fieldDescriptionColor
    }
    
    func updateKeyboard() {
        if keyboardType == .numberPad || keyboardType == .phonePad {
            textField.keyboardType = .asciiCapableNumberPad
        } else {
            textField.keyboardType = UIKeyboardType(rawValue: keyboardType.rawValue) ?? UIKeyboardType.asciiCapable
        }
    }
    
    func updateContentType(type: UITextContentType) {
        textField.textContentType = type
    }
    
    // MARK: - Inspectable properties
    @IBInspectable var textFieldPlaceholder: String = "" {
        didSet {
            textField.attributedPlaceholder = NSAttributedString(string: textFieldPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: AppColors.textfieldUnderlineDefault])
        }
        
    }
    
    @IBInspectable var textFieldText: String = "" {
        didSet {
            textField.text = textFieldText
        }
    }
    
    @IBInspectable var onlyText: Bool = false {
        didSet {
            topStackView.spacing = onlyText ? 0 : 8
        }
    }
    
    @IBInspectable var isError: Bool = false {
        didSet {
            updateErrorLabel()
        }
    }
    
    @IBInspectable var errorText: String = "" {
        didSet {
            updateErrorLabel()
        }
    }
    
    @IBInspectable var descText: String? = nil {
        didSet {
            updateDescLabel()
        }
    }
    
    @IBInspectable var showDropdownView: Bool = false {
        didSet {
            updateDropdownView()
        }
    }
    
    @IBInspectable var dropdownValue: String = "" {
        didSet {
            updateDropdownView()
        }
    }
    
    @IBInspectable var leftIconImage: UIImage? = nil {
        didSet {
            updateLeftIconView()
        }
    }
    
    @IBInspectable var rightIconImage: UIImage? = nil {
        didSet {
            updateRightIcon()
        }
    }
    
    @IBInspectable var rightFirstIconImage: UIImage? = nil {
        didSet {
            updateRightFirstIcon()
        }
    }
    
    @IBInspectable var isMandatory: Bool = true {
        didSet {
            updateLeftIconView()
        }
    }
    
    @IBInspectable var securedText: Bool = false {
        didSet {
            textField.isSecureTextEntry = securedText
        }
    }
    
    @IBInspectable var isTextField: Bool = true {
        didSet {
            textField.isEnabled = isTextField
        }
    }
    
    var keyboardType: KeyboardType = .asciiCapable {
        didSet {
            updateKeyboard()
        }
    }
    
    var contentType: UITextContentType? = nil {
        didSet {
            if let type = contentType {
                self.updateContentType(type: type)
            }
        }
    }
    
    @IBInspectable var isTopCornerRounded: Bool = false {
        didSet {
            layoutSubviews()
        }
    }
    
    @IBInspectable var isBottomCornerRounded: Bool = false {
        didSet {
            layoutSubviews()
        }
    }
    
    @IBInspectable var bgColor: UIColor = AppColors.appWhite {
        didSet {
            updateColor()
        }
    }
    
    //Functions
    @IBAction func dropDownTap(_ sender: Any) {
        delegate?.dropdownTap?(sender: self)
    }
    
    @IBAction func rightIconTap(_ sender: Any) {
        isSelected.toggle()
        delegate?.rightIconTap?(sender: self, isSelected: isSelected)
    }
    
    @IBAction func rightFirstIconTap(_ sender: Any) {
        isSelected.toggle()
        delegate?.rightFirstIconTap?(sender: self, isSelected: isSelected)
    }
    
    @IBAction func mainViewTapped(_ sender: Any) {
        delegate?.mainViewTap?(sender: self)
    }
    
    @IBAction func editingChange(_ sender: UITextField) {
        delegate?.textDidChanged?(sender: self)
    }
}

//MARK: keyboardTypes:-

enum KeyboardType: Int {
    case defaultKeyboard = 0  // Default type for the current input method.
    case asciiCapable = 1  // Displays a keyboard which can enter ASCII characters
    case numbersAndPunctuation = 2  // Numbers and assorted punctuation.
    case URL = 3  // A type optimized for URL entry (shows . / .com prominently).
    case numberPad = 4  // A number pad with locale-appropriate digits (0-9, ۰-۹, ०-९, etc.). Suitable for PIN entry.
    case phonePad = 5  // A phone pad (1-9, *, 0, #, with letters under the numbers).
    case namePhonePad = 6  // A type optimized for entering a person's name or phone number.
    case emailAddress = 7  // A type optimized for multiple email address entry (shows space @ . prominently).
    case decimalPad = 8  // A number pad with a decimal point.
    case twitter = 9  // A type optimized for twitter text entry (easy access to @ #)
    case webSearch = 10 // A default keyboard type with URL-oriented addition (shows space . prominently).
    case asciiCapableNumberPad = 11 // A number pad (0-9) that will always be ASCII digits.
}
