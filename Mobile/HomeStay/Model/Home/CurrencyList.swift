//
//  CurrencyList.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 31, 2018

import Foundation


class CurrencyList : NSObject, NSCoding{

    var currencyCode : String = ""
    var currencySymbol : String = ""
    var currencyValue : Int = 0
    var id : Int = 0


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        currencyCode = dictionary["currency_code"] as? String ?? ""
        currencySymbol = dictionary["currency_symbol"] as? String ?? ""
        currencyValue = dictionary["currency_value"] as? Int ?? 0
        id = dictionary["id"] as? Int ?? 0
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if currencyCode != nil{
            dictionary["currency_code"] = currencyCode
        }
        if currencySymbol != nil{
            dictionary["currency_symbol"] = currencySymbol
        }
        if currencyValue != nil{
            dictionary["currency_value"] = currencyValue
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
        currencyCode = aDecoder.decodeObject(forKey: "currency_code") as? String ?? ""
        currencySymbol = aDecoder.decodeObject(forKey: "currency_symbol") as? String ?? ""
        currencyValue = aDecoder.decodeObject(forKey: "currency_value") as? Int ?? 0
        id = aDecoder.decodeObject(forKey: "id") as? Int ?? 0
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if currencyCode != nil{
            aCoder.encode(currencyCode, forKey: "currency_code")
        }
        if currencySymbol != nil{
            aCoder.encode(currencySymbol, forKey: "currency_symbol")
        }
        if currencyValue != nil{
            aCoder.encode(currencyValue, forKey: "currency_value")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
    }
}
