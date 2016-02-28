//
//  SignUpViewController.swift
//  Om
//
//  Created by Vinita on 2/28/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mobileTextField: UILabel!
    @IBOutlet weak var emailtextField: UILabel!
    @IBOutlet weak var confirmPasswordTextField: UILabel!
    @IBOutlet weak var passwordTextField: UILabel!
    @IBOutlet weak var confirmPasswordHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mobileHeightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

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
