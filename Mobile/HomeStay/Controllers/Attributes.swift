//
//  Attribute.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on February 7, 2019

import Foundation


class Attributes : NSObject, NSCoding{

    var optionId : Int!
    var optionName : String!
    var options : [OptionsNew]!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        optionId = dictionary["option_id"] as? Int
        optionName = dictionary["option_name"] as? String
        options = [OptionsNew]()
        if let optionsArray = dictionary["options"] as? [[String:Any]]{
            for dic in optionsArray{
                let value = OptionsNew(fromDictionary: dic)
                options.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if optionId != nil{
            dictionary["option_id"] = optionId
        }
        if optionName != nil{
            dictionary["option_name"] = optionName
        }
        if options != nil{
            var dictionaryElements = [[String:Any]]()
            for optionsElement in options {
                dictionaryElements.append(optionsElement.toDictionary())
            }
            dictionary["options"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        optionId = aDecoder.decodeObject(forKey: "option_id") as? Int
        optionName = aDecoder.decodeObject(forKey: "option_name") as? String
        options = aDecoder.decodeObject(forKey: "options") as? [OptionsNew]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if optionId != nil{
            aCoder.encode(optionId, forKey: "option_id")
        }
        if optionName != nil{
            aCoder.encode(optionName, forKey: "option_name")
        }
        if options != nil{
            aCoder.encode(options, forKey: "options")
        }
    }
}
