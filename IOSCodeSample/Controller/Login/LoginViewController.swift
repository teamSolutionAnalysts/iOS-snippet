//
//  LoginViewController.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 20/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import UIKit
import MRCountryPicker

class LoginViewController: UITableViewController {
    
    //IBOutlets
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var buttonForgotPassword: UIButton!
    @IBOutlet weak var buttonRegister: UIButton!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var labelDontHaveAccount: UILabel!
    @IBOutlet weak var mobileView: CustomTextField!
    @IBOutlet weak var passwordView: CustomTextField!
    @IBOutlet var viewModel: LoginViewModel!
    
    let buttonShowPassword = UIButton(type: .custom)
    var countryPicker: MRCountryPicker!
    
    //MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        observeError()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(.clearNavigationType)
    }
    
    //MARK: Prepare UI
    func prepareUI() {
        setupCountryPicker() //Country Code Picker
        imageLogo.image = AppImages.logo
        
        /**Folloing  code will setup  custome textfield  as per need **/
        mobileView.setValues(delegate: self,
                             textFieldPlaceholder: AppLanguageConstants.enterMobileNo.localized(),
                             showDropdownView: true,
                             dropdownValue: AppConfigConstants.appDefaultCountryCode,
                             leftIconImage: AppImages.phone.withRenderingMode(.alwaysTemplate),
                             isMandatory: false,
                             keyboardType: .numberPad,
                             bgColor: .clear,
                             descText: AppLanguageConstants.phoneDesc.localized().addSubString("\(AppConfigConstants.appDefaultCountryCode) \(AppConfigConstants.appDefaultMobileFormate)"))
        mobileView.contentType = .username
        
        passwordView.setValues(delegate: self,
                               textFieldPlaceholder: AppLanguageConstants.password.localized(),
                               leftIconImage: AppImages.password.withRenderingMode(.alwaysTemplate),
                               rightIconImage: AppImages.hiddenPass,
                               isMandatory: false,
                               securedText: true,
                               bgColor: .clear,
                               descText: AppLanguageConstants.passwordDesc.localized())
        passwordView.contentType = .password
        
        buttonForgotPassword.setAppButton(title: AppLanguageConstants.forgotPassword.localized(),
                                          bgColor: .clear,
                                          isBorder: false,
                                          cornerRadius: 0.0,
                                          isShadow: false,
                                          fontSize: FontSize.title,
                                          fontColor: AppColors.textThemeColor)
        buttonLogin.setAppButton(title: AppLanguageConstants.login.localized(), isEnabled: false, fontName: AppFonts.Medium)
        buttonRegister.setAppButton(title: AppLanguageConstants.registerNow.localized(),
                                    bgColor: AppColors.appWhite,
                                    isBorder: true,
                                    isShadow: false,
                                    fontColor: AppColors.textThemeColor,
                                    fontName: AppFonts.Medium)
        
        labelDontHaveAccount.setAppLabel(content: AppLanguageConstants.dontHaveAccount.localized(), fontColor: AppColors.viewThemeColor)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    //MARK: Setup Picker
    private func setupCountryPicker() {
        countryPicker = MRCountryPicker()
        countryPicker.setLocale("en")
        countryPicker.isCountryFlag = false
        countryPicker.countryPickerDelegate = self
        countryPicker.setCountry(AppConfigConstants.appDefaultCountry)
    }
    
    //MARK: Validationg data
    func textFieldsIsNotEmpty() {
        guard
            let mob = viewModel.mobile, !mob.isBlank,
            let pass = viewModel.password, !pass.isBlank else {
            buttonLogin.setAppButton(title: AppLanguageConstants.login.localized(), isEnabled: false)
            return
        }
        buttonLogin.setAppButton(title: AppLanguageConstants.login.localized(), isEnabled: true)
    }
    
    func observeError(){
        self.viewModel.error.addObserver(self) {[weak self] error in
            guard let self = self else {return}
            switch error{
            case .mobileEmpty:
                self.mobileView.isErrorShown(true, AppLanguageConstants.noMobileNumber.localized(), tableView: self.tableView)
            case .mobileInvalid:
                self.mobileView.isErrorShown(true, AppLanguageConstants.validMobileNumber.localized(), tableView: self.tableView)
            case .passwordEmpty:
                self.passwordView.isErrorShown(true, AppLanguageConstants.noPassword.localized(), tableView: self.tableView)
            default:
                self.mobileView.isErrorShown(false, tableView: self.tableView)
                self.passwordView.isErrorShown(false, tableView: self.tableView)
                Logger.shared.log("All data is valid")
            }
        }
    }
    
    //MARK: Button Action
    @IBAction func buttonLoginTapped(_ sender: Any) {
        if viewModel.isValidInputsData() {
            view.isUserInteractionEnabled = false
            viewModel.login { [weak self ] sucsses, message in
                self?.view.isUserInteractionEnabled = true
                /**Commenting succses to allow user to navigate to home screen , real time we have to validate login on sucsses only **/
                //if sucsses{
                    let homeVC: HomeViewController = UIStoryboard(storyboard: .auth).instantiate()
                    Navigator.shared.changeRootVC(UINavigationController(rootViewController: homeVC))
//                }
            }
        }
    }
}

//MARK: UITableView Hight
extension LoginViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 200.0
        default:
            return UITableView.automaticDimension
        }
    }
}

// MARK: - Country Picker Delegate
extension LoginViewController: MRCountryPickerDelegate {
    func countryPhoneCodePicker(_ picker: MRCountryPicker,
                                didSelectCountryWithName name: String,
                                countryCode: String,
                                phoneCode: String,
                                flag: UIImage) {
        mobileView.dropdownText.text = phoneCode
        viewModel.mobileCode = phoneCode
    }
}

//MARK: TextField Custom Delegate
extension LoginViewController: CustomTextFieldDelegate {
    func dropdownTap(sender: CustomTextField) {
        let alertController = UIAlertController(title: AppLanguageConstants.chooseYourCountryCode.localized(),
                                                message: nil,
                                                preferredStyle: .actionSheet)
        alertController.view.addSubview(countryPicker)
        self.setCounstraintsToPickers(toView: countryPicker, respectedView: alertController)
        let cancelAction = UIAlertAction(title: AppLanguageConstants.done.localized(), style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func textDidChanged(sender: CustomTextField) {
        switch sender {
        case mobileView:
            viewModel.mobile = mobileView.textField.text
        case passwordView:
            viewModel.password = passwordView.textField.text
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
