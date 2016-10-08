//
//  SignUpViewController.swift
//  Om
//
//  Created by Vinita on 2/28/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit
import AccountKit

class SignUpViewController: UIViewController {
    let ACCOUNT_KIT = AKFAccountKit(responseType: .AccessToken)

    var navigationHeight : CGFloat = 64
    var keyboardOffset : CGFloat = 0
    var currentlyEditedTextField : UITextField?
    var phoneNumber : String?
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var createAccountContentTopSpace: NSLayoutConstraint!

    @IBOutlet weak var createProfileButton: UIButton!
    @IBOutlet weak var mobileView: UIView!
    
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mobileHeightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createAccountContentTopSpace.constant =  DeviceType.IS_IPHONE_6_OR_MORE ? 54 : 20
    }

    override func viewWillAppear(animated: Bool) {
        self.title = "Create Account"
        
        if(self.phoneNumber != nil){
            self.mobileTextField.text = self.phoneNumber!
            self.mobileHeightConstraint.constant = 18.0
        }
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        
    }

    func findActiveResponder(view:UIView)->UIView?{
        if view.isFirstResponder() {
            return view
        } else {
            for sub in view.subviews {
                if let subView = sub as? UIView,
                    found = findActiveResponder(subView){
                    return found
                }
            }
        }
        return nil
    }
    
    func getEditingOffsetForTextField(textField : UITextField) -> CGFloat{
        return -textField.frame.origin.y + self.navigationHeight + self.keyboardOffset
    }
}

extension SignUpViewController  : UITextFieldDelegate{
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        if(DeviceType.IS_IPHONE_6_OR_MORE){

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
        }
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.keyboardOffset = self.emailTextField.frame.origin.y
        self.currentlyEditedTextField = textField
        self.view.frame.origin.y = self.getEditingOffsetForTextField(textField)
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if(self.findActiveResponder(self.view) == nil ||  self.currentlyEditedTextField == textField){
            self.view.frame.origin.y = self.navigationHeight
        }
        return true
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if(textField == self.emailTextField){
            self.emailView.backgroundColor = UIColor.getThemeColor()
            self.mobileView.backgroundColor = UIColor.blackColor()
        }
        else if(textField == self.mobileTextField){
            self.emailView.backgroundColor = UIColor.blackColor()
            self.mobileView.backgroundColor = UIColor.getThemeColor()
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.emailView.backgroundColor = UIColor.blackColor()
        self.mobileView.backgroundColor = UIColor.blackColor()
    }

    @IBAction func userSignup(sender: AnyObject) {
        if(!(self.emailTextField.text!.isValidEmail() && self.emailTextField.text!.characters.count > 0)){
            ToastView.ShowToast("Please enter a valid email ID")
        }
        else if(self.mobileTextField.text!.characters.count != 10){
            ToastView.ShowToast("Please enter a valid phone number")
        }
        else{
            if(self.phoneNumber != nil){
                self.processSignUpRequest()
            }
            else{
                if let accountKitPhoneLoginVC = ACCOUNT_KIT.viewControllerForPhoneLoginWithPhoneNumber(nil, state: nil) as? AKFViewController{
                    let theme = AKFTheme(primaryColor: UIColor.init(hexString: "#E94334"), primaryTextColor: UIColor.whiteColor(), secondaryColor: UIColor.init(hexString: "#EFEFEF"), secondaryTextColor: UIColor.init(hexString: "#44566B"), statusBarStyle: UIStatusBarStyle.LightContent)
                    accountKitPhoneLoginVC.theme = theme
                    accountKitPhoneLoginVC.whitelistedCountryCodes = ["IN"]
                    accountKitPhoneLoginVC.enableSendToFacebook = true
                    accountKitPhoneLoginVC.delegate = self
                    presentViewController(accountKitPhoneLoginVC as! UIViewController, animated: true, completion: nil)
                }
            }
        }

    }


    func processSignUpRequest(){
        let userDetails = UserProfile()
        userDetails.email = self.emailTextField.text
        userDetails.mobile = self.mobileTextField.text
        
        APIService.sharedInstance.signup(userDetails) { (newUser, error) -> Void in
            if (error == nil && newUser != nil) {
                UserSession.sharedInstance.saveUserData(newUser)
                ToastView.ShowToast("Signup Successful")
                self.navigationController?.popToRootViewControllerAnimated(true)
                NotificationManager.sharedInstance.notifyLoginChange()
            } else if(error != nil){
                ToastView.ShowToast(error!)
            }
        }
    }
}

extension SignUpViewController:AKFViewControllerDelegate{
    
    //Delegate 1
    func viewController(viewController: UIViewController!, didCompleteLoginWithAuthorizationCode code: String!, state: String!) {
        print("didCompleteLoginWithAuthorizationCode")
    }
    
    //Delegate 2
    func viewController(viewController: UIViewController!, didCompleteLoginWithAccessToken accessToken: AKFAccessToken!, state: String!) {
        ACCOUNT_KIT.requestAccount({ (account:AKFAccount?, error:NSError?) in
            if let _ = account?.phoneNumber?.stringRepresentation(){
                self.processSignUpRequest()
            }
        })
    }
    
    //Delegate 3
    func viewController(viewController: UIViewController!, didFailWithError error: NSError!) {
        print("didFailWithError: \(error)")
    }
    
    //Delegate 4
    func viewControllerDidCancel(viewController: UIViewController!) {
        print("viewControllerDidCancel")
    }
    
}