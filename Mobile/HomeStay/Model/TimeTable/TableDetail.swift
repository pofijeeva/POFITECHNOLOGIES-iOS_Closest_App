//
//  TableDetail.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on December 13, 2018

import Foundation


class TableDetail : NSObject, NSCoding{

    var tableId : String!
    var tableName : String!
    var tableTime : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        tableId = dictionary["table_id"] as? String ?? ""
        tableName = dictionary["table_name"] as? String ?? ""
        tableTime = dictionary["table_time"] as? String ?? ""
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if tableId != nil{
            dictionary["table_id"] = tableId
        }
        if tableName != nil{
            dictionary["table_name"] = tableName
        }
        if tableTime != nil{
            dictionary["table_time"] = tableTime
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        tableId = aDecoder.decodeObject(forKey: "table_id") as? String ?? ""
        tableName = aDecoder.decodeObject(forKey: "table_name") as? String ?? ""
        tableTime = aDecoder.decodeObject(forKey: "table_time") as? String ?? ""
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if tableId != nil{
            aCoder.encode(tableId, forKey: "table_id")
        }
        if tableName != nil{
            aCoder.encode(tableName, forKey: "table_name")
        }
        if tableTime != nil{
            aCoder.encode(tableTime, forKey: "table_time")
        }
    }
}
