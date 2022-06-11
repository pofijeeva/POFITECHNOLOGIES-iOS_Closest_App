//
//  CouponDetailsJson.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 7, 2019

import Foundation


class CouponDetailsJson : NSObject, NSCoding{

    var couponDetails : [CouponDetail]!
    var message : String = ""
    var status : Int = 0


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        message = dictionary["message"] as? String ?? "" ?? ""
        status = dictionary["status"] as? Int ?? 0
        couponDetails = [CouponDetail]()
        if let couponDetailsArray = dictionary["coupon_details"] as? [[String:Any]]{
            for dic in couponDetailsArray{
                let value = CouponDetail(fromDictionary: dic)
                couponDetails.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if message != nil{
            dictionary["message"] = message
        }
        if status != nil{
            dictionary["status"] = status
        }
        if couponDetails != nil{
            var dictionaryElements = [[String:Any]]()
            for couponDetailsElement in couponDetails {
                dictionaryElements.append(couponDetailsElement.toDictionary())
            }
            dictionary["couponDetails"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        couponDetails = aDecoder.decodeObject(forKey: "coupon_details") as? [CouponDetail]
        message = aDecoder.decodeObject(forKey: "message") as? String ?? ""
        status = aDecoder.decodeObject(forKey: "status") as? Int ?? 0
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if couponDetails != nil{
            aCoder.encode(couponDetails, forKey: "coupon_details")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
    }
}
