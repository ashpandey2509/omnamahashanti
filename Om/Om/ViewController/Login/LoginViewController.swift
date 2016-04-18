//
//  LoginViewController.swift
//  Om
//
//  Created by Vinita on 2/28/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit
import KSToastView

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var createAccountTopSpace: NSLayoutConstraint!
    
    @IBOutlet weak var profileBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileTopConstraint: NSLayoutConstraint!
    
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
        
        self.profileBottomConstraint.constant =  DeviceType.IS_IPHONE_6_OR_MORE ? 92 : 20
        self.profileTopConstraint.constant =  DeviceType.IS_IPHONE_6_OR_MORE ? 78 : 15
        self.loginButtonBottomConstraint.constant =  DeviceType.IS_IPHONE_6_OR_MORE ? 43 : 15
        self.createAccountTopSpace.constant =  DeviceType.IS_IPHONE_6_OR_MORE ? 43 : 15
    }
    
    override func viewWillAppear(animated: Bool) {
        self.title = "User Login"
    }

    @IBAction func loginButtonClicked(sender: AnyObject) {
        // validate user
        let activityIndicator = ActivityIndicator(parent: self.view)
        self.view.addSubview(activityIndicator)
        activityIndicator.showIndicator()
        APIService.sharedInstance.validateUser(self.mobileTextField.text!, password: self.passwordtextField.text!) { (response) -> Void in
            activityIndicator.hideIndicator()

            if (response.result.isSuccess) {
                self.navigationController?.popViewControllerAnimated(true)
                debugPrint("logged in user", response.result.value)

                if let json = response.result.value {
                    let userProfileDict = json as? NSDictionary
                    let userProfile = UserProfile(dataDict: userProfileDict!)
                    UserSession.sharedInstance.saveUserData(userProfile)

                    NotificationManager.sharedInstance.notifyLoginChange()

                    if let firstName = userProfile.first_name {
                        ToastView.ShowToast("Welcome \(firstName)")
                    } else {
                        ToastView.ShowToast("Welcome \(userProfile.email!)")
                    }
                }
            } else {
                ToastView.ShowToast("Invalid Credentials. Please try again.")
            }
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

}

extension LoginViewController  : UITextFieldDelegate{
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
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
