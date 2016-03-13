//
//  OrderConfirmationViewController.swift
//  Om
//
//  Created by Vinita on 3/5/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    var poojaInfo = [NSDictionary]()
    var vendor : Vendor?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.poojaInfo = [["Pooja Details" : ["Pooja Name" : "Dhanteras Pooja", "Panditji Name" : "Pt. Brahmdev Pandey", "Date Selected" : "03- March - 2016"]], ["Amount Details" : ["Dhanteras Pooja" : "Rs. 3100"]], ["Address Details" : ["Please update your profile to update your address"]], ["Saamagri (Included in the pooja cost and delivered to your place)" : ["Raksha (Red/ Yellow/ Orange thread", "Roree", "Sindur", "Haldi", "Abeer", "Gulal", "Chandan Wood"]]]
        self.tableView.registerNib(UINib(nibName: "BookingConfirmationHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "BookingConfirmationHeaderCell")
        self.tableView.registerNib(UINib(nibName: "BookingConfirmationContentCell", bundle: nil), forCellReuseIdentifier: "BookingConfirmationContentCell")
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.estimatedSectionHeaderHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension OrderConfirmationViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.poojaInfo.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell  = tableView.dequeueReusableHeaderFooterViewWithIdentifier("BookingConfirmationHeaderCell") as! BookingConfirmationHeaderCell
        
        headerCell.titleLabel.text = ((self.poojaInfo[section]).allKeys[0] as! String)
        if(headerCell.titleLabel.text != "Address Details"){
            headerCell.editWidthConstraint.constant = 0
            headerCell.titleLabel.updateConstraints()
        }
        else
        {
            headerCell.editWidthConstraint.constant = 50
            headerCell.titleLabel.updateConstraints()
        }
        return headerCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionDictionary = self.poojaInfo[section]
        if let dictionary = sectionDictionary[(sectionDictionary.allKeys as! [String])[0]] as? NSDictionary{
            return dictionary.allKeys.count
        }
        else if let array = sectionDictionary[(sectionDictionary.allKeys as! [String])[0]] as? NSArray{
            return array.count
        }
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : BookingConfirmationContentCell = tableView.dequeueReusableCellWithIdentifier("BookingConfirmationContentCell") as! BookingConfirmationContentCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let sectionDictionary = self.poojaInfo[indexPath.section]
        if let dictionary = sectionDictionary[(sectionDictionary.allKeys as! [String])[0]] as? NSDictionary{
            cell.valueLabel.hidden = false
            cell.valueLabel.text = dictionary[dictionary.allKeys[indexPath.row] as! String] as? String
            cell.titleLabel.text = dictionary.allKeys[indexPath.row] as? String
        }
        else if let array = sectionDictionary[(sectionDictionary.allKeys as! [String])[0]] as? NSArray{
            cell.titleLabel.text = array[indexPath.row] as? String
            cell.valueLabel.hidden = true
        }
        return cell
    }
}

extension OrderConfirmationViewController : UITableViewDelegate {

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIFont.boldSystemFontOfSize(16).heightOfString(((self.poojaInfo[section]).allKeys[0] as! String), constrainedToWidth: tableView.frame.size.width - )
    }
}
