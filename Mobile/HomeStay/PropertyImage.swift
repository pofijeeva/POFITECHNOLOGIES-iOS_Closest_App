//
//  PropertyImage.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 17, 2018

import Foundation


class PropertyImage : NSObject, NSCoding{

    var propertyImage : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        propertyImage = dictionary["property_image"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if propertyImage != nil{
            dictionary["property_image"] = propertyImage
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        propertyImage = aDecoder.decodeObject(forKey: "property_image") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if propertyImage != nil{
            aCoder.encode(propertyImage, forKey: "property_image")
        }
    }
}