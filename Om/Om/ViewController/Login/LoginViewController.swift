//
//  LoginViewController.swift
//  Om
//
//  Created by Vinita on 2/28/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var mobileHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var passwordHighLightView: UIView!
    @IBOutlet weak var passwordtextField: UITextField!
    @IBOutlet weak var passwordHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var mobileHighLightView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonClicked(sender: AnyObject) {
    }
    
    @IBAction func createPorfileButtonClicked(sender: AnyObject) {
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
