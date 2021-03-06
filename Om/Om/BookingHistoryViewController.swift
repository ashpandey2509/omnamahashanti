//
//  BookingHistoryViewController.swift
//  Om
//
//  Created by Naik, Parag Laxman (US - Mumbai) on 3/27/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit

class BookingHistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noBookingLabel: UILabel!

    var bookingHistory = [Booking]()
    @IBOutlet weak var bookingHistoryTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookingHistoryTableView.registerNib(UINib(nibName: "BookingHistoryCell", bundle: nil), forCellReuseIdentifier: "BookingHistoryCell")
        refreshBookingHistory()
        self.tableView.tableFooterView = UIView()
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()


    }

    func refreshBookingHistory() {
        if UserSession.sharedInstance.isLoggedInUser() {
            let loggedInUser = UserSession.sharedInstance.getUserData()!
            APIService.sharedInstance.bookingHistory(loggedInUser, callback: { (response) -> Void in

                //debugPrint("DEBUG: ", response.result.value)
                //debugPrint("DEBUG ERROR: ", response.result.error)

                if response.result.isSuccess {
                    if let JSON = response.result.value {
                        let bookingHistoryJson = JSON["list"] as! NSArray
                        self.bookingHistory.removeAll()
                        for booking in bookingHistoryJson {
                            self.bookingHistory.append(Booking(dataDict: booking as! NSDictionary))
                        }
                        self.bookingHistory = self.bookingHistory.filter() {
                             $0.status != "open"
                        }
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.bookingHistoryTableView.reloadData()
                        })
                    }
                }
                
                if(self.bookingHistory.count == 0){
                    self.noBookingLabel.hidden = false
                    self.bookingHistoryTableView.hidden = true
                }
                else{
                    self.noBookingLabel.hidden = true
                    self.bookingHistoryTableView.hidden = false
                }
            })
        } else {
            self.bookingHistory.removeAll()
            self.bookingHistoryTableView.reloadData()
        }
    }
}

extension BookingHistoryViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingHistory.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:BookingHistoryCell = tableView.dequeueReusableCellWithIdentifier("BookingHistoryCell") as! BookingHistoryCell
        let booking = bookingHistory[indexPath.row]
        cell.panditLabel.text = booking.vendor?.first_name
        cell.poojaLabel.text = booking.product?.name
        cell.placeLabel.text = booking.address
        cell.cancelButton.hidden = true
        cell.dateLabel.text = booking.dateString!
        cell.dayLabel.text = booking.dayString!
        cell.timeLabel.text = booking.slot?.capitalizedString

        return cell
    }
}

extension BookingHistoryViewController : UITableViewDelegate {

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120.0
    }
}
