//
//  Check.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 28, 2018

import Foundation


class Check : NSObject, NSCoding{

    var checkin : String!
    var checkout : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        checkin = dictionary["checkin"] as? String ?? ""
        checkout = dictionary["checkout"] as? String ?? ""
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if checkin != nil{
            dictionary["checkin"] = checkin
        }
        if checkout != nil{
            dictionary["checkout"] = checkout
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        checkin = aDecoder.decodeObject(forKey: "checkin") as? String ?? ""
        checkout = aDecoder.decodeObject(forKey: "checkout") as? String ?? ""
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if checkin != nil{
            aCoder.encode(checkin, forKey: "checkin")
        }
        if checkout != nil{
            aCoder.encode(checkout, forKey: "checkout")
        }
    }
}
