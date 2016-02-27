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
    @IBOutlet weak var calendarContainer: UIView!
    var selectedTimeSlot : String?
    @IBOutlet weak var eveningButton: UIButton!
    @IBOutlet weak var afternoonButton: UIButton!
    @IBOutlet weak var morningButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let calendar = CKCalendarView()
        self.calendarContainer.addSubview(calendar)
        calendar.delegate = self;
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
    
    @IBAction func nextButtonClicked(button: UIButton) {
        if let _ = self.selectedTimeSlot{
            self.title = ""
            let panditSelectionVC = self.storyboard?.instantiateViewControllerWithIdentifier("PanditSelectionViewController") as! PanditSelectionViewController
            panditSelectionVC.selectedTimeSlot = self.selectedTimeSlot  
            self.navigationController?.pushViewController(panditSelectionVC, animated: true)
        }
        else
        {
            KSToastView.ks_showToast("Please select a time slot")
        }
    }

    @IBAction func timeSlotSelected(button: UIButton) {
        self.morningButton.backgroundColor = UIColor.getTimeSlotBackgroundColor()
        self.afternoonButton.backgroundColor = UIColor.getTimeSlotBackgroundColor()
        self.eveningButton.backgroundColor = UIColor.getTimeSlotBackgroundColor()
        button.backgroundColor = UIColor.getThemeColor()
        self.updateSelectedTimeSlot(button.tag)
    }
    
    func updateSelectedTimeSlot(slotTag : Int){
        switch(slotTag){
            case 0:
                self.selectedTimeSlot = "Morning"
                break
            case 1:
                self.selectedTimeSlot = "Afternoon"
                break
            case 2:
                self.selectedTimeSlot = "Evening"
                break
            default:
                self.selectedTimeSlot = nil
                break
        }
    }
    
}

extension DateSelectionViewController : CKCalendarDelegate  {
    
    func calendar(calendar: CKCalendarView!, didSelectDate date: NSDate!) {
        
    }
}

