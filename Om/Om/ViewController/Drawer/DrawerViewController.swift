//
//  DrawerViewController.swift
//  Om
//
//  Created by Vinita on 2/26/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit

class DrawerViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    let preSigninArray = [["icon" : "ic_action_login" , "title" : "Login", "centerIdentifier" : "LoginViewController"],
        ["icon" : "ic_action_login" , "title" : "Profile", "centerIdentifier" : "LoginViewController"],
        ["icon" : "ic_action_rate_app" , "title" : "Rate App"],
        ["icon" : "ic_action_terms" , "title" : "Terms & Conditions", "centerIdentifier" : "TermsnConditionsViewController"],
        ["icon" : "ic_action_privacy" , "title" : "Privacy Policy", "centerIdentifier" : "PrivacyPolicyViewController"],
            ["icon" : "ic_action_contact_us" , "title" : "Contact Us"]]

    let postSigninArray = [["icon" : "" , "title" : "Login"],
        ["icon" : "" , "title" : "Rate App"],
        ["icon" : "" , "title" : "Terms & Conditions"],
        ["icon" : "" , "title" : "Privacy Policy"],
        ["icon" : "" , "title" : "Contact Us"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return preSigninArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : DrawerTableViewCell = tableView.dequeueReusableCellWithIdentifier("DrawerTableViewCell") as! DrawerTableViewCell
        let dictionary = self.preSigninArray[indexPath.row] 
        cell.iconImageView.image = UIImage(named: dictionary["icon"]!)
        cell.titleLabel.text = dictionary["title"]!
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
}


extension DrawerViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dictionary = self.preSigninArray[indexPath.row]
        if let identifier = dictionary["centerIdentifier"]{
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier(identifier)
            (self.mm_drawerController.centerViewController as! UINavigationController).pushViewController(viewController!, animated: true)
            self.mm_drawerController.closeDrawerAnimated(true, completion: nil)
        }
    }
}

