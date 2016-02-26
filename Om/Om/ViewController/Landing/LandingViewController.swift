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
        
        // Do any additional setup after loading the view.
    }

    func customizeView(){
        self.bookPoojaView.layer.borderColor = UIColor.getBookPoojaBorderColor().CGColor
        self.bookPoojaView.layer.borderWidth = 0.5
        self.title = "Om"
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        self.navigationController!.navigationBar.translucent = false
        
        let button = UIButton(type: UIButtonType.System)
        button.setImage(UIImage(named: "hamburger"), forState: UIControlState.Normal)
//        button.addTarget(self, action: "didTapOpenButton:", forControlEvents: UIControlEvents.TouchUpInside)
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

}
