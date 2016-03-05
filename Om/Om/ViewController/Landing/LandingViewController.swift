//
//  LandingViewController.swift
//  Om
//
//  Created by Vinita on 2/26/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit
class LandingViewController: UIViewController {
    @IBOutlet weak var bookPoojaView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.customizeView()
        self.testAwesomeNetworkingCode()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        self.title = "Om"
    }

    func testAwesomeNetworkingCode() {
//        APIService.sharedInstance.getProducts { (productList, error) -> Void in
//            debugPrint(productList)
//            for product in productList {
//                print (product.name)
//            }
//        }

//        APIService.sharedInstance.getVendorAvailability("mumbai", bookDate: 1450592887734) { (vendorList, error) -> Void in
//            debugPrint(vendorList)
//        }


    }

    func customizeView(){
        self.bookPoojaView.layer.borderColor = UIColor.getBookPoojaBorderColor().CGColor
        self.bookPoojaView.layer.borderWidth = 0.5
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        self.navigationController!.navigationBar.translucent = false
        
        let button = UIButton(type: UIButtonType.System)
        button.setImage(UIImage(named: "hamburger"), forState: UIControlState.Normal)
        button.addTarget(self, action: "leftBarButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        button.frame = CGRectMake(0, 20, 44, 44)
        button.imageEdgeInsets = UIEdgeInsetsMake(14, 0, 13, 19)
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
}

//extension LandingViewController : UITableViewDataSource {
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return vendors.count;
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell : PanditTableViewCell = tableView.dequeueReusableCellWithIdentifier("PanditTableViewCell") as! PanditTableViewCell
//        let vendor = vendors[indexPath.row]
//        cell.vendorImage.image = nil
//        cell.selectionStyle = UITableViewCellSelectionStyle.None
//        cell.vendorName.text = "\(vendor.first_name!) \(vendor.last_name!)"
//        cell.vendorExperience.text = vendor.experience == nil ? "8 years" : vendor.experience!
//        cell.vendorLanguages.text = vendor.languages == nil ? "Hindi, Marathi" : vendor.languages!
//        if let _ = vendor.image {
//            cell.vendorImage.hnk_setImageFromURL(NSURL(string: vendor.image!)!)
//        } else {
//            cell.vendorImage.image = UIImage(named: "ic_vendor_placeholder")
//        }
//        
//        return cell
//    }
//}
//
//
//extension LandingViewController : UITableViewDelegate {
//    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 110.0
//    }
//}



