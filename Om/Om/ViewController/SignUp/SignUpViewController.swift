//
//  SignUpViewController.swift
//  Om
//
//  Created by Vinita on 2/28/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var createProfileButton: UIButton!
    @IBOutlet weak var confirmPasswordView: UIView!
    @IBOutlet weak var mobileView: UIView!
    
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var emailHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var confirmPasswordHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mobileHeightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        self.title = "Create Account"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signUpButtonClicked(button : UIButton){
        if(!(self.emailTextField.text!.isValidEmail() && self.emailTextField.text!.characters.count > 0)){
            ToastView.ShowToast("Please enter a valid email ID")
        }
        else if(self.mobileTextField.text!.characters.count != 10){
            ToastView.ShowToast("Please enter a valid phone number")
        }
        else if(self.passwordTextField.text!.characters.count == 0 || self.confirmPasswordTextField.text!.characters.count == 0){
            ToastView.ShowToast("Please enter a valid password")
        }
        else if(self.confirmPasswordTextField.text! != self.passwordTextField.text!){
            ToastView.ShowToast("Passowrd and confirm password fields do not match")
        }
        else{
            //add signup code here
        }
    }
    
}

extension SignUpViewController  : UITextFieldDelegate{
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        if(textField == self.emailTextField){
            if(newString.characters.count > 0)
            {
                self.emailHeightConstraint.constant = 18.0
            }
            else{
                self.emailHeightConstraint.constant = 0.0
            }
            self.emailTextField.updateConstraintsIfNeeded()
        }
        else if(textField == self.passwordTextField ){
            if(newString.characters.count > 0)
            {
                self.passwordHeightConstraint.constant = 18.0
            }
            else{
                self.passwordHeightConstraint.constant = 0.0
            }
            self.passwordTextField.updateConstraintsIfNeeded()
        }
        else if(textField == self.confirmPasswordTextField){
            if(newString.characters.count > 0)
            {
                self.confirmPasswordHeightConstraint.constant = 18.0
            }
            else{
                self.confirmPasswordHeightConstraint.constant = 0.0
            }
            self.confirmPasswordTextField.updateConstraintsIfNeeded()
        }
        else if(textField == self.mobileTextField){
            if(newString.characters.count > 0)
            {
                self.mobileHeightConstraint.constant = 18.0
            }
            else{
                self.mobileHeightConstraint.constant = 0.0
            }
            self.mobileTextField.updateConstraintsIfNeeded()
        }
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if(textField == self.emailTextField){
            self.emailView.backgroundColor = UIColor.getThemeColor()
            self.passwordView.backgroundColor = UIColor.blackColor()
            self.mobileView.backgroundColor = UIColor.blackColor()
            self.confirmPasswordView.backgroundColor = UIColor.blackColor()
        }
        else if(textField == self.passwordTextField ){
            self.emailView.backgroundColor = UIColor.blackColor()
            self.passwordView.backgroundColor = UIColor.getThemeColor()
            self.mobileView.backgroundColor = UIColor.blackColor()
            self.confirmPasswordView.backgroundColor = UIColor.blackColor()
        }
        else if(textField == self.confirmPasswordTextField){
            self.emailView.backgroundColor = UIColor.blackColor()
            self.passwordView.backgroundColor = UIColor.blackColor()
            self.mobileView.backgroundColor = UIColor.blackColor()
            self.confirmPasswordView.backgroundColor = UIColor.getThemeColor()
        }
        else if(textField == self.mobileTextField){
            self.emailView.backgroundColor = UIColor.blackColor()
            self.passwordView.backgroundColor = UIColor.blackColor()
            self.mobileView.backgroundColor = UIColor.getThemeColor()
            self.confirmPasswordView.backgroundColor = UIColor.blackColor()
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.emailView.backgroundColor = UIColor.blackColor()
        self.passwordView.backgroundColor = UIColor.blackColor()
        self.mobileView.backgroundColor = UIColor.blackColor()
        self.confirmPasswordView.backgroundColor = UIColor.blackColor()
    }
}