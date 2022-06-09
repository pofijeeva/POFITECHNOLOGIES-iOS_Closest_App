//
//  TableDetail.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on January 5, 2019

import Foundation


class RestTableDetail : NSObject, NSCoding{

    var bookedStatus : String!
    var currencyCd : String!
    var endTime : String!
    var price : String!
    var startTime : String!
    var tableName : String!
    var timeId : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        bookedStatus = dictionary["booked_status"] as? String
        currencyCd = dictionary["currency_cd"] as? String
        endTime = dictionary["end_time"] as? String
        price = dictionary["price"] as? String
        startTime = dictionary["start_time"] as? String
        tableName = dictionary["table_name"] as? String
        timeId = dictionary["time_id"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if bookedStatus != nil{
            dictionary["booked_status"] = bookedStatus
        }
        if currencyCd != nil{
            dictionary["currency_cd"] = currencyCd
        }
        if endTime != nil{
            dictionary["end_time"] = endTime
        }
        if price != nil{
            dictionary["price"] = price
        }
        if startTime != nil{
            dictionary["start_time"] = startTime
        }
        if tableName != nil{
            dictionary["table_name"] = tableName
        }
        if timeId != nil{
            dictionary["time_id"] = timeId
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        bookedStatus = aDecoder.decodeObject(forKey: "booked_status") as? String
        currencyCd = aDecoder.decodeObject(forKey: "currency_cd") as? String
        endTime = aDecoder.decodeObject(forKey: "end_time") as? String
        price = aDecoder.decodeObject(forKey: "price") as? String
        startTime = aDecoder.decodeObject(forKey: "start_time") as? String
        tableName = aDecoder.decodeObject(forKey: "table_name") as? String
        timeId = aDecoder.decodeObject(forKey: "time_id") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if bookedStatus != nil{
            aCoder.encode(bookedStatus, forKey: "booked_status")
        }
        if currencyCd != nil{
            aCoder.encode(currencyCd, forKey: "currency_cd")
        }
        if endTime != nil{
            aCoder.encode(endTime, forKey: "end_time")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        if startTime != nil{
            aCoder.encode(startTime, forKey: "start_time")
        }
        if tableName != nil{
            aCoder.encode(tableName, forKey: "table_name")
        }
        if timeId != nil{
            aCoder.encode(timeId, forKey: "time_id")
        }
    }
}
