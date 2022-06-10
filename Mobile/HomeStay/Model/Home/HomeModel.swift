//
//  HomeModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 31, 2018

import Foundation


class HomeModel : NSObject, NSCoding{

    var currencyList : [CurrencyList]!
    var homePageDetails : [HomePageDetail]!
    var message : String!
    var status : Int!
    var baseId : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        baseId = dictionary["base_id"] as? Int ?? 0
        message = dictionary["message"] as? String ?? ""
        status = dictionary["status"] as? Int ?? 0
        currencyList = [CurrencyList]()
        if let currencyListArray = dictionary["currency_list"] as? [[String:Any]]{
            for dic in currencyListArray{
                let value = CurrencyList(fromDictionary: dic)
                currencyList.append(value)
            }
        }
        homePageDetails = [HomePageDetail]()
        if let homePageDetailsArray = dictionary["fav_destination_list"] as? [[String:Any]]{
            for dic in homePageDetailsArray{
                let value = HomePageDetail(fromDictionary: dic)
                homePageDetails.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if message != nil{
            dictionary["message"] = message
        }
        if baseId != nil{
            dictionary["base_id"] = baseId
        }
        if status != nil{
            dictionary["status"] = status
        }
        if currencyList != nil{
            var dictionaryElements = [[String:Any]]()
            for currencyListElement in currencyList {
                dictionaryElements.append(currencyListElement.toDictionary())
            }
            dictionary["currencyList"] = dictionaryElements
        }
        if homePageDetails != nil{
            var dictionaryElements = [[String:Any]]()
            for homePageDetailsElement in homePageDetails {
                dictionaryElements.append(homePageDetailsElement.toDictionary())
            }
            dictionary["homePageDetails"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        baseId = aDecoder.decodeObject(forKey: "base_id") as? Int ?? 0
        currencyList = aDecoder.decodeObject(forKey: "currency_list") as? [CurrencyList]
        homePageDetails = aDecoder.decodeObject(forKey: "fav_destination_list") as? [HomePageDetail]
        message = aDecoder.decodeObject(forKey: "message") as? String ?? ""
        status = aDecoder.decodeObject(forKey: "status") as? Int ?? 0
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if baseId != nil{
            aCoder.encode(baseId, forKey: "base_id")
        }
        if currencyList != nil{
            aCoder.encode(currencyList, forKey: "currency_list")
        }
        if homePageDetails != nil{
            aCoder.encode(homePageDetails, forKey: "fav_destination_list")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
    }
}
