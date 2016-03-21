//
//  OrderHistoryViewController.swift
//  Om
//
//  Created by Vinita on 3/5/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit

class OrderHistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var orderHistory = [Booking]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "BookingHistoryCell", bundle: nil), forCellReuseIdentifier: "BookingHistoryCell")
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

extension OrderHistoryViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderHistory.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : BookingHistoryCell = tableView.dequeueReusableCellWithIdentifier("BookingHistoryCell") as! BookingHistoryCell
        let booking = self.orderHistory[indexPath.row]
        cell.dateLabel.text = booking.getDisplayDate()
//        cell.dayLabel.text = booking.updated_date.
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
}


//extension OrderHistoryViewController : UITableViewDelegate {
//    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 60.0
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let dictionary = self.currentDrawerArray[indexPath.row]
//        if let identifier = dictionary["centerIdentifier"]{
//            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier(identifier as! String)
//            (self.mm_drawerController.centerViewController as! UINavigationController).pushViewController(viewController!, animated: true)
//            self.mm_drawerController.closeDrawerAnimated(true, completion: nil)
//        }
//        
//        if let action = dictionary["action"] {
//            self.performSelector(Selector(action as! String))
//        }
//    }
//}
//
