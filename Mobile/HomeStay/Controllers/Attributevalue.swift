//
//  RootClass.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on August 16, 2018

import Foundation


class Attributevalue : NSObject, NSCoding{

    var attributeChildId : Int!
    var attributeChildValue : String!
    var attributeParentName : String!
    var list_id : Int!
    var list_val_id : Int!
    var list_val_name : String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        attributeChildId = dictionary["attribute_child_id"] as? Int ?? 0
        attributeChildValue = dictionary["attribute_child_value"] as? String ?? ""
        attributeParentName = dictionary["attribute_parent_name"] as? String ?? ""
        list_id = dictionary["list_id"] as? Int ?? 0
        list_val_id = dictionary["list_val_id"] as? Int ?? 0
        list_val_name = dictionary["list_val_name"] as? String ?? ""
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if attributeChildId != nil{
            dictionary["attribute_child_id"] = attributeChildId
        }
        if attributeChildValue != nil{
            dictionary["attribute_child_value"] = attributeChildValue
        }
        if attributeParentName != nil{
            dictionary["attribute_parent_name"] = attributeParentName
        }
        
        if list_id != nil{
            dictionary["list_id"] = list_id
        }
        if list_val_id != nil{
            dictionary["list_val_id"] = list_val_id
        }
        if list_val_name != nil{
            dictionary["list_val_name"] = list_val_name
        }
            
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        attributeChildId = aDecoder.decodeObject(forKey: "attribute_child_id") as? Int ?? 0
        attributeChildValue = aDecoder.decodeObject(forKey: "attribute_child_value") as? String ?? ""
        attributeParentName = aDecoder.decodeObject(forKey: "attribute_parent_name") as? String ?? ""
        list_id = aDecoder.decodeObject(forKey: "list_id") as? Int ?? 0
        list_val_id = aDecoder.decodeObject(forKey: "list_val_id") as? Int ?? 0
        list_val_name = aDecoder.decodeObject(forKey: "list_val_name") as? String ?? ""
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if attributeChildId != nil{
            aCoder.encode(attributeChildId, forKey: "attribute_child_id")
        }
        if attributeChildValue != nil{
            aCoder.encode(attributeChildValue, forKey: "attribute_child_value")
        }
        if attributeParentName != nil{
            aCoder.encode(attributeParentName, forKey: "attribute_parent_name")
        }
        if list_id != nil{
            aCoder.encode(list_id, forKey: "list_id")
        }
        if list_val_id != nil{
            aCoder.encode(list_val_id, forKey: "list_val_id")
        }
        if list_val_name != nil{
            aCoder.encode(list_val_name, forKey: "list_val_name")
        }
    }
}


