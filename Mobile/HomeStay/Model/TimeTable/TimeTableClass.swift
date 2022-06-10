//
//  TimeTableClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on December 13, 2018

import Foundation


class TimeTableClass : NSObject, NSCoding{

    var canBook : String!
    var cantbookmsg : String!
    var checkinDate : String!
    var status : Int!
    var tableDetails : [TableDetail]!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        canBook = dictionary["can_book"] as? String ?? ""
        cantbookmsg = dictionary["cantbookmsg"] as? String ?? ""
        checkinDate = dictionary["checkin_date"] as? String ?? ""
        status = dictionary["status"] as? Int ?? 0
        tableDetails = [TableDetail]()
        if let tableDetailsArray = dictionary["table_details"] as? [[String:Any]]{
            for dic in tableDetailsArray{
                let value = TableDetail(fromDictionary: dic)
                tableDetails.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if canBook != nil{
            dictionary["can_book"] = canBook
        }
        if cantbookmsg != nil{
            dictionary["cantbookmsg"] = cantbookmsg
        }
        if checkinDate != nil{
            dictionary["checkin_date"] = checkinDate
        }
        if status != nil{
            dictionary["status"] = status
        }
        if tableDetails != nil{
            var dictionaryElements = [[String:Any]]()
            for tableDetailsElement in tableDetails {
                dictionaryElements.append(tableDetailsElement.toDictionary())
            }
            dictionary["tableDetails"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        canBook = aDecoder.decodeObject(forKey: "can_book") as? String ?? ""
        cantbookmsg = aDecoder.decodeObject(forKey: "cantbookmsg") as? String ?? ""
        checkinDate = aDecoder.decodeObject(forKey: "checkin_date") as? String ?? ""
        status = aDecoder.decodeObject(forKey: "status") as? Int ?? 0
        tableDetails = aDecoder.decodeObject(forKey: "table_details") as? [TableDetail]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if canBook != nil{
            aCoder.encode(canBook, forKey: "can_book")
        }
        if cantbookmsg != nil{
            aCoder.encode(cantbookmsg, forKey: "cantbookmsg")
        }
        if checkinDate != nil{
            aCoder.encode(checkinDate, forKey: "checkin_date")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if tableDetails != nil{
            aCoder.encode(tableDetails, forKey: "table_details")
        }
    }
}
