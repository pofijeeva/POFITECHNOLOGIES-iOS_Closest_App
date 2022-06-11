//
//  DateDetail.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on January 5, 2019

import Foundation


class DateDetail : NSObject, NSCoding{
    var tableDetails : [RestTableDetail]!
    var timingFor : String = ""
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        timingFor = dictionary["Timing_for"] as? String ?? ""
        tableDetails = [RestTableDetail]()
        if let tableDetailsArray = dictionary["table_details"] as? [[String:Any]]{
            for dic in tableDetailsArray{
                let value = RestTableDetail(fromDictionary: dic)
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
        if timingFor != nil{
            dictionary["Timing_for"] = timingFor
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
        tableDetails = aDecoder.decodeObject(forKey: "table_details") as? [RestTableDetail]
        timingFor = aDecoder.decodeObject(forKey: "Timing_for") as? String ?? ""
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if tableDetails != nil{
            aCoder.encode(tableDetails, forKey: "table_details")
        }
        if timingFor != nil{
            aCoder.encode(timingFor, forKey: "Timing_for")
        }
    }
}
 
