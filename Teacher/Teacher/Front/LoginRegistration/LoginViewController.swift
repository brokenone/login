//
//  LoginViewController.swift
//  Teacher
//
//  Created by Hrayr on 4/30/19.
//  Copyright © 2019 Hrayr. All rights reserved.
//

import UIKit

class LoginViewController: LoginBaseViewController, UITextFieldDelegate  {
   
    @IBOutlet weak var emailTextField:                  UITextField!
    @IBOutlet weak var passwordTextField:               UITextField!
    @IBOutlet weak var loginEmailNotificationLabel:     UILabel!
    @IBOutlet weak var loginPasswordNotificationLabel:  UILabel!
    @IBOutlet weak var emailNotifivationView:           UIView!
    @IBOutlet weak var passwordNotificationView:        UIView!
    
    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        properties()
        textFieldDelegate()
        textFieldOptions()
    }
    
    // MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard(textField)
        return true
    }
    
    func textFieldDelegate(){
        passwordTextField.delegate = self
        emailTextField.delegate = self
    }

    //MARK: - IBActions
    
    @IBAction func loginButtonAction(_ sender: Any) {
        loginEmailNotificationLabel.isHidden = true
        loginPasswordNotificationLabel.isHidden = true
        notificationViewColor(view: emailNotifivationView, color: "white")
        notificationViewColor(view: passwordNotificationView, color: "white")
        guard let emailText = emailTextField.text, emailTextField.text!.count != 0 else {
            loginEmailNotificationLabel.text = "Please enter your E-Mail"
            loginEmailNotificationLabel.isHidden = false
            notificationViewColor(view: emailNotifivationView, color: "red")
            return
        }
        guard passwordTextField.text!.count != 0 else {
            loginPasswordNotificationLabel.text = "Please enter your Password"
            loginPasswordNotificationLabel.isHidden = false
            notificationViewColor(view: passwordNotificationView, color: "red")
            return
        }
        if Utilities.isValidEmail(emailID: emailText) == false{
            loginEmailNotificationLabel.text = "Please enter a correct E-Mail"
            loginEmailNotificationLabel.isHidden = false
            notificationViewColor(view: emailNotifivationView, color: "red")
        }
        if emailTextField.text!.count != 0 && passwordTextField.text!.count != 0 && Utilities.isValidEmail(emailID: emailText) == true{
            print("Go To Next ViewController")
            navigateToNavigationController()
        }
    }
    
    //MARK: - Private Functions
    
    private func properties(){
        loginEmailNotificationLabel.isHidden = true
        loginPasswordNotificationLabel.isHidden = true
    }
    
    private func textFieldOptions(){
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Enter your E-Mail",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Enter your Password",
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
    
    private func navigateToNavigationController() {
        let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarViewController") as! UITabBarController
        self.present(nextViewController, animated: true, completion: nil)
    }
}
