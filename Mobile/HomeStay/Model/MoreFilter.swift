//
//  MoreFilter.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on February 7, 2019

import Foundation


class MoreFilter : NSObject, NSCoding{

    var attribute : [Attributes]!
    var currencyList : [AnyObject]!
    var message : String = ""
    var property : [Propertys]!
    var rentalList : [RentalLists]!
    var rooms : [Rooms]!
    var status : Int = 0


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        message = dictionary["message"] as? String ?? ""
        status = dictionary["status"] as? Int ?? 0
        attribute = [Attributes]()
        if let attributeArray = dictionary["attribute"] as? [[String:Any]]{
            for dic in attributeArray{
                let value = Attributes(fromDictionary: dic)
                attribute.append(value)
            }
        }
        property = [Propertys]()
        if let propertyArray = dictionary["property"] as? [[String:Any]]{
            for dic in propertyArray{
                let value = Propertys(fromDictionary: dic)
                property.append(value)
            }
        }
        rentalList = [RentalLists]()
        if let rentalListArray = dictionary["rentalList"] as? [[String:Any]]{
            for dic in rentalListArray{
                let value = RentalLists(fromDictionary: dic)
                rentalList.append(value)
            }
        }
        rooms = [Rooms]()
        if let roomsArray = dictionary["rooms"] as? [[String:Any]]{
            for dic in roomsArray{
                let value = Rooms(fromDictionary: dic)
                rooms.append(value)
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
        if status != nil{
            dictionary["status"] = status
        }
        if attribute != nil{
            var dictionaryElements = [[String:Any]]()
            for attributeElement in attribute {
                dictionaryElements.append(attributeElement.toDictionary())
            }
            dictionary["attribute"] = dictionaryElements
        }
        if property != nil{
            var dictionaryElements = [[String:Any]]()
            for propertyElement in property {
                dictionaryElements.append(propertyElement.toDictionary())
            }
            dictionary["property"] = dictionaryElements
        }
        if rentalList != nil{
            var dictionaryElements = [[String:Any]]()
            for rentalListElement in rentalList {
                dictionaryElements.append(rentalListElement.toDictionary())
            }
            dictionary["rentalList"] = dictionaryElements
        }
        if rooms != nil{
            var dictionaryElements = [[String:Any]]()
            for roomsElement in rooms {
                dictionaryElements.append(roomsElement.toDictionary())
            }
            dictionary["rooms"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        attribute = aDecoder.decodeObject(forKey: "attribute") as? [Attributes]
        currencyList = aDecoder.decodeObject(forKey: "currency_list") as? [AnyObject]
        message = aDecoder.decodeObject(forKey: "message") as? String ?? ""
        property = aDecoder.decodeObject(forKey: "property") as? [Propertys]
        rentalList = aDecoder.decodeObject(forKey: "rentalList") as? [RentalLists]
        rooms = aDecoder.decodeObject(forKey: "rooms") as? [Rooms]
        status = aDecoder.decodeObject(forKey: "status") as? Int ?? 0
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if attribute != nil{
            aCoder.encode(attribute, forKey: "attribute")
        }
        if currencyList != nil{
            aCoder.encode(currencyList, forKey: "currency_list")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if property != nil{
            aCoder.encode(property, forKey: "property")
        }
        if rentalList != nil{
            aCoder.encode(rentalList, forKey: "rentalList")
        }
        if rooms != nil{
            aCoder.encode(rooms, forKey: "rooms")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
    }
}
