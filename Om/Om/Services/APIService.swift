//
//  APIService.swift
//  Om
//
//  Created by Naik, Parag Laxman (US - Mumbai) on 2/27/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import Foundation
import Alamofire

class APIService {

    let baseURL = "http://159.203.93.220:4000/"

    static let sharedInstance = APIService()

    init() {
        print("Initializing API Services class")
    }

    func getProducts(callback: ([Product], NSError?) -> Void) {

        debugPrint("DEBUG: ", "api service call for products")

        let url = baseURL + "products"
        Alamofire.request(Alamofire.Method.GET, url).responseJSON { (response) -> Void in

            //print(response.result.value)
            print(response.result.error)

            var productList = [Product]()

            if let JSON = response.result.value {
                let productListJson = JSON["list"] as? NSArray
                for item in productListJson! {
                    productList.append(Product(dataDict: item as! NSDictionary))
                }
            }

            callback(productList, response.result.error)
        }
    }

    func getVendorAvailability(location: String, bookDate: Int64, callback: ([Vendor], NSError?) -> Void) {
        let url = baseURL + "vendors?" + "location=" + location + "&book_date=" + String(bookDate)
        debugPrint(url)
        Alamofire.request(Alamofire.Method.GET, url).responseJSON { (response) -> Void in

            var list = [Vendor]()

            if let JSON = response.result.value {
                let vendorListJson = JSON["list"] as? NSArray
                for vendor in vendorListJson! {
                    list.append(Vendor(dataDict: vendor as! NSDictionary))
                }
            }

            callback(list, response.result.error)
        }
    }

    func validateUser(mobile: String, password: String, callback: (Response<AnyObject, NSError>) -> Void) {
        let url = baseURL + "users/auth"
        debugPrint(url)
        let params = ["mobile": mobile, "password": password ]
        Alamofire.request(Alamofire.Method.POST, url, parameters: params, encoding: ParameterEncoding.URL, headers: nil)
            .validate()
            .responseJSON { (response) -> Void in
            callback(response)
        }
    }

    func getTncUrl() -> NSURL {
        return NSURL(string: baseURL + "policies/terms")!
    }

    func getPrivacyPolicyURL() -> NSURL {
        return NSURL(string: baseURL + "policies/privacy")!
    }






}