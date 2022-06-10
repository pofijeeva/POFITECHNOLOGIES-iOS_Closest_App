//
//  ActiveRental.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 10, 2018

import Foundation


class ActiveRental : NSObject, NSCoding{

    var baseId : String!
    var isEnabled : Bool!
    var rentalName : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        baseId = dictionary["base_id"] as? String ?? ""
        isEnabled = dictionary["isEnabled"] as? Bool ?? false 
        rentalName = dictionary["rental_name"] as? String ?? ""
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if baseId != nil{
            dictionary["base_id"] = baseId
        }
        if isEnabled != nil{
            dictionary["isEnabled"] = isEnabled
        }
        if rentalName != nil{
            dictionary["rental_name"] = rentalName
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        baseId = aDecoder.decodeObject(forKey: "base_id") as? String ?? ""
        isEnabled = aDecoder.decodeObject(forKey: "isEnabled") as? Bool ?? false
        rentalName = aDecoder.decodeObject(forKey: "rental_name") as? String ?? ""
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if baseId != nil{
            aCoder.encode(baseId, forKey: "base_id")
        }
        if isEnabled != nil{
            aCoder.encode(isEnabled, forKey: "isEnabled")
        }
        if rentalName != nil{
            aCoder.encode(rentalName, forKey: "rental_name")
        }
    }
}
