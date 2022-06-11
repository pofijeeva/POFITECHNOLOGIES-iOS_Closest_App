//
//  RentYourSpaceModel.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 10/08/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

//MARK:- Rent your Space
class RentYourSpaceModel : NSObject, NSCoding {
    
    var attribute : [Attribute]!
    var currency : [Currency]!
    var message : String = ""
    var property : [Property]!
    var propertyAttributes : [PropertyAttribute]!
    var propertyid : Int = 0
    var result : [Result]!
    var rooms : [Room]!
    var status : Int = 0
    var baseid: AnyObject!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        message = dictionary["message"] as? String ?? ""
        let data = dictionary["data"] as? [String: Any]
        let step = data?["step1"] as? [String: Any]
        propertyid = step?["propertyid"] as? Int ?? 0
        status = dictionary["status"] as? Int ?? 0
        baseid = dictionary["base_id"] as AnyObject
        attribute = [Attribute]()
        if let attributeArray = dictionary["attribute"] as? [[String:Any]]{
            for dic in attributeArray{
                let value = Attribute(fromDictionary: dic)
                attribute.append(value)
            }
        }
        currency = [Currency]()
        if let currencyArray = dictionary["currency"] as? [[String:Any]]{
            for dic in currencyArray{
                let value = Currency(fromDictionary: dic)
                currency.append(value)
            }
        }
        property = [Property]()
        if let propertyArray = dictionary["property"] as? [[String:Any]]{
            for dic in propertyArray{
                let value = Property(fromDictionary: dic)
                property.append(value)
            }
        }

        propertyAttributes = [PropertyAttribute]()
        if let propertyAttributesArray = data?["listings"] as? [[String:Any]]{
            for dic in propertyAttributesArray {
                let value = PropertyAttribute(fromDictionary: dic)
                propertyAttributes.append(value)
            }
        }
        result = [Result]()
        if let resultArray = data {
            let value = Result(fromDictionary: resultArray)
            result.append(value)
        }
        rooms = [Room]()
        if let roomsArray = dictionary["rooms"] as? [[String:Any]]{
            for dic in roomsArray{
                let value = Room(fromDictionary: dic)
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
        if propertyid != nil{
            dictionary["propertyid"] = propertyid
        }
        if status != nil{
            dictionary["status"] = status
        }
        if baseid != nil {
            dictionary["base_id"] = baseid
        }
        if attribute != nil{
            var dictionaryElements = [[String:Any]]()
            for attributeElement in attribute {
                dictionaryElements.append(attributeElement.toDictionary())
            }
            dictionary["attribute"] = dictionaryElements
        }
        if currency != nil{
            var dictionaryElements = [[String:Any]]()
            for currencyElement in currency {
                dictionaryElements.append(currencyElement.toDictionary())
            }
            dictionary["currency"] = dictionaryElements
        }
        if property != nil{
            var dictionaryElements = [[String:Any]]()
            for propertyElement in property {
                dictionaryElements.append(propertyElement.toDictionary())
            }
            dictionary["property"] = dictionaryElements
        }
        if propertyAttributes != nil{
            var dictionaryElements = [[String:Any]]()
            for propertyAttributesElement in propertyAttributes {
                dictionaryElements.append(propertyAttributesElement.toDictionary())
            }
            dictionary["propertyAttributes"] = dictionaryElements
        }
        if result != nil{
            var dictionaryElements = [[String:Any]]()
            for resultElement in result {
                dictionaryElements.append(resultElement.toDictionary())
            }
            dictionary["result"] = dictionaryElements
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
        attribute = aDecoder.decodeObject(forKey: "attribute") as? [Attribute]
        currency = aDecoder.decodeObject(forKey: "currency") as? [Currency]
        message = aDecoder.decodeObject(forKey: "message") as? String ?? ""
        property = aDecoder.decodeObject(forKey: "property") as? [Property]
        propertyAttributes = aDecoder.decodeObject(forKey: "property_attributes") as? [PropertyAttribute]
        propertyid = aDecoder.decodeObject(forKey: "propertyid") as? Int ?? 0
        result = aDecoder.decodeObject(forKey: "result") as? [Result]
        rooms = aDecoder.decodeObject(forKey: "rooms") as? [Room]
        status = aDecoder.decodeObject(forKey: "status") as? Int ?? 0
        baseid = aDecoder.decodeObject(forKey: "base_id") as AnyObject
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
        if currency != nil{
            aCoder.encode(currency, forKey: "currency")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if property != nil{
            aCoder.encode(property, forKey: "property")
        }
        if propertyAttributes != nil{
            aCoder.encode(propertyAttributes, forKey: "property_attributes")
        }
        if propertyid != nil{
            aCoder.encode(propertyid, forKey: "propertyid")
        }
        if result != nil{
            aCoder.encode(result, forKey: "result")
        }
        if rooms != nil{
            aCoder.encode(rooms, forKey: "rooms")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if baseid != nil {
             aCoder.encode(baseid, forKey: "base_id")
        }
    }
}

