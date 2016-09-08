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
    var locations = [Location]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.tableView.tableFooterView = UIView()
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
        let activityIndicator = ActivityIndicator(parent: self.view)
        self.view.addSubview(activityIndicator)
        activityIndicator.showIndicator()
        UserSession.sharedInstance.getProducts { (products,locations, error) -> Void in
            self.products = products
            self.locations = locations
            self.tableView.reloadData()
            activityIndicator.hideIndicator()
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
        return 158.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.title = ""

        let dateSelectionViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DateSelectionViewController") as! DateSelectionViewController
        let selectedProduct = products[indexPath.row]
        UserSession.sharedInstance.newBooking?.product = selectedProduct
        dateSelectionViewController.product = selectedProduct
        dateSelectionViewController.locations = self.locations
        self.navigationController?.pushViewController(dateSelectionViewController, animated: true)
    }
}