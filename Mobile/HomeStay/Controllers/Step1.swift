//
//  Step1.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 10, 2018

import Foundation


class Step1 : NSObject, NSCoding{

    var accommodates : String = ""
    var address : String = ""
    var homeType : String = ""
    var propertyid : Int = 0
    var roomType : String = ""
    var status : String = ""
    var stepCompleted : Bool = false 


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        accommodates = dictionary["accommodates"] as? String ?? ""
        address = dictionary["address"] as? String ?? ""
        homeType = dictionary["home_type"] as? String ?? ""
        propertyid = dictionary["propertyid"] as? Int ?? 0
        roomType = dictionary["room_type"] as? String ?? ""
        status = dictionary["status"] as? String ?? ""
        stepCompleted = dictionary["step_completed"] as? Bool ?? false
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if accommodates != nil{
            dictionary["accommodates"] = accommodates
        }
        if address != nil{
            dictionary["address"] = address
        }
        if homeType != nil{
            dictionary["home_type"] = homeType
        }
        if propertyid != nil{
            dictionary["propertyid"] = propertyid
        }
        if roomType != nil{
            dictionary["room_type"] = roomType
        }
        if status != nil{
            dictionary["status"] = status
        }
        if stepCompleted != nil{
            dictionary["step_completed"] = stepCompleted
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        accommodates = aDecoder.decodeObject(forKey: "accommodates") as? String ?? ""
        address = aDecoder.decodeObject(forKey: "address") as? String ?? ""
        homeType = aDecoder.decodeObject(forKey: "home_type") as? String ?? ""
        propertyid = aDecoder.decodeObject(forKey: "propertyid") as? Int ?? 0
        roomType = aDecoder.decodeObject(forKey: "room_type") as? String ?? ""
        status = aDecoder.decodeObject(forKey: "status") as? String ?? ""
        stepCompleted = aDecoder.decodeObject(forKey: "step_completed") as? Bool ?? false
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if accommodates != nil{
            aCoder.encode(accommodates, forKey: "accommodates")
        }
        if address != nil{
            aCoder.encode(address, forKey: "address")
        }
        if homeType != nil{
            aCoder.encode(homeType, forKey: "home_type")
        }
        if propertyid != nil{
            aCoder.encode(propertyid, forKey: "propertyid")
        }
        if roomType != nil{
            aCoder.encode(roomType, forKey: "room_type")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if stepCompleted != nil{
            aCoder.encode(stepCompleted, forKey: "step_completed")
        }
    }
}
