//
//  OrderConfirmationViewController.swift
//  Om
//
//  Created by Vinita on 3/5/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit
import KSToastView
class OrderConfirmationViewController: UIViewController {

    private let KEY_ADDRESS_DETAIL = "Address Details"

    var isTermsAccepted = false
    @IBOutlet weak var confirmButton: UIButton!
    var poojaInfo = [BookingConfirmationGroup]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tncButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        let newBooking = UserSession.sharedInstance.newBooking!

        let bookingDetails = BookingConfirmationGroup(header: "Pooja Details", type: BookingConfirmationGroup.GROUP_TYPE_KEY_VALUE)
        bookingDetails.entries?.append(BookingConfirmationEntry(title: "Pooja Name", value: (newBooking.product?.name)!))
        bookingDetails.entries?.append(BookingConfirmationEntry(title: "Panditji Name", value: (newBooking.vendor?.first_name)!))
        bookingDetails.entries?.append(BookingConfirmationEntry(title: "Date Selected", value: getFormattedDate()))


        let amountDetails = BookingConfirmationGroup(header: "Amount Details", type: BookingConfirmationGroup.GROUP_TYPE_KEY_VALUE)
        amountDetails.entries?.append(BookingConfirmationEntry(title: (newBooking.product?.name)!, value: String("₹ \((newBooking.product?.cost)!)")))

        let addressDetails = BookingConfirmationGroup(header: KEY_ADDRESS_DETAIL, type: BookingConfirmationGroup.GROUP_TYPE_STRING_ARRAY)
        addressDetails.entries?.append("User Address")

        let productIngredientsGroup = BookingConfirmationGroup(header: "Saamagri (included in the pooja cost and delivered to your place)", type: BookingConfirmationGroup.GROUP_TYPE_STRING_ARRAY)
        for ingredient in (newBooking.product?.items)! {
            productIngredientsGroup.entries?.append(ingredient)
        }

        poojaInfo.append(bookingDetails)
        poojaInfo.append(amountDetails)
        poojaInfo.append(addressDetails)
        poojaInfo.append(productIngredientsGroup)

        self.tableView.registerNib(UINib(nibName: "TermsnConditionsCell", bundle: nil), forCellReuseIdentifier: "TermsnConditionsCell")
        self.tableView.registerNib(UINib(nibName: "BookingConfirmationHeaderCell", bundle: nil), forCellReuseIdentifier: "BookingConfirmationHeaderCell")
        self.tableView.registerNib(UINib(nibName: "BookingConfirmationContentCell", bundle: nil), forCellReuseIdentifier: "BookingConfirmationContentCell")
        self.tableView.estimatedRowHeight = 22.0
        self.tableView.rowHeight = UITableViewAutomaticDimension

        self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedSectionHeaderHeight = 26;

    }
    
    override func viewWillAppear(animated: Bool) {
        self.title = "Booking Confirmation"
        updateConfirmButtonState()
        self.tableView.reloadData()
    }

    func navigateToProfile(){
        self.title = ""
        let profileVC = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(profileVC, animated: true)
    }

    func navigateToLogin(){
        self.title = ""
        let loginVC = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func tncAccepted(sender: AnyObject) {
        tncButton.selected = !tncButton.selected
        isTermsAccepted = tncButton.selected
    }


    func updateConfirmButtonState(){
        if(UserSession.sharedInstance.loggedInUser == nil){
            self.confirmButton.setTitle("PLEASE LOGIN", forState: UIControlState.Normal)
            self.confirmButton.setTitle("PLEASE LOGIN", forState: UIControlState.Selected)
        } else if(UserSession.sharedInstance.loggedInUser?.address == nil){
            self.confirmButton.setTitle("UPDATE ADDRESS", forState: UIControlState.Normal)
            self.confirmButton.setTitle("UPDATE ADDRESS", forState: UIControlState.Selected)
        } else {
            self.confirmButton.setTitle("CONFIRM BOOKING", forState: UIControlState.Normal)
            self.confirmButton.setTitle("CONFIRM BOOKING", forState: UIControlState.Selected)
        }
    }
    
    @IBAction func orderConfirmationButtonClicked(sender: AnyObject) {
        if(UserSession.sharedInstance.loggedInUser == nil){
            self.navigateToLogin()
        } else if(UserSession.sharedInstance.loggedInUser?.address == nil || UserSession.sharedInstance.loggedInUser?.address == ""){
            self.navigateToProfile()
        } else {
            if(!self.isTermsAccepted){
                KSToastView.ks_showToast("Please agree to the terms and conditions.")
            } else {
                let activityIndicator = ActivityIndicator(parent: self.view)
                self.view.addSubview(activityIndicator)
                activityIndicator.showIndicator()
                APIService.sharedInstance.book(UserSession.sharedInstance.newBooking!, address: UserSession.sharedInstance.loggedInUser!.address!, callback: { (response) -> Void in

                    if response.result.isSuccess {
                        ToastView.ShowToast("Booking Confirmed")
                        self.navigationController?.popToRootViewControllerAnimated(true)
                    } else {
                        ToastView.ShowToast("Booking Error. Try again after some time.")
                    }
                    activityIndicator.hideIndicator()
            })
            }
        }
    }

    func acceptTerms(button : UIButton){
        self.isTermsAccepted = !self.isTermsAccepted
        self.tableView.reloadData()
    }
    
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        self.navigateToProfile()
    }
    
    func getFormattedDate() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let dateString = dateFormatter.stringFromDate((UserSession.sharedInstance.newBooking?.book_date_NSDate)!)
        return dateString
    }
}

extension OrderConfirmationViewController : UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.poojaInfo.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == self.poojaInfo.count){
            return nil
        }
        else
        {
            let headerCell  = tableView.dequeueReusableCellWithIdentifier("BookingConfirmationHeaderCell") as! BookingConfirmationHeaderCell

            headerCell.titleLabel.text = ((self.poojaInfo[section]).header)
            if(headerCell.titleLabel.text != "Address Details" || UserSession.sharedInstance.loggedInUser == nil){
                headerCell.editWidthConstraint.constant = 0
                headerCell.titleLabel.updateConstraints()
            }
            else if(UserSession.sharedInstance.loggedInUser != nil)
            {
                headerCell.editWidthConstraint.constant = 50
                headerCell.titleLabel.updateConstraints()
                
                headerCell.valueLabel.text = "edit"
                
                let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
                headerCell.valueLabel.addGestureRecognizer(tap)
            }
            return headerCell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == self.poojaInfo.count) {
            return 1
        } else {
            return self.poojaInfo[section].entries!.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let bookingConfirmationGroupInfo = self.poojaInfo[indexPath.section]

        let cell : BookingConfirmationContentCell = tableView.dequeueReusableCellWithIdentifier("BookingConfirmationContentCell") as! BookingConfirmationContentCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None

        if (bookingConfirmationGroupInfo.type == BookingConfirmationGroup.GROUP_TYPE_KEY_VALUE) {

            let bookingEntry = bookingConfirmationGroupInfo.entries![indexPath.row] as! BookingConfirmationEntry

            cell.valueLabel.hidden = false
            cell.valueLabel.text = bookingEntry.value
            cell.titleLabel.text = bookingEntry.title
            cell.titleMutiplier.constant = -8

        } else if (bookingConfirmationGroupInfo.type == BookingConfirmationGroup.GROUP_TYPE_STRING_ARRAY) {

            let bookingEntry = bookingConfirmationGroupInfo.entries![indexPath.row] as! String

            cell.titleLabel.text = bookingEntry
            cell.valueLabel.hidden = true
            cell.titleMutiplier.constant = -16
            cell.titleLabel.textColor = UIColor.getSamagriColor()
            cell.titleMutiplier = MyConstraint.changeMultiplier(cell.titleMutiplier, multiplier: 1)
        }

        if bookingConfirmationGroupInfo.header == KEY_ADDRESS_DETAIL {
            setupAddressCell(cell)
        }

        return cell
    }

    func setupAddressCell(cell : BookingConfirmationContentCell) {
        cell.titleLabel.textColor = UIColor.getThemeColor()

        if (UserSession.sharedInstance.loggedInUser == nil) {
            cell.titleLabel.text = "Please login to fetch your address"
        }
        else if (UserSession.sharedInstance.loggedInUser?.address == nil || UserSession.sharedInstance.loggedInUser?.address == "") {
            cell.titleLabel.text = "Please edit your profile to update your address"
        }
        else {
            cell.titleLabel.text = UserSession.sharedInstance.loggedInUser?.address
        }
    }
}
