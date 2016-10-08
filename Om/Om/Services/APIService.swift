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
       // print("Initializing API Services class")
    }

    func getProducts(callback: ([Product], [Location], NSError?) -> Void) {

       // debugPrint("DEBUG: ", "api service call for products")

        let url = baseURL + "products"
        Alamofire.request(Alamofire.Method.GET, url).responseJSON { (response) -> Void in

            //print(response.result.value)

            var productList = [Product]()
            var locationList = [Location]()

            if let JSON = response.result.value {
                let productListJson = JSON["list"] as? NSArray
                for item in productListJson! {
                    productList.append(Product(dataDict: item as! NSDictionary))
                }
                
                let locationJson = JSON["locations"] as? NSArray
                for item in locationJson! {
                    locationList.append(Location(dictionary: item as! NSDictionary))
                }
            }

            callback(productList,locationList, response.result.error)
        }
    }

    func getVendorAvailability(location: String, bookDate: Int64, callback: ([Vendor], NSError?) -> Void) {
        let url = baseURL + "vendors?" + "location=" + location + "&book_date=" + String(bookDate)
       // debugPrint(url)
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
        let params = ["mobile": mobile, "password": password ]
        Alamofire.request(Alamofire.Method.POST, url, parameters: params, encoding: ParameterEncoding.URL, headers: nil)
            .validate()
            .responseJSON { (response) -> Void in
            callback(response)
        }
    }
    
    
    func getUserDetails(mobile: String, callback: (newUser: UserProfile?, NSError?) -> Void) {
        let url = baseURL + "users?mobile=" + mobile.stringByReplacingOccurrencesOfString("+91", withString: "")
        Alamofire.request(Alamofire.Method.GET, url, parameters: nil, encoding: ParameterEncoding.JSON, headers: nil).validate().responseJSON { (response) -> Void in
            
            if response.result.isSuccess {
                if let JSON = response.result.value {
                    let list = ((JSON as! NSDictionary)["list"] as! NSArray)
                    if(list.count > 0){
                    let newUser = UserProfile(dataDict: list[0] as! NSDictionary)
                        callback(newUser: newUser, response.result.error)
                    }
                    else{
                        callback(newUser: nil, nil)
                    }
                } else {
                    callback(newUser: UserProfile(), response.result.error)
                }
            }
            else {

            }
            
        }
    }


    func signup(user: UserProfile, callback: (newUser: UserProfile?, errorString :String?) -> Void) {
        let url = baseURL + "users"
       // debugPrint(url)

        let params : [String : String] = ["email": user.email!,
            "mobile": user.mobile!,
            "country_code": "91",
            "password": "secret"
        ]

        Alamofire.request(Alamofire.Method.POST, url, parameters: params, encoding: ParameterEncoding.JSON, headers: nil).validate().responseJSON { (response) -> Void in

            if response.result.isSuccess {
                if let JSON = response.result.value {
                    let newUser = UserProfile(dataDict: JSON as! NSDictionary)
                    callback(newUser: newUser, errorString: response.result.error?.description)
                } else {
                    callback(newUser: UserProfile(), errorString: response.result.error!.description)
                }
            }
            else{
                if(response.result.error!.code == -6003){
                    callback(newUser: nil, errorString: "User already exists")
                }
            }
        }
    }
    
    
    func book(booking : Booking, address : String,  callback: (Response<AnyObject, NSError>) -> Void) {
        let url = baseURL + "bookings"
       // debugPrint(url)
        let params : [String : String] = ["user_id": (UserSession.sharedInstance.getUserData()?.id)!,
            "vendor_id": booking.vendor!.id!,
            "product_id": booking.product!.id,
            "book_date": String((booking.book_date_NSDate?.dateMilliSecs)!),
            "location" : UserSession.sharedInstance.newBooking!.locationDetails!.locationName!,
            "slot" :  booking.slot!,
            "address" : address]
        //debugPrint(params)

        Alamofire.request(Alamofire.Method.POST, url, parameters: params, encoding: ParameterEncoding.URL, headers: nil)
            .validate()
            .responseJSON { (response) -> Void in
                callback(response)
        }
    }

    func cancelBooking(bookingId: String, callback: (Response<AnyObject, NSError>) -> Void) {
        let url = baseURL + "bookings/\(bookingId)"
        //debugPrint(url)
        let params = ["status": "cancelled"]
        //debugPrint(params)

        Alamofire.request(Alamofire.Method.PUT, url, parameters: params, encoding: ParameterEncoding.URL, headers: nil).validate().responseJSON { (response) -> Void in
            callback(response)
        }
    }

    func bookingHistoryforOpenTickets(user: UserProfile, callback: (Response<AnyObject, NSError>) -> Void) {
        let url = baseURL + "bookings?user_id=\(user.id!)&status=open"
        //debugPrint(url)
        Alamofire.request(Alamofire.Method.GET, url, parameters: nil, encoding: ParameterEncoding.URL, headers: nil).validate().responseJSON { (response) -> Void in
            callback(response)
        }
    }

    func bookingHistory(user: UserProfile, callback: (Response<AnyObject, NSError>) -> Void) {
        let url = baseURL + "bookings?user_id=\(user.id!)"
       // debugPrint(url)
        Alamofire.request(Alamofire.Method.GET, url, parameters: nil, encoding: ParameterEncoding.URL, headers: nil).validate().responseJSON { (response) -> Void in
            callback(response)
        }
    }

    func editProfile(user: UserProfile, callback: (Response<AnyObject, NSError>) -> Void) {
        let url = baseURL + "users/\(user.id!)"
       // debugPrint(url)
        var params = [String: String]()
        params["first_name"] = user.first_name ?? ""
        params["last_name"] = user.last_name ?? ""
        params["email"] = user.email ?? ""
        params["caste"] = user.caste ?? ""
        params["address"] = user.address ?? ""
        params["preferred_language"] = user.preferred_language ?? ""

        Alamofire.request(.PUT, url, parameters: params, encoding: ParameterEncoding.URL, headers: nil)
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