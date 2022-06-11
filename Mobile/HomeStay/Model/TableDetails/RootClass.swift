//
//  RootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on January 5, 2019

import Foundation


class RootClass : NSObject, NSCoding{

    var dateDetails : [DateDetail]!
    var status : Int = 0
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        status = dictionary["status"] as? Int ?? 0
        dateDetails = [DateDetail]()
        if let dateDetailsArray = dictionary["date_details"] as? [[String:Any]]{
            for dic in dateDetailsArray{
                let value = DateDetail(fromDictionary: dic)
                dateDetails.append(value)
            }
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if status != nil{
            dictionary["status"] = status
        }
        if dateDetails != nil{
            var dictionaryElements = [[String:Any]]()
            for dateDetailsElement in dateDetails {
                dictionaryElements.append(dateDetailsElement.toDictionary())
            }
            dictionary["dateDetails"] = dictionaryElements
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        dateDetails = aDecoder.decodeObject(forKey: "date_details") as? [DateDetail]
        status = aDecoder.decodeObject(forKey: "status") as? Int ?? 0
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if dateDetails != nil{
            aCoder.encode(dateDetails, forKey: "date_details")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
    }
}
