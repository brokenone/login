//
//  LoginBaseViewController.swift
//  Teacher
//
//  Created by Hrayr on 4/30/19.
//  Copyright © 2019 Hrayr. All rights reserved.
//

import UIKit

class LoginBaseViewController: UIViewController {
   
    @IBOutlet weak var baseScrollView:                          UIScrollView!
    @IBOutlet weak var scrollBottomConstraint:                   NSLayoutConstraint!
    var keyboardTrueHeight: CGFloat = 0.0
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notifications()
        gestures()
    }
    
    //MARK: - Keyboard
    
    @objc func keyboardWillShow(notification: Notification){
        print("Keyboard Will Show")
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardHeight = keyboardFrame.cgRectValue.height
        print(keyboardTrueHeight)
        keyboardTrueHeight = keyboardHeight
        print(keyboardTrueHeight)
        scrollBottomConstraint.constant =  keyboardTrueHeight
    }
    
    @objc func keyboardWillHide(notification: Notification){
        print("Keyboard Will Hide")
        scrollBottomConstraint.constant =  0
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("Keyboard closed by tap on screan")
        view.endEditing(true)
    }
    
    func hideKeyboard(_ textField: UITextField) {
        textField.resignFirstResponder()
        scrollBottomConstraint.constant = 0
    }
    
    func notifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification ,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification ,
                                               object: nil)
    }
    
    func gestures(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
    }
}
