//
//  SettingsTabBarViewController.swift
//  Teacher
//
//  Created by Expl0it on 5/3/19.
//  Copyright © 2019 Hrayr. All rights reserved.
//

import Foundation
import UIKit

class SettingsTabBarViewController: UIViewController, UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate , UIPickerViewDataSource{
    
    
    
    @IBOutlet weak var profileImageView:                            UIImageView!
    @IBOutlet weak var nameTextField:                               UITextField!
    @IBOutlet weak var lastnameTextField:                           UITextField!
    @IBOutlet weak var settingsChooseLanguageButton:                UIButton!
    @IBOutlet weak var scrollBottomConstraint:                      NSLayoutConstraint!
    @IBOutlet weak var baseScrollView:                              UIScrollView!
    
    var data = ["Choose Language", "English", "France", "Armenian","Russian"]
    var picker1 = UIPickerView()
    var toolBar = UIToolbar()
    var picker:UIImagePickerController?=UIImagePickerController()
    var pickedImage = false
    var keyboardTrueHeight: CGFloat = 0.0
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerDelegate()
        textFieldOptions()
        textFieldDelegate()
        notifications()
        gestures()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard(textField)
        return true
    }
    
    func textFieldDelegate(){
        nameTextField.delegate = self
        lastnameTextField.delegate = self
    }
    
    //MARK: - Public Functions
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        settingsChooseLanguageButton.setTitle(data[row], for: .normal)
        settingsChooseLanguageButton.titleLabel?.text = data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker1.removeFromSuperview()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            return
        }
        profileImageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - IBActions
    
    @IBAction func changeLanguageButtonAction(_ sender: Any) {
        picker1 = UIPickerView.init()
        picker1.delegate = self
        picker1.backgroundColor = UIColor.init(red: 0, green: 122, blue: 255, alpha: 10)
        picker1.setValue(UIColor.black, forKey: "textColor")
        picker1.autoresizingMask = .flexibleWidth
        picker1.contentMode = .center
        picker1.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker1)
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @IBAction func changeProfilePictureButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
        openGallary()
        }
    }
    
    //MARK: - Private Functions
    
    private func pickerDelegate(){
        picker?.delegate = self
        picker1.delegate = self
        picker1.removeFromSuperview()
        picker1.dataSource = self
    }
    
    private func openGallary(){
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(picker!, animated: true, completion: nil)
    }
    
    private func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    private func textFieldOptions(){
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Enter your Name",
                                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        lastnameTextField.attributedPlaceholder = NSAttributedString(string: "Enter your Lastname",
                                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
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
