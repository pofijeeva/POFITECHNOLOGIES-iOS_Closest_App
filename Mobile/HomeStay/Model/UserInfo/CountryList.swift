//
//  CountryList.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 28, 2018

import Foundation


class CountryList : NSObject, NSCoding{

    var countryName : String!
    var id : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        countryName = dictionary["country_name"] as? String ?? ""
        id = dictionary["id"] as? Int
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if countryName != nil{
            dictionary["country_name"] = countryName
        }
        if id != nil{
            dictionary["id"] = id
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        countryName = aDecoder.decodeObject(forKey: "country_name") as? String ?? ""
        id = aDecoder.decodeObject(forKey: "id") as? Int
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if countryName != nil{
            aCoder.encode(countryName, forKey: "country_name")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
    }
}
