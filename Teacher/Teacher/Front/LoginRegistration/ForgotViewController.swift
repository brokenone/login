//
//  ForgotViewController.swift
//  Teacher
//
//  Created by Hrayr on 4/30/19.
//  Copyright © 2019 Hrayr. All rights reserved.
//

import UIKit

class ForgotViewController: LoginBaseViewController, UITextFieldDelegate {
    @IBOutlet weak var forgotNotificationLabel: UILabel!
    @IBOutlet weak var forgotEmailTextField: UITextField!
    @IBOutlet weak var notificationView: UIView!
    
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
        forgotEmailTextField.delegate = self
    }
    
    //MARK: - IBActions
    
    @IBAction func resetButtonAction(_ sender: Any) {
        forgotNotificationLabel.isHidden = true
        notificationViewColor(view: notificationView, color: "white")
        guard let forgotEmailText = forgotEmailTextField.text, forgotEmailTextField.text!.count != 0 else {
            forgotNotificationLabel.text = "Please enter your E-Mail"
            forgotNotificationLabel.isHidden = false
            notificationViewColor(view: notificationView, color: "red")
            return
        }
        if Utilities.isValidEmail(emailID: forgotEmailText) == false {
            forgotNotificationLabel.text = "Please enter a correct E-Mail"
            forgotNotificationLabel.isHidden = false
            notificationViewColor(view: notificationView, color: "red")
        }
        if forgotEmailTextField.text!.count != 0 && Utilities.isValidEmail(emailID: forgotEmailText) == true {
            print("Go To Next Page")
            navigateToNavigationController()
        }
    }
    
    //MARK: - Private Functions
    
    private func properties(){
        forgotNotificationLabel.isHidden = true
    }
    
    private func navigateToNavigationController() {
        let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigationController") as! UINavigationController
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    private func textFieldOptions(){
        forgotEmailTextField.attributedPlaceholder = NSAttributedString(string: "Enter your E-Mail",
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
}
