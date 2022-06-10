//
//  SeasonalCalendarPrice.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 28, 2018

import Foundation


class SeasonalCalendarPrice : NSObject, NSCoding{

    var date : String!
    var price : Int!
    var status : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        date = dictionary["date"] as? String ?? ""
        price = dictionary["price"] as? Int ?? 0
        status = dictionary["status"] as? Int ?? 0
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if date != nil{
            dictionary["date"] = date
        }
        if price != nil{
            dictionary["price"] = price
        }
        if status != nil{
            dictionary["status"] = status
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        date = aDecoder.decodeObject(forKey: "date") as? String ?? ""
        price = aDecoder.decodeObject(forKey: "price") as? Int ?? 0
        status = aDecoder.decodeObject(forKey: "status") as? Int ?? 0
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if date != nil{
            aCoder.encode(date, forKey: "date")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
    }
}
