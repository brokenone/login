//
//  RegisterViewController.swift
//  Teacher
//
//  Created by Hrayr on 4/30/19.
//  Copyright © 2019 Hrayr. All rights reserved.
//

import UIKit

class RegisterViewController: LoginBaseViewController , UIPickerViewDelegate , UIPickerViewDataSource , UITextFieldDelegate {
    @IBOutlet weak var registragionNameTextField:                   UITextField!
    @IBOutlet weak var registrationLastNameTextField:               UITextField!
    @IBOutlet weak var registrationEmailTextField:                  UITextField!
    @IBOutlet weak var registrationPasswordTextField:               UITextField!
    @IBOutlet weak var registrationConfirmPasswordTextField:        UITextField!
    @IBOutlet weak var registrationChooseLanguageButton:            UIButton!
    @IBOutlet weak var nameNotificationLabel:                       UILabel!
    @IBOutlet weak var nameNotificationView:                        UIView!
    @IBOutlet weak var lastnameNotificationLabel:                   UILabel!
    @IBOutlet weak var lastnameNotificationView:                    UIView!
    @IBOutlet weak var emailNotificationLabel:                      UILabel!
    @IBOutlet weak var emailNotificationView:                       UIView!
    @IBOutlet weak var passwordNotificationLabel:                   UILabel!
    @IBOutlet weak var passwordNotifivationView:                    UIView!
    @IBOutlet weak var confirmPasswordNotificationLabel:            UILabel!
    @IBOutlet weak var confirmPasswordNotificationView:             UIView!
    @IBOutlet weak var chooseLanguageNotificationLabel:             UILabel!
    @IBOutlet weak var chooseLanguageNotificationView:              UIView!
    
    var data = ["Choose Language", "English", "France", "Armenian","Russian"]
    var picker = UIPickerView()
    var toolBar = UIToolbar()
    
    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldDelegate()
        pickerViewDelegate()
        textFieldOptions()
        properties()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard(textField)
        return true
    }
    
    func textFieldDelegate(){
        registragionNameTextField.delegate = self
        registrationLastNameTextField.delegate = self
        registrationEmailTextField.delegate = self
        registrationPasswordTextField.delegate = self
        registrationConfirmPasswordTextField.delegate = self
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerViewDelegate(){
        picker.delegate = self
        picker.dataSource = self
    }
    
    //MARK: - Public functions
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        registrationChooseLanguageButton.setTitle(data[row], for: .normal)
        registrationChooseLanguageButton.titleLabel?.text = data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    //MARK: - IBActions
    
    @IBAction func signInButtonAction(_ sender: Any) {
        let check = checkTextFields()
        //let equalCheck = checkEquals()
        if check  {
            print("Go to Next")
            navigateToNavigationController()
        }
    }
    
    @IBAction func chooseButtonAction(_ sender: Any) {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = UIColor.init(red: 0, green: 122, blue: 255, alpha: 10)
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    //MARK: - Private Functions
    
    private func notificationPopUp(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancle", style: UIAlertAction.Style.default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func checkTextFields() -> Bool{
        var nameBool = true
        var lastNameBool = true
        var emailBool = true
        var passwordBool = true
        var confirmPasswordBool = true
        var chooseLanguageBool = true
        var checked = false
        nameNotificationLabel.isHidden = true
        lastnameNotificationLabel.isHidden = true
        emailNotificationLabel.isHidden = true
        passwordNotificationLabel.isHidden = true
        confirmPasswordNotificationLabel.isHidden = true
        chooseLanguageNotificationLabel.isHidden = true
        registrationChooseLanguageButton.titleLabel?.textColor = UIColor.blue
        notificationViewColor(view: nameNotificationView, color: "white")
        notificationViewColor(view: lastnameNotificationView, color: "white")
        notificationViewColor(view: emailNotificationView, color: "white")
        notificationViewColor(view: passwordNotifivationView, color: "white")
        notificationViewColor(view: confirmPasswordNotificationView, color: "white")
        notificationViewColor(view: chooseLanguageNotificationView, color: "white")
        guard registragionNameTextField.text!.count != 0 else {
            nameNotificationLabel.text = "Please enter your first name"
            notificationViewColor(view: nameNotificationView, color: "red")
            nameNotificationLabel.isHidden = false
            nameBool = false
            return false
        }
        guard registrationLastNameTextField.text!.count != 0 else{
            lastnameNotificationLabel.text = "Please enter your last name"
            notificationViewColor(view: lastnameNotificationView, color: "red")
            lastnameNotificationLabel.isHidden = false
            lastNameBool = false
            return false
        }
        guard registrationEmailTextField.text!.count != 0 else {
            emailNotificationLabel.text = "Please enter your e-mail"
            notificationViewColor(view: emailNotificationView, color: "red")
            emailNotificationLabel.isHidden = false
            emailBool = false
            return false
        }
        guard registrationPasswordTextField.text!.count != 0 else {
            passwordNotificationLabel.text = "Please enter your password"
            notificationViewColor(view: passwordNotifivationView, color: "red")
            passwordNotificationLabel.isHidden = false
            passwordBool = false
            return false
        }
        guard registrationConfirmPasswordTextField.text!.count != 0 else{
            confirmPasswordNotificationLabel.text = "Please confirm your password"
            notificationViewColor(view: confirmPasswordNotificationView, color: "red")
            confirmPasswordNotificationLabel.isHidden = false
            confirmPasswordBool = false
            return false
        }
        guard registrationChooseLanguageButton.titleLabel?.text != "Choose Language" else {
            chooseLanguageNotificationLabel.text = "Please choose a language"
            notificationViewColor(view: chooseLanguageNotificationView, color: "red")
            chooseLanguageNotificationLabel.isHidden = false
            chooseLanguageBool = false
            return false
        }
        if nameBool && lastNameBool && emailBool && passwordBool && confirmPasswordBool  && chooseLanguageBool && checkEquals() {
            checked = true
        }
        return checked
    }
    
    private func checkEquals() -> Bool {
        var equalPasswordsBool = true
        var checkedEquals = false
        if registrationPasswordTextField.text != registrationConfirmPasswordTextField.text {
            confirmPasswordNotificationLabel.text = "Repeat your password correctly"
            notificationViewColor(view: confirmPasswordNotificationView, color: "red")
            confirmPasswordNotificationLabel.isHidden = false
            equalPasswordsBool = false
            return false
        }
        if Utilities.isValidEmail(emailID: registrationEmailTextField.text!) == false {
            emailNotificationLabel.text = "Please enter a correct e-mail address"
            notificationViewColor(view: emailNotificationView, color: "color")
            emailNotificationLabel.isHidden = false
            return false
        }
        if  equalPasswordsBool && Utilities.isValidEmail(emailID: registrationEmailTextField.text!) {
            checkedEquals = true
        }
        return checkedEquals
    }
    
    private func textFieldOptions(){
        registrationEmailTextField.attributedPlaceholder = NSAttributedString(string: "Enter your E-Mail",
                                                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        registragionNameTextField.attributedPlaceholder = NSAttributedString(string: "Enter your first name",
                                                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        registrationLastNameTextField.attributedPlaceholder = NSAttributedString(string: "Enter your last name",
                                                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        registrationPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Enter your Password",
                                                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        registrationConfirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Please confirm your Password",
                                                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    private func notificationViewColor(view: UIView , color: String ){
        if color == "red"{
            view.backgroundColor = UIColor.red
        }
        else{
            view.backgroundColor = UIColor.white
        }
    }
    
    private func properties(){
        nameNotificationLabel.isHidden = true
        lastnameNotificationLabel.isHidden = true
        emailNotificationLabel.isHidden = true
        passwordNotificationLabel.isHidden = true
        confirmPasswordNotificationLabel.isHidden = true
        chooseLanguageNotificationLabel.isHidden = true
    }
    
    private func navigateToNavigationController() {
        let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarViewController") as! UITabBarController
        self.present(nextViewController, animated: true, completion: nil)
    }
}
