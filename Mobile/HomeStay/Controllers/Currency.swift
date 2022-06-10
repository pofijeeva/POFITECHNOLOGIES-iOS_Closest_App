//
//  Currency.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 10, 2018

import Foundation


class Currency : NSObject, NSCoding{

    var countrySymbols : String!
    var currencyType : String!
    var id : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        countrySymbols = dictionary["country_symbols"] as? String ?? ""
        currencyType = dictionary["currency_type"] as? String ?? ""
        id = dictionary["id"] as? String ?? ""
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if countrySymbols != nil{
            dictionary["country_symbols"] = countrySymbols
        }
        if currencyType != nil{
            dictionary["currency_type"] = currencyType
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
        countrySymbols = aDecoder.decodeObject(forKey: "country_symbols") as? String ?? ""
        currencyType = aDecoder.decodeObject(forKey: "currency_type") as? String ?? ""
        id = aDecoder.decodeObject(forKey: "id") as? String ?? ""
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if countrySymbols != nil{
            aCoder.encode(countrySymbols, forKey: "country_symbols")
        }
        if currencyType != nil{
            aCoder.encode(currencyType, forKey: "currency_type")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
    }
}
