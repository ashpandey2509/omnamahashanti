//
//  LandingViewController.swift
//  Om
//
//  Created by Vinita on 2/26/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit
import MMDrawerController
class LandingViewController: UIViewController {
    
    @IBOutlet weak var bookPoojaView: UIView!
    @IBOutlet weak var tableView: UITableView!

    var bookingHistoryList = [Booking]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.customizeView()
        self.tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        self.title = "Om"
        refreshBookingHistory()
    }

    func customizeView(){
        self.bookPoojaView.layer.borderColor = UIColor.getBookPoojaBorderColor().CGColor
        self.bookPoojaView.layer.borderWidth = 0.5
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        self.navigationController!.navigationBar.translucent = false
        
        let button = UIButton(type: UIButtonType.System)
        button.setImage(UIImage(named: "ic_menu_white"), forState: UIControlState.Normal)
        button.addTarget(self, action: "leftBarButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        button.frame = CGRectMake(0, 20, 44, 44)
        button.imageEdgeInsets = UIEdgeInsetsMake(10, 6, 10, 8)
        button.tintColor = UIColor.whiteColor()
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton

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
    
    func leftBarButtonClicked(button : UIButton){
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "PoojaDetailsSegue"){
            self.title = ""
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.title = ""
    }

    func refreshBookingHistory() {

        if UserSession.sharedInstance.isLoggedInUser() {
            let loggedInUser = UserSession.sharedInstance.loggedInUser!
            APIService.sharedInstance.bookingHistory(loggedInUser, callback: { (response) -> Void in

                debugPrint("DEBUG: ", response.result.value)
                debugPrint("DEBUG ERROR: ", response.result.error)

                if response.result.isSuccess {
                    if let JSON = response.result.value {
                        let bookingHistoryJson = JSON["list"] as! NSArray
                        self.bookingHistoryList.removeAll()
                        for booking in bookingHistoryJson {
                            self.bookingHistoryList.append(Booking(dataDict: booking as! NSDictionary))
                        }
                        self.tableView.reloadData()
                    }
                }
            })
        }
    }
}

extension LandingViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingHistoryList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:BookingHistoryCell = tableView.dequeueReusableCellWithIdentifier("BookingHistoryCell") as! BookingHistoryCell
        let booking = bookingHistoryList[indexPath.row]
        cell.panditLabel.text = booking.vendor?.first_name
        cell.poojaLabel.text = booking.product?.name
        cell.placeLabel.text = booking.address
        return cell
    }
}


extension LandingViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110.0
    }
}



