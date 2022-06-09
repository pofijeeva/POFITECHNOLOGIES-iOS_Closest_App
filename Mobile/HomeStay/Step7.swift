//
//  Step7.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on August 10, 2018

import Foundation


class Step7 : NSObject, NSCoding{

    var attribute : [String:Any]!
    var homeType : String!
    var propertyid : Int!
    var roomType : String!
    var stepCompleted : Bool!
    var saved_listing : [[String: Any]]!
    var allow_multiple_qty : Int!
    var max_qty : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        homeType = dictionary["home_type"] as? String
        propertyid = dictionary["propertyid"] as? Int
        allow_multiple_qty = dictionary["allow_multiple_qty"] as? Int
        max_qty = dictionary["max_qty"] as? Int

        roomType = dictionary["room_type"] as? String
        stepCompleted = dictionary["step_completed"] as? Bool
        attribute = [String:Any]()
        if let attributeArray = dictionary["attribute"] as? [[String:Any]]{
            for dic in attributeArray{
               attribute = dic
            }
        }
        saved_listing = dictionary["saved_listing"] as? [[String:Any]]
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if homeType != nil{
            dictionary["home_type"] = homeType
        }
        if propertyid != nil{
            dictionary["propertyid"] = propertyid
        }
        if max_qty != nil{
            dictionary["max_qty"] = max_qty
        }
        if allow_multiple_qty != nil{
            dictionary["allow_multiple_qty"] = allow_multiple_qty
        }
        if roomType != nil{
            dictionary["room_type"] = roomType
        }
        if stepCompleted != nil{
            dictionary["step_completed"] = stepCompleted
        }
        if attribute != nil{
            var dictionaryElements = [[String:Any]]()
            for attributeElement in attribute {
               // dictionaryElements = [attributeElement]
            }
            dictionary["attribute"] = dictionaryElements
        }
        if saved_listing != nil{
            dictionary["saved_listing"] = saved_listing
        }
        
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        attribute = aDecoder.decodeObject(forKey: "attribute") as? [String:Any]
        homeType = aDecoder.decodeObject(forKey: "home_type") as? String
        propertyid = aDecoder.decodeObject(forKey: "propertyid") as? Int
        allow_multiple_qty = aDecoder.decodeObject(forKey: "allow_multiple_qty") as? Int
        max_qty = aDecoder.decodeObject(forKey: "max_qty") as? Int

        roomType = aDecoder.decodeObject(forKey: "room_type") as? String
        stepCompleted = aDecoder.decodeObject(forKey: "step_completed") as? Bool
        saved_listing = aDecoder.decodeObject(forKey: "saved_listing") as? [[String: Any]]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if attribute != nil{
            aCoder.encode(attribute, forKey: "attribute")
        }
        if homeType != nil{
            aCoder.encode(homeType, forKey: "home_type")
        }
        if propertyid != nil{
            aCoder.encode(propertyid, forKey: "propertyid")
        }
        if allow_multiple_qty != nil{
            aCoder.encode(allow_multiple_qty, forKey: "allow_multiple_qty")
        }
        if max_qty != nil{
            aCoder.encode(max_qty, forKey: "max_qty")
        }
        if roomType != nil{
            aCoder.encode(roomType, forKey: "room_type")
        }
        if stepCompleted != nil{
            aCoder.encode(stepCompleted, forKey: "step_completed")
        }
        if saved_listing != nil{
            aCoder.encode(saved_listing, forKey: "saved_listing")
        }
    }
}

