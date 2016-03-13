//
//  LoginViewController.swift
//  Om
//
//  Created by Vinita on 2/28/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit
import KSToastView

enum FocusType {
    case MobileType
    case PasswordType
    case DefaultType
}


class LoginViewController: UIViewController {
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
        self.updateUIStateForType(.DefaultType)
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    func updateUIStateForType(type : FocusType){
        switch(type){
            case FocusType.MobileType:
                self.mobileHeightConstraint.constant = 21
                self.mobileHighLightView.backgroundColor = UIColor.getThemeColor()
                self.mobileLabel.textColor = UIColor.getThemeColor()
                self.passwordLabel.textColor = UIColor.blackColor()
                self.passwordHeightConstraint.constant = 0
                self.passwordHighLightView.backgroundColor = UIColor.blackColor()
                self.mobileTextField.tintColor = UIColor.getThemeColor()
                break
            case FocusType.PasswordType:
                self.mobileHeightConstraint.constant = 0
                self.mobileHighLightView.backgroundColor = UIColor.blackColor()
                self.mobileLabel.textColor = UIColor.blackColor()
                self.passwordLabel.textColor = UIColor.getThemeColor()
                self.passwordHeightConstraint.constant = 21
                self.mobileHighLightView.backgroundColor = UIColor.getThemeColor()
                break
            default:
                self.mobileHeightConstraint.constant = 0
                self.passwordHeightConstraint.constant = 0
                self.mobileHighLightView.backgroundColor = UIColor.blackColor()
                self.passwordHeightConstraint.constant = 0
                self.mobileHighLightView.backgroundColor = UIColor.blackColor()
                break
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.title = "User Login"
    }

    @IBAction func loginButtonClicked(sender: AnyObject) {
        // validate user

        APIService.sharedInstance.validateUser(self.mobileTextField.text!, password: self.passwordtextField.text!) { (response) -> Void in
            if (response.result.isSuccess) {
                self.navigationController?.popViewControllerAnimated(true)
                debugPrint("logged in user", response.result.value)

                if let json = response.result.value {
                    let userProfileDict = json as? NSDictionary
                    let userProfile = UserProfile(dataDict: userProfileDict!)
                    UserSession.sharedInstance.loggedInUser = userProfile

                    ToastView.ShowToast("Welcome \(userProfile.first_name!)")
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

extension LoginViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.updateUIStateForType(textField == self.mobileTextField ? .MobileType : .PasswordType)
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        self.updateUIStateForType(.DefaultType)
        return true
    }
}
