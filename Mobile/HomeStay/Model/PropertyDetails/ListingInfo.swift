//
//  ListingInfo.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 28, 2018

import Foundation


class ListingInfo : NSObject, NSCoding{

    var label : String!
    var value : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        label = dictionary["label"] as? String
        value = dictionary["value"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if label != nil{
            dictionary["label"] = label
        }
        if value != nil{
            dictionary["value"] = value
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        label = aDecoder.decodeObject(forKey: "label") as? String
        value = aDecoder.decodeObject(forKey: "value") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if label != nil{
            aCoder.encode(label, forKey: "label")
        }
        if value != nil{
            aCoder.encode(value, forKey: "value")
        }
    }
}