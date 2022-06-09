//
//  Service.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 28, 2018

import Foundation


class Service : NSObject, NSCoding{

    var serviceType : String!
    var serviceValue : Float!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        serviceType = dictionary["service_type"] as? String
        serviceValue = dictionary["service_value"] as? Float
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if serviceType != nil{
            dictionary["service_type"] = serviceType
        }
        if serviceValue != nil{
            dictionary["service_value"] = serviceValue
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        serviceType = aDecoder.decodeObject(forKey: "service_type") as? String
        serviceValue = aDecoder.decodeObject(forKey: "service_value") as? Float
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if serviceType != nil{
            aCoder.encode(serviceType, forKey: "service_type")
        }
        if serviceValue != nil{
            aCoder.encode(serviceValue, forKey: "service_value")
        }
    }
}
