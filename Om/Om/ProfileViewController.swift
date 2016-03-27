//
//  ProfileViewController.swift
//  Om
//
//  Created by Naik, Parag Laxman (US - Mumbai) on 3/1/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import Foundation

class ProfileViewController: ViewController {
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var firstNameHeight: NSLayoutConstraint!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameHeight: NSLayoutConstraint!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var emailHeight: NSLayoutConstraint!
    
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var casteView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var casteHeight: NSLayoutConstraint!
    @IBOutlet weak var casteTextField: UITextField!
    @IBOutlet weak var addressHeight: NSLayoutConstraint!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var languageHeight: NSLayoutConstraint!
    @IBOutlet weak var languageTextField: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        self.title = "Edit Profile"
    }
    
    override func viewDidLoad() {
        self.firstNameTextField.text = UserSession.sharedInstance.loggedInUser?.first_name
        self.lastNameTextField.text = UserSession.sharedInstance.loggedInUser?.last_name
        self.emailTextField.text = UserSession.sharedInstance.loggedInUser?.email
        self.casteTextField.text = UserSession.sharedInstance.loggedInUser?.caste
        self.addressTextField.text = UserSession.sharedInstance.loggedInUser?.address
        self.languageTextField.text = UserSession.sharedInstance.loggedInUser?.preferred_language

    }
    
    
}

extension ProfileViewController  : UITextFieldDelegate{
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        if(textField == self.firstNameTextField){
            if(newString.characters.count > 0)
            {
                self.firstNameHeight.constant = 18.0
            }
            else{
                self.firstNameHeight.constant = 0.0
            }
            self.firstNameTextField.updateConstraintsIfNeeded()
        }
        else if(textField == self.lastNameTextField){
            if(newString.characters.count > 0)
            {
                self.lastNameHeight.constant = 18.0
            }
            else{
                self.lastNameHeight.constant = 0.0
            }
            self.lastNameTextField.updateConstraintsIfNeeded()
        }
        else if(textField == self.emailTextField){
            if(newString.characters.count > 0)
            {
                self.emailHeight.constant = 18.0
            }
            else{
                self.emailHeight.constant = 0.0
            }
            self.emailTextField.updateConstraintsIfNeeded()
        }
        else if(textField == self.casteTextField){
            if(newString.characters.count > 0)
            {
                self.casteHeight.constant = 18.0
            }
            else{
                self.casteHeight.constant = 0.0
            }
            self.casteTextField.updateConstraintsIfNeeded()
        }
        else if(textField == self.addressTextField){
            if(newString.characters.count > 0)
            {
                self.addressHeight.constant = 18.0
            }
            else{
                self.addressHeight.constant = 0.0
            }
            self.addressTextField.updateConstraintsIfNeeded()
        }
        else if(textField == self.languageTextField){
            if(newString.characters.count > 0)
            {
                self.languageHeight.constant = 18.0
            }
            else{
                self.languageHeight.constant = 0.0
            }
            self.languageTextField.updateConstraintsIfNeeded()
        }
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if(textField == self.emailTextField){
            self.emailView.backgroundColor = UIColor.getThemeColor()
            self.addressView.backgroundColor = UIColor.blackColor()
            self.languageView.backgroundColor = UIColor.blackColor()
            self.casteView.backgroundColor = UIColor.blackColor()
            self.lastNameView.backgroundColor = UIColor.blackColor()
            self.firstNameView.backgroundColor = UIColor.blackColor()
        }
        else if(textField == self.addressTextField){
            self.emailView.backgroundColor = UIColor.blackColor()
            self.addressView.backgroundColor = UIColor.getThemeColor()
            self.languageView.backgroundColor = UIColor.blackColor()
            self.casteView.backgroundColor = UIColor.blackColor()
            self.lastNameView.backgroundColor = UIColor.blackColor()
            self.firstNameView.backgroundColor = UIColor.blackColor()
        }
        else if(textField == self.languageTextField){
            self.emailView.backgroundColor = UIColor.blackColor()
            self.addressView.backgroundColor = UIColor.blackColor()
            self.languageView.backgroundColor = UIColor.getThemeColor()
            self.casteView.backgroundColor = UIColor.blackColor()
            self.lastNameView.backgroundColor = UIColor.blackColor()
            self.firstNameView.backgroundColor = UIColor.blackColor()
        }
        else if(textField == self.casteTextField){
            self.emailView.backgroundColor = UIColor.blackColor()
            self.addressView.backgroundColor = UIColor.blackColor()
            self.languageView.backgroundColor = UIColor.blackColor()
            self.casteView.backgroundColor = UIColor.getThemeColor()
            self.lastNameView.backgroundColor = UIColor.blackColor()
            self.firstNameView.backgroundColor = UIColor.blackColor()
        }
        else if(textField == self.lastNameTextField){
            self.emailView.backgroundColor = UIColor.blackColor()
            self.addressView.backgroundColor = UIColor.blackColor()
            self.languageView.backgroundColor = UIColor.blackColor()
            self.casteView.backgroundColor = UIColor.blackColor()
            self.lastNameView.backgroundColor = UIColor.getThemeColor()
            self.firstNameView.backgroundColor = UIColor.blackColor()
        }
        else if(textField == self.firstNameTextField){
            self.emailView.backgroundColor = UIColor.blackColor()
            self.addressView.backgroundColor = UIColor.blackColor()
            self.languageView.backgroundColor = UIColor.blackColor()
            self.casteView.backgroundColor = UIColor.blackColor()
            self.lastNameView.backgroundColor = UIColor.blackColor()
            self.firstNameView.backgroundColor = UIColor.getThemeColor()
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.emailView.backgroundColor = UIColor.blackColor()
        self.addressView.backgroundColor = UIColor.blackColor()
        self.languageView.backgroundColor = UIColor.blackColor()
        self.casteView.backgroundColor = UIColor.blackColor()
        self.lastNameView.backgroundColor = UIColor.blackColor()
        self.firstNameView.backgroundColor = UIColor.blackColor()
    }

    @IBAction func editProfile(sender: AnyObject) {

        let userProfile = UserSession.sharedInstance.loggedInUser
        userProfile?.first_name = firstNameTextField.text
        userProfile?.last_name = lastNameTextField.text
        userProfile?.email = emailTextField.text
        userProfile?.caste = casteTextField.text
        userProfile?.address = addressTextField.text
        userProfile?.preferred_language = languageTextField.text

        let activityIndicator = ActivityIndicator(parent: self.view)
        self.view.addSubview(activityIndicator)
        activityIndicator.showIndicator()

        APIService.sharedInstance.editProfile(userProfile!) { (response) -> Void in
            self.view.endEditing(true)
            activityIndicator.hideIndicator()

            if (response.result.isSuccess) {
                debugPrint(response.result.value)
                ToastView.ShowToast("User profile update is successful")
            } else {
                debugPrint(response.result.error)
                ToastView.ShowToast("Error updating user profile. Try again later.")
            }
        }
    }


}