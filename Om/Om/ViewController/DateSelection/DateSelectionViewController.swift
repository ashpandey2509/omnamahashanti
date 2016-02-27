//
//  DateSelectionViewController.swift
//  Om
//
//  Created by Vinita on 2/27/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit

class DateSelectionViewController: UIViewController {
    @IBOutlet weak var calendarContainer: UIView!


    
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

}

extension DateSelectionViewController : CKCalendarDelegate  {
    
}

