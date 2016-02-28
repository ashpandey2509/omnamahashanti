//
//  PoojaViewController.swift
//  Om
//
//  Created by Vinita on 2/27/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit

class PoojaViewController: UIViewController {

    var products = [Product]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        getProducts()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        self.title = "Select Pooja"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.title = ""
    }

    func getProducts() {
        UserSession.sharedInstance.getProducts { (products, error) -> Void in
            self.products = products
            self.tableView.reloadData()
        }
    }
}

extension PoojaViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let product = products[indexPath.row]

        let cell : PoojaTableViewCell = tableView.dequeueReusableCellWithIdentifier("PoojaTableViewCell") as! PoojaTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.productName.text = product.name
        cell.productDescription.text = product.detail
        cell.productCost.text = "₹ " + String(product.cost)
        return cell
    }
}


extension PoojaViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150.0
    }
}

