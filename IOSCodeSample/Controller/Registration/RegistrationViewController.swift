//
//  RegistrationViewController.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 22/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import UIKit
import MRCountryPicker

class RegistrationViewController: UITableViewController {
    
    //IBOutlets
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var userTitleView: CustomTextField!
    @IBOutlet weak var firstNameView: CustomTextField!
    @IBOutlet weak var lastNameView: CustomTextField!
    @IBOutlet weak var mobileView: CustomTextField!
    @IBOutlet weak var emailView: CustomTextField!
    @IBOutlet weak var passwordView: CustomTextField!
    @IBOutlet weak var confirmPasswordView: CustomTextField!
    @IBOutlet weak var buttonRegister: UIButton!
    @IBOutlet var viewModel: RegistrationViewModel!
    
    //Other vars
    var countryPicker: MRCountryPicker!
    let arrayUserTitles = AppConstants.userTitleValues
    var pickerView: UIPickerView!
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        observeError()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(.colouredNavigationType)
    }
    
    //MARK: Prepare UI
    func prepareUI() {
        setupCountryPicker()
        setupUserTitlePicker()
        imageLogo.image = AppImages.logo
        
        /**Folloing  code will setup  custome textfield  as per need **/
        userTitleView.setValues(delegate: self,
                                showDropdownView: true,
                                dropdownValue: AppLanguageConstants.userTitle.localized(),
                                leftIconImage: AppImages.avatar.withRenderingMode(.alwaysTemplate),
                                isTopCornerRounded: true)
        
        userTitleView.textField.isUserInteractionEnabled = false
        userTitleView.setPlaceHolderColor(newColor: AppColors.textThemeColor, font: AppFonts.Medium)
        firstNameView.setValues(delegate: self,
                                textFieldPlaceholder: AppLanguageConstants.firstName.localized(),
                                leftIconImage: AppImages.avatar.withRenderingMode(.alwaysTemplate),
                                enableCapitalization: true)
        
        lastNameView.setValues(delegate: self,
                               textFieldPlaceholder: AppLanguageConstants.lastName.localized(),
                               leftIconImage: AppImages.avatar.withRenderingMode(.alwaysTemplate),
                               enableCapitalization: true)
        
        mobileView.setValues(delegate: self,
                             textFieldPlaceholder: AppLanguageConstants.mobileNumber.localized(),
                             showDropdownView: true,
                             dropdownValue: AppConfigConstants.appDefaultCountryCode,
                             leftIconImage: AppImages.phone.withRenderingMode(.alwaysTemplate),
                             keyboardType: .numberPad,
                             descText: AppLanguageConstants.phoneDesc.localized().addSubString("\(AppConfigConstants.appDefaultCountryCode) \(AppConfigConstants.appDefaultMobileFormate)"))
        
        emailView.setValues(delegate: self,
                            textFieldPlaceholder: AppLanguageConstants.emailAddress.localized(),
                            leftIconImage: AppImages.email.withRenderingMode(.alwaysTemplate),
                            keyboardType: .emailAddress)
        
        passwordView.setValues(delegate: self,
                               textFieldPlaceholder: AppLanguageConstants.password.localized(),
                               leftIconImage: AppImages.password.withRenderingMode(.alwaysTemplate),
                               rightIconImage: AppImages.hiddenPass,
                               isMandatory: true,
                               securedText: true,
                               bgColor: .clear,
                               descText: AppLanguageConstants.passwordDesc.localized())
        
        confirmPasswordView.setValues(delegate: self,
                                      textFieldPlaceholder: AppLanguageConstants.passwordConfirm.localized(),
                                      leftIconImage: AppImages.password.withRenderingMode(.alwaysTemplate),
                                      rightIconImage: AppImages.hiddenPass,
                                      isMandatory: true,
                                      securedText: true,
                                      bgColor: .clear,
                                      descText: AppLanguageConstants.passwordDesc.localized())
        
        
        buttonRegister.setAppButton(title: AppLanguageConstants.registerNow.localized(), isEnabled: false, fontName: AppFonts.Medium)
    }
    
    //MARK: setup Pickers
    private func setupCountryPicker() {
        countryPicker = MRCountryPicker()
        countryPicker.setLocale("en")
        countryPicker.isCountryFlag = false
        countryPicker.countryPickerDelegate = self
        countryPicker.setCountry(AppConfigConstants.appDefaultCountry)
    }
    
    private func setupUserTitlePicker() {
        pickerView = UIPickerView()
        pickerView.backgroundColor = .clear
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    //MARK: Button Action
    @IBAction func buttonRegisterTapped(_ sender: Any) {
        view.endEditing(true)
        clearAllErrors()
        if viewModel.isValidInputsData() {
            view.isUserInteractionEnabled = false
            viewModel.signUp {[weak self] sucsses, message in
                self?.view.isUserInteractionEnabled = true
                /**Commenting succses to allow user to navigate to home screen , real time we have to validate login on sucsses only **/
                //                if sucsses{
                let homeVC: HomeViewController = UIStoryboard(storyboard: .auth).instantiate()
                Navigator.shared.changeRootVC(UINavigationController(rootViewController: homeVC))
                //                }
            }
        }
    }
    
    //MARK: Validationg data
    func textFieldsIsNotEmpty() {
        guard
            let title = viewModel.userTitle, !title.isBlank,
            let name = viewModel.firstName, !name.isBlank,
            let lastNam = viewModel.lastName, !lastNam.isBlank,
            let mob = viewModel.mobile, !mob.isBlank,
            let mail = viewModel.email, !mail.isBlank,
            let password = viewModel.password, !password.isBlank,
            let passwordConfirm = viewModel.confirmPassword, !passwordConfirm.isBlank else {
            buttonRegister.setAppButton(title: AppLanguageConstants.registerNow.localized(), isEnabled: false)
            return
        }
        buttonRegister.setAppButton(title: AppLanguageConstants.registerNow.localized(), isEnabled: true)
    }
    
    func observeError(){
        self.viewModel.error.addObserver(self) {[weak self] error in
            guard let self = self else {return}
            switch error{
            case .title:
                self.userTitleView.isErrorShown(true, AppLanguageConstants.noUserTitle.localized(), tableView: self.tableView)
            case .firstname:
                self.userTitleView.isErrorShown(true, AppLanguageConstants.noFirstName.localized(), tableView: self.tableView)
            case .lastName:
                self.userTitleView.isErrorShown(true, AppLanguageConstants.noLastName.localized(), tableView: self.tableView)
            case .mobileEmpty:
                self.mobileView.isErrorShown(true, AppLanguageConstants.noMobileNumber.localized(), tableView: self.tableView)
            case .mobileInvalid:
                self.mobileView.isErrorShown(true, AppLanguageConstants.validMobileNumber.localized(), tableView: self.tableView)
            case .emailEmpty:
                self.mobileView.isErrorShown(true, AppLanguageConstants.noEmailAddress.localized(), tableView: self.tableView)
            case .emaiInvalid:
                self.emailView.isErrorShown(true, AppLanguageConstants.validEmailAddress.localized(), tableView: self.tableView)
            case .passwordEmpty:
                self.passwordView.isErrorShown(true, AppLanguageConstants.noPassword.localized(), tableView: self.tableView)
            case .confirmPassowrd:
                self.passwordView.isErrorShown(true, AppLanguageConstants.noConfirmPassword.localized(), tableView: self.tableView)
            case .passwordMismatch:
                self.confirmPasswordView.isErrorShown(true, AppLanguageConstants.noMatchOnPasswords.localized(), tableView: self.tableView)
            default:
                self.clearAllErrors()
                Logger.shared.log("All data is valid")
            }
        }
    }
    
    func clearAllErrors(){
        firstNameView.isErrorShown(false, tableView: self.tableView)
        lastNameView.isErrorShown(false, tableView: self.tableView)
        mobileView.isErrorShown(false, tableView: self.tableView)
        emailView.isErrorShown(false, tableView: self.tableView)
        passwordView.isErrorShown(false, tableView: self.tableView)
        confirmPasswordView.isErrorShown(false, tableView: self.tableView)
    }
}

//MARK: UITableView Hight
extension RegistrationViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 115
        default:
            return UITableView.automaticDimension
        }
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension RegistrationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayUserTitles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerView.backgroundColor =  .clear
        return  arrayUserTitles[row].localized()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        userTitleView?.dropdownText.text = arrayUserTitles[row].localized()
        viewModel.userTitle = arrayUserTitles[row]
        
        textFieldsIsNotEmpty()
    }
}

// MARK: - Country Picker Delegate
extension RegistrationViewController: MRCountryPickerDelegate {
    func countryPhoneCodePicker(_ picker: MRCountryPicker,
                                didSelectCountryWithName name: String,
                                countryCode: String,
                                phoneCode: String,
                                flag: UIImage) {
        mobileView.dropdownText.text = phoneCode
        viewModel.mobileCode = phoneCode
    }
}

//MARK: UIstome Textfield Delegate
extension RegistrationViewController: CustomTextFieldDelegate {
    
    func dropdownTap(sender: CustomTextField) {
        let isTitleView = sender == userTitleView ? true : false
        let alertTitle = isTitleView ? AppLanguageConstants.chooseYourTitle.localized() : AppLanguageConstants.chooseYourCountryCode.localized()
        let alertController = UIAlertController(title: alertTitle,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        guard let aView = isTitleView ? pickerView : countryPicker else {
            return
        }
        alertController.view.addSubview(aView)
        self.setCounstraintsToPickers(toView: aView, respectedView: alertController)
        let cancelAction = UIAlertAction(title: AppLanguageConstants.done.localized(), style: .cancel, handler: { _ in
            if sender == self.userTitleView &&
                (self.userTitleView?.dropdownText.text?.isEmpty ?? false ||
                 self.userTitleView?.dropdownText.text == AppLanguageConstants.userTitle.localized()) {
                self.userTitleView?.dropdownText.text = self.arrayUserTitles[0]
                self.viewModel.userTitle = self.arrayUserTitles[0]
                self.textFieldsIsNotEmpty()
            }
        })
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func textDidChanged(sender: CustomTextField) {
        switch sender {
        case userTitleView:
            viewModel.userTitle = userTitleView.textField.text ?? ""
        case firstNameView:
            viewModel.firstName = firstNameView.textField.text
        case lastNameView:
            viewModel.lastName = lastNameView.textField.text
        case mobileView:
            viewModel.mobile = mobileView.textField.text
        case emailView:
            viewModel.email = emailView.textField.text
        case passwordView:
            viewModel.password = passwordView.textField.text
        case confirmPasswordView:
            viewModel.confirmPassword = confirmPasswordView.textField.text
        default:
            break
        }
        textFieldsIsNotEmpty()
    }
    func rightIconTap(sender: CustomTextField, isSelected: Bool) {
        if sender.textField.isSecureTextEntry {
            sender.rightIconImage = AppImages.visiblePass
        } else {
            sender.rightIconImage = AppImages.hiddenPass
        }
        sender.textField.isSecureTextEntry = !sender.textField.isSecureTextEntry
    }
}
