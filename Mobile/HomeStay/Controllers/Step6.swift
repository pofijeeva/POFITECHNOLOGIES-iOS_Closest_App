//
//  Step6.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on August 10, 2018

import Foundation


class Step6 : NSObject, NSCoding{

    var listName : String!
    var propertyid : Int!
    var stepCompleted : Bool!
    
    var amen_id : Int!
    var host_req : Int!
    var amen_name : String!
    var saved_amenities : [[String: Any]]!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        listName = dictionary["list_name"] as? String ?? ""
        propertyid = dictionary["propertyid"] as? Int ?? 0 ?? 0
        stepCompleted = dictionary["step_completed"] as? Bool ?? false
        saved_amenities = dictionary["saved_amenities"] as? [[String:Any]]
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if listName != nil{
            dictionary["list_name"] = listName
        }
        if propertyid != nil{
            dictionary["propertyid"] = propertyid
        }
        if stepCompleted != nil{
            dictionary["step_completed"] = stepCompleted
        }
        if saved_amenities != nil{
            dictionary["saved_amenities"] = saved_amenities
        }
        
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        listName = aDecoder.decodeObject(forKey: "list_name") as? String ?? ""
        propertyid = aDecoder.decodeObject(forKey: "propertyid") as? Int ?? 0
        stepCompleted = aDecoder.decodeObject(forKey: "step_completed") as? Bool ?? false
        saved_amenities = aDecoder.decodeObject(forKey: "saved_amenities") as? [[String: Any]]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if listName != nil{
            aCoder.encode(listName, forKey: "list_name")
        }
        if propertyid != nil{
            aCoder.encode(propertyid, forKey: "propertyid")
        }
        if stepCompleted != nil{
            aCoder.encode(stepCompleted, forKey: "step_completed")
        }
        if saved_amenities != nil{
            aCoder.encode(saved_amenities, forKey: "saved_amenities")
        }
    }
}

