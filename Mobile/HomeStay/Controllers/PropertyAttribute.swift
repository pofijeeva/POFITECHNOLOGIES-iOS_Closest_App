//
//  PropertyAttribute.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on August 10, 2018

import Foundation


class PropertyAttribute : NSObject, NSCoding{

    var attributeId : Int!
    var attributeLabel : String!
    var attributeName : String!
    var attributeType : String!
    var attributeValue : [Attributevalue]!
    var usePropertyAttribute : Bool!
    
    var host_req : Int!
    var list_id : Int!
    var list_name : String!

    
    

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        attributeId = dictionary["attribute_id"] as? Int ?? 0
        attributeLabel = dictionary["attribute_label"] as? String ?? ""
        attributeName = dictionary["attribute_name"] as? String ?? ""
        attributeType = dictionary["attribute_type"] as? String ?? ""
        usePropertyAttribute = dictionary["use_property_attribute"] as? Bool ?? false
        attributeValue = [Attributevalue]()
        if let attributeArray = dictionary["attribute_value"] as? [[String:Any]]{
            for dic in attributeArray{
                let value = Attributevalue(fromDictionary: dic)
                attributeValue.append(value)
            }
        }
        
        host_req = dictionary["host_req"] as? Int ?? 0
        list_id = dictionary["list_id"] as? Int ?? 0
        list_name = dictionary["list_name"] as? String ?? ""
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if attributeId != nil{
            dictionary["attribute_id"] = attributeId
        }
        if attributeLabel != nil{
            dictionary["attribute_label"] = attributeLabel
        }
        if attributeName != nil{
            dictionary["attribute_name"] = attributeName
        }
        if attributeType != nil{
            dictionary["attribute_type"] = attributeType
        }
        if usePropertyAttribute != nil{
            dictionary["use_property_attribute"] = usePropertyAttribute
        }
        if attributeValue != nil {
            var dictionaryElements = [[String:Any]]()
            for roomsElement in attributeValue {
                dictionaryElements.append(roomsElement.toDictionary())
            }
            dictionary["attribute_value"] = dictionaryElements
        }
        
        if host_req != nil{
            dictionary["host_req"] = host_req
        }
        if list_id != nil{
            dictionary["list_id"] = list_id
        }
        if list_name != nil{
            dictionary["list_name"] = list_name
        }
        
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        attributeId = aDecoder.decodeObject(forKey: "attribute_id") as? Int ?? 0
        attributeLabel = aDecoder.decodeObject(forKey: "attribute_label") as? String ?? ""
        attributeName = aDecoder.decodeObject(forKey: "attribute_name") as? String ?? ""
        attributeType = aDecoder.decodeObject(forKey: "attribute_type") as? String ?? ""
        attributeValue = aDecoder.decodeObject(forKey: "attribute_value") as? [Attributevalue]
        usePropertyAttribute = aDecoder.decodeObject(forKey: "use_property_attribute") as? Bool ?? false
        host_req = aDecoder.decodeObject(forKey: "host_req") as? Int ?? 0
        list_id = aDecoder.decodeObject(forKey: "list_id") as? Int ?? 0
        list_name = aDecoder.decodeObject(forKey: "list_name") as? String ?? ""
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if attributeId != nil{
            aCoder.encode(attributeId, forKey: "attribute_id")
        }
        if attributeLabel != nil{
            aCoder.encode(attributeLabel, forKey: "attribute_label")
        }
        if attributeName != nil{
            aCoder.encode(attributeName, forKey: "attribute_name")
        }
        if attributeType != nil{
            aCoder.encode(attributeType, forKey: "attribute_type")
        }
        if attributeValue != nil{
            aCoder.encode(attributeValue, forKey: "attribute_value")
        }
        if usePropertyAttribute != nil{
            aCoder.encode(usePropertyAttribute, forKey: "use_property_attribute")
        }
        
        if host_req != nil{
            aCoder.encode(host_req, forKey: "host_req")
        }
        if list_id != nil{
            aCoder.encode(list_id, forKey: "list_id")
        }
        if list_name != nil{
            aCoder.encode(list_name, forKey: "list_name")
        }
    }
}

