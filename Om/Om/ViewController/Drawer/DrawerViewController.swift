//
//  DrawerViewController.swift
//  Om
//
//  Created by Vinita on 2/26/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit
import MessageUI

class DrawerViewController: UIViewController {


    @IBOutlet weak var drawerHeaderUserName: UILabel!
    @IBOutlet weak var tableView: UITableView!

    let preSigninArray = [["icon" : "ic_action_login" , "title" : "Login", "centerIdentifier" : "LoginViewController"],
        ["icon" : "ic_action_rate_app" , "title" : "Rate App", "action" : "rateApp"],
        ["icon" : "ic_action_terms" , "title" : "Terms & Conditions", "centerIdentifier" : "TermsnConditionsViewController"],
        ["icon" : "ic_action_privacy" , "title" : "Privacy Policy", "centerIdentifier" : "PrivacyPolicyViewController"],
        ["icon" : "ic_action_contact_us" , "title" : "Contact Us", "action" : "sendEmail"]]

    let postSigninArray = [["icon" : "ic_action_login" , "title" : "Logout", "action" : "logoutClicked"],
        ["icon" : "ic_action_login" , "title" : "Edit Profile", "centerIdentifier" : "ProfileViewController"],
        ["icon" : "ic_action_rate_app" , "title" : "Rate App", "action" : "rateApp"],
        ["icon" : "ic_action_terms" , "title" : "Terms & Conditions", "centerIdentifier" : "TermsnConditionsViewController"],
        ["icon" : "ic_action_privacy" , "title" : "Privacy Policy", "centerIdentifier" : "PrivacyPolicyViewController"],
        ["icon" : "ic_action_contact_us" , "title" : "Contact Us", "action" : "sendEmail"]]

    var currentDrawerArray = [NSDictionary]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
        currentDrawerArray = preSigninArray
    }

    override func viewWillAppear(animated: Bool) {
        self.updateDrawerState()
    }
    
    func updateDrawerState(){
        if (UserSession.sharedInstance.isLoggedInUser()) {
            updateDrawerForLoggedInUser()
        } else {
            updateDrawerForLoggedOutUser()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateDrawerForLoggedInUser() {
        if let user = UserSession.sharedInstance.loggedInUser {
            drawerHeaderUserName.text = user.first_name! + " " + user.last_name!
        }

        currentDrawerArray = postSigninArray
        self.tableView.reloadData()
    }

    func updateDrawerForLoggedOutUser() {
        drawerHeaderUserName.text = "Please login to see your data"
        currentDrawerArray = preSigninArray
        self.tableView.reloadData()
    }

    func sendEmail() {
        if !MFMailComposeViewController.canSendMail() {
            print("Mail Services are not available")
        } else {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self

            // Configure the fields of the interface.
            composeVC.setToRecipients(["contact@omnamahshanti.com"])
            composeVC.setSubject("Feedback for OM")
            composeVC.setMessageBody("", isHTML: false)

            (self.mm_drawerController.centerViewController as! UINavigationController).presentViewController(composeVC, animated: true, completion: nil)

            self.mm_drawerController.closeDrawerAnimated(true, completion: nil)
        }
    }

    func rateApp() {
        ToastView.ShowToast("Coming Soon!")
    }
    
    func logoutClicked(){
        UserSession.sharedInstance.products = nil
        UserSession.sharedInstance.loggedInUser = nil
        UserSession.sharedInstance.newBooking?.user_id = nil
        self.updateDrawerState()
        self.mm_drawerController.closeDrawerAnimated(true, completion: nil)
        NotificationManager.sharedInstance.notifyLoginChange()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension DrawerViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDrawerArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : DrawerTableViewCell = tableView.dequeueReusableCellWithIdentifier("DrawerTableViewCell") as! DrawerTableViewCell
        let dictionary = self.currentDrawerArray[indexPath.row]
        cell.iconImageView.image = UIImage(named: dictionary["icon"]! as! String)
        cell.titleLabel.text = dictionary["title"]! as? String
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
}


extension DrawerViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dictionary = self.currentDrawerArray[indexPath.row]
        if let identifier = dictionary["centerIdentifier"]{
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier(identifier as! String)
            (self.mm_drawerController.centerViewController as! UINavigationController).pushViewController(viewController!, animated: true)
            self.mm_drawerController.closeDrawerAnimated(true, completion: nil)
        }

        if let action = dictionary["action"] {
            self.performSelector(Selector(action as! String))
        }
    }
}

extension DrawerViewController: MFMailComposeViewControllerDelegate {

    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {

        // TODO: Show Toast for email
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

