//
//  OrderConfirmationViewController.swift
//  Om
//
//  Created by Vinita on 3/5/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    
    @IBOutlet weak var confirmButton: UIButton!
    var poojaInfo = [NSDictionary]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.poojaInfo = [["Pooja Details" : ["Pooja Name" : UserSession.sharedInstance.newBookingProduct!.name, "Panditji Name" : "\(UserSession.sharedInstance.selectedVendor!.first_name!) \(UserSession.sharedInstance.selectedVendor!.last_name!)", "Date Selected" : "03- March - 2016"]], ["Amount Details" : ["Dhanteras Pooja" : "Rs. 3100"]], ["Address Details" : ["Please edit your profile to update your address"]], ["Saamagri (Included in the pooja cost and delivered to your place)" : ["Raksha (Red/ Yellow/ Orange thread", "Roree", "Sindur", "Haldi", "Abeer", "Gulal", "Chandan Wood"]]]
        self.tableView.registerNib(UINib(nibName: "TermsnConditionsCell", bundle: nil), forCellReuseIdentifier: "TermsnConditionsCell")
        self.tableView.registerNib(UINib(nibName: "BookingConfirmationHeaderCell", bundle: nil), forCellReuseIdentifier: "BookingConfirmationHeaderCell")
        self.tableView.registerNib(UINib(nibName: "BookingConfirmationContentCell", bundle: nil), forCellReuseIdentifier: "BookingConfirmationContentCell")
        self.tableView.estimatedRowHeight = 21.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.updateCoinfirmButtonState()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.title = "Booking Confirmation"
    }

    func updateCoinfirmButtonState(){
        if(UserSession.sharedInstance.loggedInUser?.address == nil){
            self.confirmButton.setTitle("UPDATE ADDRESS", forState: UIControlState.Normal)
            self.confirmButton.setTitle("UPDATE ADDRESS", forState: UIControlState.Selected)
        }
        else
        {
            self.confirmButton.setTitle("CONFIRM BUTTON", forState: UIControlState.Normal)
            self.confirmButton.setTitle("CONFIRM BUTTON", forState: UIControlState.Selected)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension OrderConfirmationViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.poojaInfo.count + 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == self.poojaInfo.count){
            return nil
        }
        else
        {
            let headerCell  = tableView.dequeueReusableCellWithIdentifier("BookingConfirmationHeaderCell") as! BookingConfirmationHeaderCell
            
            headerCell.titleLabel.text = ((self.poojaInfo[section]).allKeys[0] as! String)
            if(headerCell.titleLabel.text != "Address Details"){
                headerCell.editWidthConstraint.constant = 0
                headerCell.titleLabel.updateConstraints()
            }
            else
            {
                headerCell.editWidthConstraint.constant = 50
                headerCell.titleLabel.updateConstraints()
                
                headerCell.valueLabel.text = "edit"
            }
            return headerCell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == self.poojaInfo.count){
            return 1
        }
        else
        {
            let sectionDictionary = self.poojaInfo[section]
            if let dictionary = sectionDictionary[(sectionDictionary.allKeys as! [String])[0]] as? NSDictionary{
                return dictionary.allKeys.count
            }
            else if let array = sectionDictionary[(sectionDictionary.allKeys as! [String])[0]] as? NSArray{
                return array.count
            }
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.section == self.poojaInfo.count){
            let cell : TermsnConditionsCell = tableView.dequeueReusableCellWithIdentifier("TermsnConditionsCell") as! TermsnConditionsCell
            return cell
        }
        let cell : BookingConfirmationContentCell = tableView.dequeueReusableCellWithIdentifier("BookingConfirmationContentCell") as! BookingConfirmationContentCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let sectionDictionary = self.poojaInfo[indexPath.section]
        if let dictionary = sectionDictionary[(sectionDictionary.allKeys as! [String])[0]] as? NSDictionary{
            cell.valueLabel.hidden = false
            cell.valueLabel.text = dictionary[dictionary.allKeys[indexPath.row] as! String] as? String
            cell.titleLabel.text = dictionary.allKeys[indexPath.row] as? String
            cell.titleMutiplier.constant = -8
        }
        else if let array = sectionDictionary[(sectionDictionary.allKeys as! [String])[0]] as? NSArray{
            cell.titleLabel.text = array[indexPath.row] as? String
            cell.valueLabel.hidden = true
            cell.titleMutiplier.constant = -16
            cell.titleMutiplier = MyConstraint.changeMultiplier(cell.titleMutiplier, multiplier: 1)
            
            if((sectionDictionary.allKeys as! [String])[0] == "Address Details"){
                cell.titleLabel.textColor = UIColor.getThemeColor()
                
                if(UserSession.sharedInstance.loggedInUser?.address == nil){
                    cell.titleLabel.text = "Please edit your profile to update your address"
                }
                else
                {
                    cell.titleLabel.text = UserSession.sharedInstance.loggedInUser?.address
                }
            }
            else
            {
                cell.titleLabel.textColor = UIColor.getOrderConfirmationTitleColor()
            }
        }

        return cell
    }
}

extension OrderConfirmationViewController : UITableViewDelegate {

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == self.poojaInfo.count){
            return 0
        }
        return ceil(((UIFont.boldSystemFontOfSize(16).heightOfString(((self.poojaInfo[section] ).allKeys[0] as! String), constrainedToWidth: tableView.frame.size.width - CGFloat(16)).height) / UIFont.boldSystemFontOfSize(16).lineHeight) * UIFont.boldSystemFontOfSize(16).lineHeight) + 10
    }
}


