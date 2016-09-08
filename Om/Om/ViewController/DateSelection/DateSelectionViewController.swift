//
//  DateSelectionViewController.swift
//  Om
//
//  Created by Vinita on 2/27/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit
import KSToastView
class DateSelectionViewController: UIViewController {
    @IBOutlet weak var containerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var calendarContainer: UIView!
    @IBOutlet weak var timeslotSegmentedControl: UISegmentedControl!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeButton: UIButton!

    var product: Product?
    var locations: [Location]?

    enum Timeslot: String {
        case Morning = "Morning"
        case Afternoon = "Afternoon"
        case Evening = "Evening"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let calendar = CKCalendarView()
        self.calendarContainer.addSubview(calendar)
        calendar.delegate = self;
        self.containerHeightConstraint.constant = DeviceType.IS_IPHONE_6_OR_MORE ? 350 : 290
        initTimeslotSegmentedControl()
        
        self.placeButton.layer.cornerRadius = 5
        self.placeButton.backgroundColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1)
        self.placeButton.layer.borderWidth = 1
        self.placeButton.layer.borderColor = UIColor.clearColor().CGColor
        
        if(self.locations?.count > 0){
            self.placeNameLabel.text = self.locations![0].locationName!.capitalizedString
            UserSession.sharedInstance.newBooking?.locationDetails = self.locations![0]
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(DateSelectionViewController.nextButtonClicked(_:)))

    }

    override func viewWillAppear(animated: Bool) {
        self.title = "Select Date"
    }
    
    @IBAction func nextButtonClicked(button: UIButton) {
        self.title = ""

        if (timeslotSegmentedControl.selectedSegmentIndex > -1) {
            let selectedTimeslotName = timeslotSegmentedControl.titleForSegmentAtIndex(timeslotSegmentedControl.selectedSegmentIndex)
            showVendorAvailability(Timeslot(rawValue: selectedTimeslotName!)!)
        }
        else if(self.locations?.count == 0){
            KSToastView.ks_showToast("Locations not present")
        }
        else {
            KSToastView.ks_showToast("Please select a time slot")
        }
    }
    
    @IBAction func locationButtonClicked(button: UIButton) {
        if let _ = self.locations{
            let attributedString = NSAttributedString(string: "Select Location", attributes: [
                NSFontAttributeName : UIFont.boldSystemFontOfSize(20),
                NSForegroundColorAttributeName : UIColor(red: 64.0/255.0, green: 64.0/255.0, blue: 64.0/255.0, alpha: 1)
                ])
            let alertController = UIAlertController(title: "Select Location", message: "", preferredStyle: .ActionSheet)
            
            alertController.setValue(attributedString, forKey: "attributedTitle")
            alertController.view.tintColor = UIColor(red: 64.0/255.0, green: 64.0/255.0, blue: 64.0/255.0, alpha: 1)
            
            for item in self.locations!{
                let action = UIAlertAction(title: item.locationName!.capitalizedString, style: .Default, handler: { (action) in
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if let _ = self.locations{
                            let filteredResults = self.locations!.filter() {
                                $0.locationName?.caseInsensitiveCompare(action.title!) == NSComparisonResult.OrderedSame
                            }
                            
                            if(filteredResults.count > 0){
                                self.placeNameLabel.text = filteredResults[0].locationName!.capitalizedString
                                UserSession.sharedInstance.newBooking?.locationDetails = filteredResults[0]
                            }
                        }
                    })
                })
                
                let attributedText = NSMutableAttributedString(string: item.locationName!.capitalizedString)
                
                let range = NSRange(location: 0, length: attributedText.length)
                attributedText.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12), range: range)
                attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 77.0/255.0, green: 77.0/255.0, blue: 77.0/255.0, alpha: 1), range: range)
                alertController.addAction(action)
            }
            
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            let attributedText = NSMutableAttributedString(string: "OK")
            
            let range = NSRange(location: 0, length: attributedText.length)
            attributedText.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(18), range: range)
            attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 77.0/255.0, green: 77.0/255.0, blue: 77.0/255.0, alpha: 1), range: range)
            alertController.addAction(action)
            
            
            presentViewController(alertController, animated: true, completion: {
                alertController.view.tintColor = UIColor(red: 77.0/255.0, green: 77.0/255.0, blue: 77.0/255.0, alpha: 1)
            })
            
            
            guard let label = action.valueForKey("__representer")?.valueForKey("label") as? UILabel else { return }
            label.attributedText = attributedText
        }
    }

    func initTimeslotSegmentedControl() {
        if let selectedProduct = product {
            timeslotSegmentedControl.setEnabled(selectedProduct.morning, forSegmentAtIndex: 0)
            timeslotSegmentedControl.setEnabled(selectedProduct.afternoon, forSegmentAtIndex: 1)
            timeslotSegmentedControl.setEnabled(selectedProduct.evening, forSegmentAtIndex: 2)
        }
    }

    func showVendorAvailability(timeslot: Timeslot) {
        let vendorAvailabilityVC = self.storyboard?.instantiateViewControllerWithIdentifier("PanditSelectionViewController") as!
        PanditSelectionViewController
        UserSession.sharedInstance.newBooking?.slot = timeslot.rawValue
        self.navigationController?.pushViewController(vendorAvailabilityVC, animated: true)
    }
}

extension DateSelectionViewController : CKCalendarDelegate  {

    func calendar(calendar: CKCalendarView!, didSelectDate date: NSDate!) {
        UserSession.sharedInstance.newBooking?.book_date_NSDate = date
    }
}

