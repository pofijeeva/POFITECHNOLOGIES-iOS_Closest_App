//
//  CouponAssignedProduct.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on May 8, 2019

import Foundation


class CouponAssignedProduct : NSObject, NSCoding{
    
    var address : String!
    var id : String!
    var productTitle : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        address = dictionary["address"] as? String ?? ""
        id = dictionary["id"] as? String ?? ""
        productTitle = dictionary["product_title"] as? String ?? ""
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if address != nil{
            dictionary["address"] = address
        }
        if id != nil{
            dictionary["id"] = id
        }
        if productTitle != nil{
            dictionary["product_title"] = productTitle
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        address = aDecoder.decodeObject(forKey: "address") as? String ?? ""
        id = aDecoder.decodeObject(forKey: "id") as? String ?? ""
        productTitle = aDecoder.decodeObject(forKey: "product_title") as? String ?? ""
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if address != nil{
            aCoder.encode(address, forKey: "address")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if productTitle != nil{
            aCoder.encode(productTitle, forKey: "product_title")
        }
    }
}
