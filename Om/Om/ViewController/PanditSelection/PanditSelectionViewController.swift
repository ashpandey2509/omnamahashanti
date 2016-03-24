//
//  PanditSelectionViewController.swift
//  Om
//
//  Created by Vinita on 2/27/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit
import Haneke

class PanditSelectionViewController: UIViewController {

    var vendors = [Vendor]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateCollectionView: UICollectionView!
    var selectedTimeSlot : String?
    var selectedIndex : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.dateCollectionView.registerNib(UINib(nibName: "DateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DateCollectionViewCell")
        self.tableView.registerNib(UINib(nibName: "PanditTableViewCell", bundle: nil), forCellReuseIdentifier: "PanditTableViewCell")
        self.selectedIndex = 0
        let selectedDate = NSCalendar.currentCalendar().dateByAddingUnit(
            .Day,
            value: 1,
            toDate: NSDate(),
            options: NSCalendarOptions(rawValue: 0))
        UserSession.sharedInstance.newBooking?.book_date_NSDate = selectedDate!
        getVendorForSelectedDate(selectedDate!)
        self.tableView.reloadData()
    }

    override func viewWillAppear(animated: Bool) {
        self.title = "Select Panditji"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func bookButtonClicked(button : UIButton){
        self.title = ""
        let orderVC = self.storyboard?.instantiateViewControllerWithIdentifier("OrderConfirmationViewController") as! OrderConfirmationViewController
        UserSession.sharedInstance.newBooking?.vendor = vendors[button.tag]
        self.navigationController?.pushViewController(orderVC, animated: true)
    }

    func getVendorForSelectedDate(selectedDate: NSDate) {
        let activityIndicator = ActivityIndicator(parent: self.view)
        self.view.addSubview(activityIndicator)
        activityIndicator.showIndicator()

        resetVendorTable()

        let selectedDateMilli = selectedDate.timeIntervalSince1970*1000
        APIService.sharedInstance.getVendorAvailability("mumbai", bookDate: Int64(selectedDateMilli)) { (vendors, error) -> Void in
            self.vendors = vendors
            self.tableView.reloadData()
            self.tableView.contentOffset = CGPointMake(0, 0)
            activityIndicator.hideIndicator()
        }
    }

    func resetVendorTable() {
        self.vendors = [Vendor]()
        self.tableView.reloadData()
    }

}

extension PanditSelectionViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vendors.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : PanditTableViewCell = tableView.dequeueReusableCellWithIdentifier("PanditTableViewCell") as! PanditTableViewCell
        let vendor = vendors[indexPath.row]
        cell.vendorImage.image = nil
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.vendorName.text = "\(vendor.first_name!) \(vendor.last_name!)"
        cell.vendorExperience.text = vendor.experience == nil ? "8 years" : vendor.experience!
        cell.vendorLanguages.text = vendor.languages == nil ? "Hindi, Marathi" : vendor.languages!
        if let _ = vendor.image {
            cell.vendorImage.hnk_setImageFromURL(NSURL(string: vendor.image!)!)
        } else {
            cell.vendorImage.image = UIImage(named: "ic_vendor_placeholder")
        }
        cell.bookButton.addTarget(self, action: "bookButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.bookButton.tag = indexPath.row
        return cell
    }
}


extension PanditSelectionViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110.0
    }
}


extension PanditSelectionViewController : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : DateCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("DateCollectionViewCell", forIndexPath: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = UIColor.whiteColor()

        if let _ = self.selectedIndex{
            if(indexPath.row == selectedIndex!){
                cell.backgroundColor = UIColor.getThemeColor()
            }
        }
        cell.updateCellUI(indexPath.row)
        return cell
    }
}

extension PanditSelectionViewController : UICollectionViewDelegate{
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.selectedIndex = indexPath.row
        self.dateCollectionView.reloadData()
        let selectedDate = NSCalendar.currentCalendar().dateByAddingUnit(
            .Day,
            value: indexPath.row,
            toDate: NSDate(),
            options: NSCalendarOptions(rawValue: 0))
        // on data selection by the user reload data get vendor listing for given date.
        UserSession.sharedInstance.newBooking?.book_date_NSDate = selectedDate!
        getVendorForSelectedDate(selectedDate!)
    }
}

extension PanditSelectionViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSizeMake(self.view.frame.size.width/7,70)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }

}



