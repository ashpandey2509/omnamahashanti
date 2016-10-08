//
//  LoginViewController.swift
//  Om
//
//  Created by Vinita on 2/28/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit
import AccountKit

import KSToastView
class LoginViewController: UIViewController {
    let ACCOUNT_KIT = AKFAccountKit(responseType: .AccessToken)

    @IBOutlet weak var loginButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var createAccountTopSpace: NSLayoutConstraint!
        
    @IBOutlet weak var mobileHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var passwordHighLightView: UIView!
    @IBOutlet weak var passwordtextField: UITextField!
    @IBOutlet weak var passwordHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var mobileHighLightView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.loginButtonBottomConstraint.constant =  DeviceType.IS_IPHONE_6_OR_MORE ? 43 : 25
        self.createAccountTopSpace.constant =  DeviceType.IS_IPHONE_6_OR_MORE ? 43 : 15

    }
    
    override func viewWillAppear(animated: Bool) {
        self.title = "User Login"
    }


    @IBAction func loginButtonClicked(sender: AnyObject) {
        if let accountKitPhoneLoginVC = ACCOUNT_KIT.viewControllerForPhoneLoginWithPhoneNumber(nil, state: nil) as? AKFViewController{
            let theme = AKFTheme(primaryColor: UIColor.init(hexString: "#E94334"), primaryTextColor: UIColor.whiteColor(), secondaryColor: UIColor.init(hexString: "#EFEFEF"), secondaryTextColor: UIColor.init(hexString: "#44566B"), statusBarStyle: UIStatusBarStyle.LightContent)
            accountKitPhoneLoginVC.theme = theme
            accountKitPhoneLoginVC.whitelistedCountryCodes = ["IN"]
            accountKitPhoneLoginVC.enableSendToFacebook = true
            accountKitPhoneLoginVC.delegate = self
            presentViewController(accountKitPhoneLoginVC as! UIViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func createPorfileButtonClicked(sender: AnyObject) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.title = ""
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension LoginViewController  : UITextFieldDelegate{
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        if(DeviceType.IS_IPHONE_6_OR_MORE){
            if(textField == self.mobileTextField){
                if(newString.characters.count > 0)
                {
                    self.mobileHeightConstraint.constant = 18.0
                }
                else{
                    self.mobileHeightConstraint.constant = 0.0
                }
                self.mobileTextField.updateConstraintsIfNeeded()
            }
            else if(textField == self.passwordtextField ){
                if(newString.characters.count > 0)
                {
                    self.passwordHeightConstraint.constant = 18.0
                }
                else{
                    self.passwordHeightConstraint.constant = 0.0
                }
                self.passwordtextField.updateConstraintsIfNeeded()
            }
        }
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if(textField == self.mobileTextField){
            self.mobileHighLightView.backgroundColor = UIColor.getThemeColor()
            self.passwordHighLightView.backgroundColor = UIColor.blackColor()
        }
        else if(textField == self.passwordtextField){
            self.mobileHighLightView.backgroundColor = UIColor.blackColor()
            self.passwordHighLightView.backgroundColor = UIColor.getThemeColor()
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.mobileHighLightView.backgroundColor = UIColor.blackColor()
        self.passwordHighLightView.backgroundColor = UIColor.blackColor()
    }
}


extension LoginViewController:AKFViewControllerDelegate{
    
    //Delegate 1
    func viewController(viewController: UIViewController!, didCompleteLoginWithAuthorizationCode code: String!, state: String!) {
        print("didCompleteLoginWithAuthorizationCode")
    }
    
    //Delegate 2
    func viewController(viewController: UIViewController!, didCompleteLoginWithAccessToken accessToken: AKFAccessToken!, state: String!) {
        ACCOUNT_KIT.requestAccount({ (account:AKFAccount?, error:NSError?) in
            if let phoneNumber = account?.phoneNumber?.stringRepresentation(){
                APIService.sharedInstance.getUserDetails(phoneNumber, callback: { (userProfile, error) in
                    if(userProfile != nil){
                        UserSession.sharedInstance.saveUserData(userProfile)
                         self.navigationController?.popToRootViewControllerAnimated(true)
                           NotificationManager.sharedInstance.notifyLoginChange()
                    }
                    else if(error != nil){
                        
                    }
                    else{
                        let signUpVC = self.storyboard?.instantiateViewControllerWithIdentifier("SignUpViewController") as! SignUpViewController
                        signUpVC.phoneNumber = phoneNumber.stringByReplacingOccurrencesOfString("+91", withString: "")
                        self.navigationController?.pushViewController(signUpVC, animated: true)
                        
                    }
                })
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
