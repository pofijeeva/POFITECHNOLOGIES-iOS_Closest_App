//
//  CouponDetail.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 7, 2019

import Foundation


class CouponDetail : NSObject, NSCoding{

    var couponAssignedProducts : [CouponAssignedProduct]!
    var couponAvailableCount : AnyObject!
    var couponCode : String!
    var couponDatefrom : String!
    var couponDateto : String!
    var couponLimit : String!
    var couponName : String!
    var couponPriceValue : String!
    var couponPurchaseCount : String!
    var couponStatus : String!
    var couponType : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        couponAvailableCount = dictionary["coupon_available_count"] as AnyObject
        couponCode = dictionary["coupon_code"] as? String
        couponDatefrom = dictionary["coupon_datefrom"] as? String
        couponDateto = dictionary["coupon_dateto"] as? String
        couponLimit = dictionary["coupon_limit"] as? String
        couponName = dictionary["coupon_name"] as? String
        couponPriceValue = dictionary["coupon_price_value"] as? String
        couponPurchaseCount = dictionary["coupon_purchase_count"] as? String
        couponStatus = dictionary["coupon_status"] as? String
        couponType = dictionary["coupon_type"] as? String
        couponAssignedProducts = [CouponAssignedProduct]()
        if let couponAssignedProductsArray = dictionary["coupon_assigned_products"] as? [[String:Any]]{
            for dic in couponAssignedProductsArray{
                let value = CouponAssignedProduct(fromDictionary: dic)
                couponAssignedProducts.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if couponAvailableCount != nil{
            dictionary["coupon_available_count"] = couponAvailableCount
        }
        if couponCode != nil{
            dictionary["coupon_code"] = couponCode
        }
        if couponDatefrom != nil{
            dictionary["coupon_datefrom"] = couponDatefrom
        }
        if couponDateto != nil{
            dictionary["coupon_dateto"] = couponDateto
        }
        if couponLimit != nil{
            dictionary["coupon_limit"] = couponLimit
        }
        if couponName != nil{
            dictionary["coupon_name"] = couponName
        }
        if couponPriceValue != nil{
            dictionary["coupon_price_value"] = couponPriceValue
        }
        if couponPurchaseCount != nil{
            dictionary["coupon_purchase_count"] = couponPurchaseCount
        }
        if couponStatus != nil{
            dictionary["coupon_status"] = couponStatus
        }
        if couponType != nil{
            dictionary["coupon_type"] = couponType
        }
        if couponAssignedProducts != nil{
            var dictionaryElements = [[String:Any]]()
            for couponAssignedProductsElement in couponAssignedProducts {
                dictionaryElements.append(couponAssignedProductsElement.toDictionary())
            }
            dictionary["couponAssignedProducts"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        couponAssignedProducts = aDecoder.decodeObject(forKey: "coupon_assigned_products") as? [CouponAssignedProduct]
        couponAvailableCount = aDecoder.decodeObject(forKey: "coupon_available_count") as AnyObject
        couponCode = aDecoder.decodeObject(forKey: "coupon_code") as? String
        couponDatefrom = aDecoder.decodeObject(forKey: "coupon_datefrom") as? String
        couponDateto = aDecoder.decodeObject(forKey: "coupon_dateto") as? String
        couponLimit = aDecoder.decodeObject(forKey: "coupon_limit") as? String
        couponName = aDecoder.decodeObject(forKey: "coupon_name") as? String
        couponPriceValue = aDecoder.decodeObject(forKey: "coupon_price_value") as? String
        couponPurchaseCount = aDecoder.decodeObject(forKey: "coupon_purchase_count") as? String
        couponStatus = aDecoder.decodeObject(forKey: "coupon_status") as? String
        couponType = aDecoder.decodeObject(forKey: "coupon_type") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if couponAssignedProducts != nil{
            aCoder.encode(couponAssignedProducts, forKey: "coupon_assigned_products")
        }
        if couponAvailableCount != nil{
            aCoder.encode(couponAvailableCount, forKey: "coupon_available_count")
        }
        if couponCode != nil{
            aCoder.encode(couponCode, forKey: "coupon_code")
        }
        if couponDatefrom != nil{
            aCoder.encode(couponDatefrom, forKey: "coupon_datefrom")
        }
        if couponDateto != nil{
            aCoder.encode(couponDateto, forKey: "coupon_dateto")
        }
        if couponLimit != nil{
            aCoder.encode(couponLimit, forKey: "coupon_limit")
        }
        if couponName != nil{
            aCoder.encode(couponName, forKey: "coupon_name")
        }
        if couponPriceValue != nil{
            aCoder.encode(couponPriceValue, forKey: "coupon_price_value")
        }
        if couponPurchaseCount != nil{
            aCoder.encode(couponPurchaseCount, forKey: "coupon_purchase_count")
        }
        if couponStatus != nil{
            aCoder.encode(couponStatus, forKey: "coupon_status")
        }
        if couponType != nil{
            aCoder.encode(couponType, forKey: "coupon_type")
        }
    }
}
